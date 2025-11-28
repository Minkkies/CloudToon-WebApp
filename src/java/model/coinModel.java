/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;
import connectDB.MyCon;
import java.util.ArrayList;
import java.util.List;

/**
 * Model สำหรับจัดการข้อมูลการเติมเงิน (ระบบ MVC)
 */
public class coinModel {

    /**
     * คลาสเก็บข้อมูลแพ็คเกจ
     */
    public static class Package {

        private int packageId;
        private String packageName;
        private int price;
        private int coins;
        private int bonus;

        public Package(int packageId, String packageName, int price, int coins,int bonus) {
            this.packageId = packageId;
            this.packageName = packageName;
            this.price = price;
            this.coins = coins;
            this.bonus = bonus;
        }

        public int getPackageId() {
            return packageId;
        }
        
        public String getPackageName() {
            return packageName;
        }

        public int getPrice() {
            return price;
        }

        public int getCoins() {
            return coins;
        }
        
        public int getBonus() {
            return bonus;
        }
    }

      /**
     * คลาสเก็บข้อมูลประวัติ
     */
    public static class History {

        private int historyId; // รหัสประวัติ
        private int packageId;
        private int amount;  // จำนวนเงินที่จ่าย
        private int coins;   // จำนวนเหรียญที่ได้
        private String slipFile;
        private String paid;
        private String date;

        public History(int historyId, int packageId, int amount, int coins, String slipFile, String paid, String date) {
            this.historyId = historyId;
            this.packageId = packageId;
            this.amount = amount;
            this.coins = coins;
            this.slipFile = slipFile;
            this.paid = paid;
            this.date = date;
        }

        public int getHistoryId() {
            return historyId;
        }

        public int getPackageId() {
            return packageId;
        }

        public int getAmount() {
            return amount;
        }

        public int getCoins() {
            return coins;
        }

        public String getSlipFile() {
            return slipFile;
        }

        public String getPaid() {
            return paid;
        }

        public String getDate() {
            return date;
        }
    }

    
    /**
     * ดึงยอดเหรียญปัจจุบันของผู้ใช้ไปแสดงหน้าโปร
     */
    public int getUserCoins(int userId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        int coins = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = new MyCon().myConnect();

            String sql = "SELECT coins FROM register WHERE id_member=?";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, userId);
            rs = pst.executeQuery();

            if (rs.next()) {
                coins = rs.getInt("coins");
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return coins;
    }

    /**
     * อัปเดตยอดเหรียญของผู้ใช้เติมและอัปเลยซื้อก็เหมือนกัน
     */
    public boolean updateUserCoins(int userId, int coins) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement pst = null;
        boolean success = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = new MyCon().myConnect();

