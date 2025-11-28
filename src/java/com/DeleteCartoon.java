/*
  Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DeleteCartoon", urlPatterns = {"/DeleteCartoon"})
public class DeleteCartoon extends HttpServlet {

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

        String id_cartoon = request.getParameter("id_cartoon"); // รับ ID ของสินค้าที่จะลบ

        Connection conn = null;
        PreparedStatement pstmt = null;

          try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/projectweb2204?allowPublicKeyRetrieval=true&useSSL=false", "root", "mink20685");

            String sql = "DELETE FROM cartoon WHERE id_cartoon = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id_cartoon);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.getWriter().println(
                                "<script>alert('✅ Image uploaded successfully!'); window.location='"
                                + request.getContextPath() + "/Back/ShowDataCartoon.jsp';</script>"
                        );
            } else {
                response.getWriter().println(
                        "<script>alert('❌ Product deletion failed. Product not found.'); window.location='"
                        + request.getContextPath() + "/Back/ShowDataCartoon.jsp';</script>"
                );
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println(
                    "<script>alert('Error: " + e.getMessage() + "'); window.location='"
                    + request.getContextPath() + "/Back/ShowDataCartoon.jsp';</script>"
            );
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
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for deleting stock items";
    }// </editor-fold>
}