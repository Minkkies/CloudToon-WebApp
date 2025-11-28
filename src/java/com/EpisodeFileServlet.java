/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
/**
 *
 * @author Admin
 */
@WebServlet("/EpisodeFileServlet")
public class EpisodeFileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String episodeNumStr = request.getParameter("epNum");
        String idCartoonStr = request.getParameter("id_cartoon"); // เพิ่มรับการ์ตูนด้วย
        
        int episodeNum = Integer.parseInt(episodeNumStr);
        int idCartoon = Integer.parseInt(idCartoonStr);

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = new connectDB.MyCon().myConnect();

            String sql = "SELECT episode_file FROM episode WHERE cartoon_ref = ? AND episode_num = ?";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, idCartoon);      // cartoon_ref
            pst.setInt(2, episodeNum);     // episode_num
            rs = pst.executeQuery();

            if (rs.next()) {
                byte[] fileData = rs.getBytes("episode_file");
                if (fileData != null) {
                    response.setContentType("application/pdf");
                    response.setContentLength(fileData.length);

                    try (OutputStream out = response.getOutputStream()) {
                        out.write(fileData);
                        out.flush();
                    }
                }
            }
        } catch (IOException | ClassNotFoundException | SQLException e) {
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (pst != null) pst.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
    }
}
