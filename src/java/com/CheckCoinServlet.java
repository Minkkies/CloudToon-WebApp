/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.*;
import java.sql.*;
import org.json.JSONObject;

@WebServlet("/CheckCoinServlet")
public class CheckCoinServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
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
            
            // เชื่อมต่อ database
            Class.forName("com.mysql.cj.jdbc.Driver");
            connectDB.MyCon m = new connectDB.MyCon();
            Connection conn = m.myConnect();
            
            // ดึงยอดเหรียญของ user
            PreparedStatement pst = conn.prepareStatement(
                "SELECT coins FROM register WHERE id_member = ?"
            );
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            
            if (rs.next()) {
                int coins = rs.getInt("coins");
                result.put("success", true);
                result.put("coins", coins);
            } else {
                result.put("success", false);
                result.put("message", "ไม่พบข้อมูลผู้ใช้");
            }
 
            rs.close();
            pst.close();
            conn.close();
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "เกิดข้อผิดพลาด: " + e.getMessage());
            e.printStackTrace();
        }
        out.print(result.toString());
    }
}