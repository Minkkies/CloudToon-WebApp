<%-- 
    Document   : ViewEpisodePDF
    Created on : Sep 25, 2025, 1:27:35 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.io.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View PDF</title>
    </head>
    <body>
       <%
    int id = Integer.parseInt(request.getParameter("id"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost/projectweb2204?allowPublicKeyRetrieval=true&useSSL=false",
            "root", "mink20685");

        PreparedStatement ps = conn.prepareStatement(
            "SELECT episode_file FROM episode WHERE id_episode=?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            byte[] pdfData = rs.getBytes("episode_file");
            if (pdfData != null) {
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "inline; filename=episode_" + id + ".pdf");
                OutputStream os = response.getOutputStream();
                os.write(pdfData);
                os.flush();
                os.close();
            } else {
                out.println("❌ No PDF file found");
            }
        } else {
            out.println("❌ Episode not found");
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
    </body>
</html>
