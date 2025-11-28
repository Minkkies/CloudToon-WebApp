/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import java.sql.*;
import jakarta.servlet.http.Part;
import java.io.InputStream;

@MultipartConfig
/**
 *
 * @author Admin
 */
@WebServlet(name = "EditCartoon", urlPatterns = {"/EditCartoon"})
public class EditCartoon extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                   response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("UTF-8");
            String id_cartoon = request.getParameter("id"); // เพิ่มรับค่า id มาด้วย
            String name = request.getParameter("title"); //getParameter ต้องตรงกับ atb name ของ form
            String status = request.getParameter("status");
            String short_story= request.getParameter("short_story");
            Part filePart = request.getPart("cover");

            try (InputStream photoContent = filePart.getInputStream()) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost/projectweb2204?allowPublicKeyRetrieval=true&useSSL=false", "root", "mink20685");
                    
                 String sql = "UPDATE cartoon SET title = ?, status = ?, short_story = ?, cover = ? WHERE id_cartoon = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, name); //(colที่, ตัวแปรที่ getParameter)
                    pstmt.setString(2, status);
                    pstmt.setString(3, short_story);
                    pstmt.setBinaryStream(4, photoContent, (int) filePart.getSize());
                    pstmt.setString(5, id_cartoon);   // set ค่าเดิมให้ id เพราะเรากำหนดใน from แล้วว่าไม่ให้แก้

                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        response.getWriter().println(
                                "<script>alert('✅ Image uploaded successfully!'); window.location='"
                                + request.getContextPath() + "/Back/ShowDataCartoon.jsp';</script>"
                        );

                    } else {
                         response.getWriter().println(
                                "<script>alert('❌ Image upload failed'); window.location='"
                                + request.getContextPath() + "/Back/ShowDataCartoon.jsp';</script>"
                        );
                    }
                   } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
//       String firstName = request.getParameter("firstName");
//            String lastName = request.getParameter("lastName");
//            Part filePart = request.getPart("photo"); 
//
//            try (InputStream photoContent = filePart.getInputStream()) {
//                Connection conn = null;
//                PreparedStatement pstmt = null;
//                try {
//                    Class.forName("com.mysql.cj.jdbc.Driver");
//                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "your_username", "your_password");
//
//                    String sql = "INSERT INTO contacts (first_name, last_name, photo) VALUES (?, ?, ?)";
//                    pstmt = conn.prepareStatement(sql);
//                    pstmt.setString(1, firstName);
//                    pstmt.setString(2, lastName);
//                    pstmt.setBinaryStream(3, photoContent, (int) filePart.getSize());
//
//                    int rowsAffected = pstmt.executeUpdate();
//                    if (rowsAffected > 0) {
//                        response.getWriter().println("Image uploaded successfully!");
//                    } else {
//                        response.getWriter().println("Image upload failed.");
//                    }
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    response.getWriter().println("Error: " + e.getMessage());
//                } 
//            }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}