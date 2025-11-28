/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddCartoonCategory", urlPatterns = {"/AddCartoonCategory"})
public class AddCartoonCategory extends HttpServlet {

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

        String idCartoon = request.getParameter("id_cartoon");
        String idCategory = request.getParameter("id_category");// ดึงค่าจาก dropdown

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/projectweb2204?allowPublicKeyRetrieval=true&useSSL=false", "root", "mink20685");

            String sql = "INSERT INTO cartoon_category(id_cartoon, id_category) VALUES(?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(idCartoon));
            pstmt.setInt(2, Integer.parseInt(idCategory));

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                //response.getWriter().println("Image uploaded successfully!");
                response.sendRedirect("./Back/category/ShowCategory.jsp");
            } else {
                response.getWriter().println("Upload failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
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
