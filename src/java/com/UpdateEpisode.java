package com;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
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
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/UpdateEpisode"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // ถ้าไฟล์ใหญ่กว่า 1MB จะถูกเขียนลง disk (ไม่เก็บใน memory)
        maxFileSize = 90 * 1024 * 1024, // ขนาดไฟล์สูงสุด 90MB
        maxRequestSize = 100 * 1024 * 1024 // ขนาด request ทั้งหมดสูงสุด 100MB (รวมไฟล์หลายไฟล์ได้)
)
public class UpdateEpisode extends HttpServlet {

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

        try {
            // รับค่าจาก form
            int id_episode = Integer.parseInt(request.getParameter("id"));
            int cartoonId = Integer.parseInt(request.getParameter("cartoonId"));
            int episodeNumber = Integer.parseInt(request.getParameter("episodeNumber"));
            String episodeTitle = request.getParameter("episodeTitle");
            String releaseDate = request.getParameter("releaseDate");
            int coinRequired = Integer.parseInt(request.getParameter("coinRequired"));

            Part filePart = request.getPart("episodeFile"); // optional
            InputStream fileContent = (filePart != null && filePart.getSize() > 0) ? filePart.getInputStream() : null;
//            String dbPath = null;
//
//            // ถ้ามีไฟล์ใหม่ ให้บันทึกลงโฟลเดอร์
//            if (fileName != null) {
//                String uploadDirPath = "D:/JraBraWeb/web/EpisodePDF";
//                File uploadDir = new File(uploadDirPath);
//                if (!uploadDir.exists()) {
//                    uploadDir.mkdirs();
//                }
//
//                // 2. path เต็มของไฟล์ที่จะบันทึก
//                 String filePath = uploadDirPath + File.separator + fileName;
//                 // บันทึกไฟล์ลงเซิร์ฟเวอร์
//                try (InputStream input = filePart.getInputStream(); FileOutputStream output = new FileOutputStream(filePath)) {
//                    byte[] buffer = new byte[1024];
//                    int bytesRead;
//                    while ((bytesRead = input.read(buffer)) != -1) {
//                        output.write(buffer, 0, bytesRead);
//                    }
//                }
//
//                dbPath = "EpisodePDF/" + fileName;
//            }

            // เชื่อมต่อฐานข้อมูล
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost/projectweb2204?allowPublicKeyRetrieval=true&useSSL=false",
                    "root", "mink20685")) {

                String sql;
                if (fileContent!= null) {
                    //ไฟล์ใหม่
                    sql = "UPDATE episode SET cartoon_ref=?, episode_num=?, episode_title=?, release_date=?, coin=?, episode_file=? WHERE id_episode=?";
                } else {
                    //ไฟล์เดิม
                    sql = "UPDATE episode SET cartoon_ref=?, episode_num=?, episode_title=?, release_date=?, coin=? WHERE id_episode=?";
                }

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, cartoonId);
                    ps.setInt(2, episodeNumber);
                    ps.setString(3, episodeTitle);
                    ps.setString(4, releaseDate);
                    ps.setInt(5, coinRequired);

                    if (fileContent != null) {
                        ps.setBlob(6, fileContent);
                        ps.setInt(7, id_episode);
                    } else {
                        ps.setInt(6, id_episode);
                    }

                    int updated = ps.executeUpdate();
                    if (updated > 0) {
                        response.getWriter().println("<script>alert('✅ Episode updated successfully'); window.location='./Back/episode/ShowEpisode.jsp';</script>");
                    } else {
                        response.getWriter().println("<script>alert('❌ Failed to update episode'); window.history.back();</script>");//กลับไปหน้าฟอร์มให้แก้
                    }
                }
            }

        } catch (ServletException | IOException | ClassNotFoundException | NumberFormatException | SQLException e) {
            response.getWriter().println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
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
        return "Short description";
    }// </editor-fold>

}
