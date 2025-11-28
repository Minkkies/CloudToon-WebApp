<%-- 
    Document   : logout
    Created on : Sep 24, 2025, 10:00:55 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
             // ดึงค่า email จาก session ก่อน
            String email = (String) session.getAttribute("email");
            String role = (String) session.getAttribute("role");
      
            /*session.invalidate(); คือคำสั่งที่ใช้ “ทำลาย (ยกเลิก)” session ปัจจุบันทั้งหมดของผู้ใช้ “ลบข้อมูลทุกอย่างใน session” */
            
           // ถ้ายังไม่ได้ login
            if (email == null) {
                out.println("<script>alert('กรุณาเข้าสู่ระบบก่อน'); window.location='login.html';</script>");
                return;
            } else {
                // ถ้า login อยู่ → ทำการ logout
                if(role!=null){
                session.invalidate();
                out.println("<script>alert('Logout สำเร็จ'); window.location='index.jsp';</script>");
                 }
              }   
      
        %>
    </body>
</html>
