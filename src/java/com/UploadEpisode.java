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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UploadEpisode", urlPatterns = {"/UploadEpisode"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // ถ้าไฟล์ใหญ่กว่า 1MB จะถูกเขียนลง disk (ไม่เก็บใน memory)
        maxFileSize = 90 * 1024 * 1024, // ขนาดไฟล์สูงสุด 90MB
        maxRequestSize = 100 * 1024 * 1024 // ขนาด request ทั้งหมดสูงสุด 100MB (รวมไฟล์หลายไฟล์ได้)
)
public class UploadEpisode extends HttpServlet {

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

        // ตั้ง encoding ให้รองรับ UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        Connection conn ;
        PreparedStatement pstmt ;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost/projectweb2204?allowPublicKeyRetrieval=true&useSSL=false",
                    "root",
                    "mink20685"
            );

            // รับค่าจาก form ค่าที่รับจากฟอร์มจะเป็น String เสมอ
            String cartoonIdStr = request.getParameter("cartoonId");
            String episodeNumberStr = request.getParameter("episodeNumber");
            String coinRequiredStr = request.getParameter("coinRequired");
            String episodeTitle = request.getParameter("episodeTitle");
            String releaseDate = request.getParameter("releaseDate");
            Part filePart = request.getPart("episodeFile");

            // ตรวจสอบ null ก่อน parse
            if (cartoonIdStr == null || episodeNumberStr == null || coinRequiredStr == null
                    || episodeTitle == null || releaseDate == null || filePart == null) {
                response.getWriter().println("<script>alert('❌ Please fill all fields'); window.location='/Back/episode/AddEpisodeForm.jsp';</script>");
                return;
            }

            // แปลงเป็น int ก่อนเก็บในฐานข้อมูล ต้องแปลงจาก String → int ก่อนนำไป pstmt.setInt(...)
            // request.getParameter("cartoonId") → คืนค่า String จากฟอร์ม
            // เราใช้ Integer.parseInt(...) แปลงเป็น int
            // แล้วถึงเอาไปใส่ pstmt.setInt(1, cartoonId) ซึ่งฐานข้อมูลฟิลด์นั้นเป็น INT
            int cartoonId = Integer.parseInt(cartoonIdStr);
            int episodeNumber = Integer.parseInt(episodeNumberStr);
            int coinRequired = Integer.parseInt(coinRequiredStr);

            // ตรวจสอบประเภทไฟล์
            if (!filePart.getContentType().equals("application/pdf")) {
                response.getWriter().println("<script>alert('❌ File must be a PDF'); window.location='/Back/episode/AddEpisodeForm.jsp';</script>");
                return;
            }

//            // ตรวจสอบขนาดไฟล์ (90MB)
//            if (filePart.getSize() > 90 * 1024 * 1024) {
//                response.getWriter().println("<script>alert('❌ File too large (Max 90MB)'); window.location='/Back/episode/AddEpisodeForm.jsp';</script>");
//                return;
//            }
//
//            // โฟลเดอร์เก็บไฟล์บน server
//            // กำหนด folder เก็บไฟล์บน server (สร้างไว้ก่อน)
//            // โฟลเดอร์เก็บไฟล์บน server (สร้างไว้ก่อน)
//            // 1. กำหนดโฟลเดอร์เก็บไฟล์ PDF บนเครื่อง server ก็เครื่องผมนี่แหละจะเครื่องใคร
//            String uploadDirPath = "D:\\JraBraWeb\\web\\EpisodePDF"; // path absolute
//            File uploadDir = new File(uploadDirPath);
//            if (!uploadDir.exists()) {
//                uploadDir.mkdirs(); // สร้างโฟลเดอร์ถ้ายังไม่มี
//            }
//
//            // 2. path เต็มของไฟล์ที่จะบันทึก
//            String filePath = uploadDirPath + File.separator + fileName;
//            // บันทึกไฟล์ลงเซิร์ฟเวอร์
//            try (InputStream input = filePart.getInputStream(); FileOutputStream output = new FileOutputStream(filePath)) {
//                byte[] buffer = new byte[1024];
//                int bytesRead;
//                while ((bytesRead = input.read(buffer)) != -1) {
//                    output.write(buffer, 0, bytesRead);
//                }
//            }
//
//            // path สำหรับเก็บในฐานข้อมูล (ไม่ต้องใช้ getRealPath)
//            String dbPath = "EpisodePDF/" + fileName;

            // ใช้ InputStream ของไฟล์แทนการบันทึกลงโฟลเดอร์
            InputStream fileContent = filePart.getInputStream();

            String sql = "INSERT INTO episode "
                    + "(cartoon_ref, episode_num, episode_title, release_date, coin, episode_file) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            // ใส่ PreparedStatement = pstmt ใส่ค่า int ลงช่อง ?
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, cartoonId); //ชื่อตัวแปรที่ใช้รับมา
            pstmt.setInt(2, episodeNumber);
            pstmt.setString(3, episodeTitle);
            pstmt.setString(4, releaseDate);
            pstmt.setInt(5, coinRequired);
            pstmt.setBinaryStream(6, fileContent, (int) filePart.getSize()); // ใส่เป็น Binary Stream

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.getWriter().println("<script>alert('✅ file uploaded successfully!'); window.location='"
                        + request.getContextPath() + "/Back/episode/ShowEpisode.jsp';</script>");
            } else {
                response.getWriter().println("<script>alert('❌ Image upload failed.'); window.location='"
                        + request.getContextPath() + "/Back/episode/ShowEpisode.jsp';</script>");
            }

        } catch (ServletException | IOException | ClassNotFoundException | NumberFormatException | SQLException e) {
            response.getWriter().println("<script>alert('Error: " + e.getMessage() + "'); window.location='/Back/episode/AddEpisodeForm.jsp';</script>");
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
