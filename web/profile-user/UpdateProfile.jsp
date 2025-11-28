<%-- 
    Document   : UpdateProfile
    Created on : Oct 1, 2025, 4:13:05 PM
    Author     : Admin
--%>

<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="th">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>อัปเดตข้อมูลโปรไฟล์</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
      <%
    request.setCharacterEncoding("UTF-8");
    
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.html");
        return;
    }

    // ข้อมูลจากฟอร์ม
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String birthdate = request.getParameter("birthdate");
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    // email เดิมจาก session
    String oldEmail = (String) session.getAttribute("email");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        connectDB.MyCon m = new connectDB.MyCon();
        conn = m.myConnect();   // ✅ ใช้ conn ตัวเดียว

        // ถ้าต้องการเปลี่ยน password
        if (newPassword != null && !newPassword.isEmpty()) {
            if (!newPassword.equals(confirmPassword)) {
                out.println("<script>alert('รหัสผ่านใหม่ไม่ตรงกัน'); window.location='profile2.jsp';</script>");
                return;
            }

            // ตรวจสอบรหัสผ่านปัจจุบัน
            ps = conn.prepareStatement("SELECT password FROM register WHERE email=?");
            ps.setString(1, oldEmail);
            rs = ps.executeQuery();

            if (rs.next()) {
                String dbPass = rs.getString("password");
                if (!dbPass.equals(currentPassword)) {
                    out.println("<script>alert('รหัสผ่านปัจจุบันไม่ถูกต้อง'); window.location='profile2.jsp';</script>");
                    return;
                }
            }

            // อัปเดตพร้อมรหัสผ่าน
            //ใช้ WHERE email=? ได้ปกติ ถึง id จะเป็น PK ก็ไม่เป็นไร (แค่มั่นใจว่า email มี unique)
            ps = conn.prepareStatement(
                "UPDATE register SET username=?, email=?, phone_num=?, birthday=?, password=? WHERE email=?"
            );
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, birthdate);
            ps.setString(5, newPassword);
            ps.setString(6, oldEmail);

        } else {
            // อัปเดตไม่รวมรหัสผ่าน
            ps = conn.prepareStatement(
                "UPDATE register SET username=?, email=?, phone_num=?, birthday=? WHERE email=?"
            );
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, birthdate);
            ps.setString(5, oldEmail);
        }

        int updated = ps.executeUpdate();

        if (updated > 0) {
            // อัปเดต session
            session.setAttribute("username", username);
            session.setAttribute("email", email);
            session.setAttribute("phone", phone);
            session.setAttribute("birthdate", birthdate);

           out.println("<script>alert('อัปเดตข้อมูลเรียบร้อย'); window.location.href='../profile2.jsp';</script>");
        } else {
            out.println("<script>alert('ไม่สามารถอัปเดตข้อมูลได้'); window.history.back();</script>");
        }

    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if(rs!=null) rs.close(); } catch(Exception ex){}
        try { if(ps!=null) ps.close(); } catch(Exception ex){}
        try { if(conn!=null) conn.close(); } catch(Exception ex){}
    }
%>
    </body>
</html>
../../