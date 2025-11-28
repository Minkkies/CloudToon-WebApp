/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/BookmarkServlet")
public class BookmarkServlet extends HttpServlet {

    //private static final long serialVersionUID = 1L;//ใช้ระบุว่า “ข้อมูลที่บันทึกไว้ มาจากรุ่นของคลาสเวอร์ชันไหน”
    //คำว่า implements Serializable หมายถึง คลาสนี้สามารถ “บันทึกเป็นไฟล์” แล้ว “โหลดกลับมาใช้ใหม่” ได้
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ตั้งค่า encoding และ content type (สำคัญมาก!)
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        // ดึง id การ์ตูนจาก request
        String cartoonIdStr = request.getParameter("id");
        int cartoonId;
        try {
            cartoonId = Integer.parseInt(cartoonIdStr);
        } catch (NumberFormatException e) {
            response.getWriter().write("ID การ์ตูนไม่ถูกต้อง");
            return;
        }

        // ดึง userId จาก session
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.getWriter().write("กรุณาเข้าสู่ระบบก่อน");
            return;
        }

        Connection conn = null;
        PreparedStatement pstCheck = null;
        PreparedStatement pstDelete = null;
        PreparedStatement pstInsert = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = new connectDB.MyCon().myConnect();

            //เช็คว่ามีการติดตามอยู่แล้วหรือไม่  แค่ตรวจสอบว่ามีแถวที่ตรงเงื่อนไขหรือไม่
            pstCheck = conn.prepareStatement(
                    "SELECT 1 FROM bookmark WHERE id_member=? AND id_cartoon=?"
            );
            pstCheck.setInt(1, userId);
            pstCheck.setInt(2, cartoonId);
            rs = pstCheck.executeQuery();

            if (rs.next()) {
                // ถ้ามีแล้ว → ลบ
                pstDelete = conn.prepareStatement(
                        "DELETE FROM bookmark WHERE id_member=? AND id_cartoon=?"
                );
                pstDelete.setInt(1, userId);
                pstDelete.setInt(2, cartoonId);
                pstDelete.executeUpdate();
                response.getWriter().write("ลบออกจากชั้นหนังสือเรียบร้อย");
            } else {
                // ถ้าไม่มี → เพิ่ม
                pstInsert= conn.prepareStatement(
                        "INSERT INTO bookmark (id_member, id_cartoon) VALUES (?, ?)"
                );
                pstInsert.setInt(1, userId);
                    pstInsert.setInt(2, cartoonId);
                    pstInsert.executeUpdate();
                    response.getWriter().write("เพิ่มสู่ชั้นหนังสือเรียบร้อย");
            }

       } catch (IOException | ClassNotFoundException | SQLException e) {
            response.getWriter().write("เกิดข้อผิดพลาด: " + e.getMessage());
        }
    }
}
