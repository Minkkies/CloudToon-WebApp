package com;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.*;
import org.json.JSONObject;
import java.sql.*;

@WebServlet("/PayCoinServlet")
public class PayCoinServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");//ส่งข้อมูลแบบjson
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        JSONObject result = new JSONObject();

        try {
            // ตรวจสอบ session
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                result.put("success", false);
                result.put("message", "กรุณาเข้าสู่ระบบก่อน");
                return;
            }

            Integer userId = (Integer) session.getAttribute("userId");
            int cartoonId = Integer.parseInt(request.getParameter("id_cartoon"));
            int episodeNum = Integer.parseInt(request.getParameter("episode_num"));
            int coinRequired = Integer.parseInt(request.getParameter("coin_required"));

            // เชื่อมต่อ database
            Class.forName("com.mysql.cj.jdbc.Driver");
            connectDB.MyCon m = new connectDB.MyCon();
            Connection conn = m.myConnect();

            // เริ่ม transaction
            conn.setAutoCommit(false);

            try {
                // 1. ตรวจสอบว่าซื้อไปแล้วหรือยัง (Double check)
                PreparedStatement pstCheck = conn.prepareStatement(
                        "SELECT 1 FROM purchase_episode WHERE id_member = ? AND id_cartoon = ? AND episode_num = ?"
                );
                
                pstCheck.setInt(1, userId);
                pstCheck.setInt(2, cartoonId);
                pstCheck.setInt(3, episodeNum);
                ResultSet rsCheck = pstCheck.executeQuery();

                if (rsCheck.next()) {

                    result.put("success", true);
                    result.put("message", "คุณซื้อตอนนี้ไปแล้ว");
                    
                    rsCheck.close();
                    pstCheck.close();
                    conn.commit();
                    conn.close();
                    return;
                }

                // 2. ตรวจสอบยอดเหรียญ (FOR UPDATE)
                int currentCoins;
                try (PreparedStatement pstCoins = conn.prepareStatement(
                        "SELECT coins FROM register WHERE id_member = ? FOR UPDATE"
                )) {

                    pstCoins.setInt(1, userId);
                    try (ResultSet rsCoins = pstCoins.executeQuery()) {
                        if (!rsCoins.next()) {
                            throw new Exception("ไม่พบข้อมูลผู้ใช้");
                        }

                        currentCoins = rsCoins.getInt("coins");

                        // ตรวจสอบเหรียญพอหรือไม่
                        if (currentCoins < coinRequired) {
                            result.put("success", false);
                            result.put("message", "ยอดเหรียญไม่เพียงพอ");
                            result.put("currentCoins", +currentCoins);
                            result.put("requiredCoins", +coinRequired);

                            rsCoins.close();
                            pstCoins.close();
                            conn.rollback();
                            conn.close();
                            return;
                        }
                    }
                }

                // 3. หักเหรียญ
                int updated;
                try (
                        PreparedStatement pstDeduct = conn.prepareStatement(
                                "UPDATE register SET coins = coins - ? WHERE id_member = ?"
                        )) {
                            pstDeduct.setInt(1, coinRequired);
                            pstDeduct.setInt(2, userId);
                            updated = pstDeduct.executeUpdate();
                        }

                        if (updated == 0) {
                            throw new Exception("ไม่สามารถหักเหรียญได้");
                        } else {
                           int remainingCoins = currentCoins - coinRequired;

                            // ส่งผลลัพธ์สำเร็จ
                            result.put("success", true);
                            result.put("message", "จ่ายเหรียญสำเร็จ");
                            result.put("remainingCoins", remainingCoins);
                        }

                        // 4. บันทึกประวัติการซื้อ
                        try (
                                PreparedStatement pstPurchase = conn.prepareStatement(
                                        "INSERT INTO purchase_episode (id_member, id_cartoon, episode_num, coin_spent, purchase_date) "
                                        + "VALUES (?, ?, ?, ?, NOW())"
                                )) {
                                    pstPurchase.setInt(1, userId);
                                    pstPurchase.setInt(2, cartoonId);
                                    pstPurchase.setInt(3, episodeNum);
                                    pstPurchase.setInt(4, coinRequired);
                                    pstPurchase.executeUpdate();
                                }

                                // Commit transaction
                                conn.commit();

            } catch (SQLException e) {
                if (conn != null) {
                    conn.rollback();
                }
                throw e;
            } finally {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            }

        } catch (NumberFormatException e) {
            result.put("success", false);
            result.put("message", "รูปแบบข้อมูลไม่ถูกต้อง");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "เกิดข้อผิดพลาด: " + e.getMessage());
        }
        out.print(result.toString());
    }
}