            String sql = "UPDATE register SET coins=? WHERE id_member=?";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, coins);
            pst.setInt(2, userId);

            success = pst.executeUpdate() > 0;
        } finally {
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return success;
    }

    /**
     * บันทึกประวัติการเติมเงิน
     */
    public boolean saveCoinHistory(int userId, int packageId, int price, int coins, String slipFile)
            throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement pst = null;
        boolean success = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = new MyCon().myConnect();

            String sql = "INSERT INTO coin_history (id_member, packages_id, amount, coins, slip, paid, created_date) "
                    + "VALUES (?, ?, ?, ?, ?, '1', NOW())";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, userId);
            pst.setInt(2, packageId);
            pst.setInt(3, price);
            pst.setInt(4, coins);
            pst.setString(5, slipFile);

            success = pst.executeUpdate() > 0;
        } finally {
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return success;
    }

    /**
     * ดำเนินการเติมเงินแบบ Transaction
     * ฟังก์ชันนี้คือการ “เติมเหรียญให้ผู้ใช้” โดยใช้ Transaction
     * เพื่อให้การ อัปเดตเหรียญ และ บันทึกประวัติ เกิดพร้อมกันอย่างปลอดภัย
     */
    public boolean ProcessCoin(int userId, int packageId, int price, int coins, byte[] slipBytes)
            throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement pstUpdate = null;
        PreparedStatement pstInsert = null;
        boolean success = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = new MyCon().myConnect();
            conn.setAutoCommit(false);/*บอก MySQL ว่าอย่า commit อัตโนมัติหลังคำสั่ง SQL แต่ละคำสั่ง
(เพราะโดยปกติ MySQL จะ commit ทุกครั้งหลัง executeUpdate())*/

            // 1. ดึงยอดเหรียญปัจจุบัน
            int currentCoins = getUserCoins(userId);
            int newCoins = currentCoins + coins;

            // 2. อัปเดตยอดเหรียญ
            String updateSQL = "UPDATE register SET coins=? WHERE id_member=?";
            pstUpdate = conn.prepareStatement(updateSQL);
            pstUpdate.setInt(1, newCoins);
            pstUpdate.setInt(2, userId);
            pstUpdate.executeUpdate();

            // 3. บันทึกประวัติ + BLOB
            String insertSQL = "INSERT INTO coin_history (id_member, packages_id, amount, coins, slip, paid, created_date) "
                    + "VALUES (?, ?, ?, ?, ?, '1', NOW())";
            pstInsert = conn.prepareStatement(insertSQL);
            pstInsert.setInt(1, userId);
            pstInsert.setInt(2, packageId);
            pstInsert.setInt(3, price);
            pstInsert.setInt(4, coins);
            pstInsert.setBytes(5, slipBytes); // <-- เก็บเป็น BLOB
            pstInsert.executeUpdate();

            conn.commit(); // ถ้าทุกอย่างสำเร็จยืนยัน Transaction 
            success = true;

        } catch (Exception e) {
            if (conn != null) {
                conn.rollback(); // ยกเลิก Transaction
            }
            throw e;
        } finally {
            if (pstUpdate != null) {
                pstUpdate.close();
            }
            if (pstInsert != null) {
                pstInsert.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }

        return success;
    }

    /**
     * ดึงข้อมูลแพ็คเกจตาม ID
     */
    public Package getPackageById(int packageId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        Package pkg = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = new MyCon().myConnect();

            String sql = "SELECT * FROM packages_coin WHERE packages_id=?";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, packageId);
            rs = pst.executeQuery();

            //ใช้ if — หมายความว่าอ่านข้อมูลจาก ResultSet แค่ แถวเดียวเท่านั้น
            if (rs.next()) {
                String packageName = rs.getString("packages_name");
                int price = rs.getInt("price");
                int coins = rs.getInt("coins");
                int bonus= rs.getInt("bonus");
                pkg = new Package(packageId,packageName, price, coins, bonus);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return pkg;
    }
    
     public static List<Package> getAllPackage() throws SQLException, ClassNotFoundException {
         List<Package> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = new MyCon().myConnect();

            String sql = "SELECT * FROM packages_coin";
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();

            //// ✅ ใช้ while เพื่ออ่านข้อมูลทุกแถว
            while (rs.next()) {
                int packageId = rs.getInt("packages_id");
                String packageName = rs.getString("packages_name");
                int price = rs.getInt("price");
                int coins = rs.getInt("coins");
                int bonus= rs.getInt("bonus");
                list.add(new Package(packageId,packageName, price, coins, bonus));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return list;
    }

    /**
     * ดึงประวัติการเติมเหรียญของผู้ใช้
     */
    public List<History> getUserHistory(int userId) throws Exception {
        List<History> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = new MyCon().myConnect();
            String sql = "SELECT * FROM coin_history WHERE id_member=? ORDER BY created_date DESC";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, userId);
            rs = pst.executeQuery();

            while (rs.next()) {
                int historyId = rs.getInt("history_id");
                int packageId = rs.getInt("packages_id");
                int amount = rs.getInt("amount");
                int coins = rs.getInt("coins");
                String slip = rs.getString("slip");
                String status = rs.getString("paid").equals("1") ? "สำเร็จ" : "รอดำเนินการ";
                String date = rs.getString("created_date");

                list.add(new History(historyId, packageId, amount, coins, slip, status, date));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return list;
    }

}
