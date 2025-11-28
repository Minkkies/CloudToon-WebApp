<%-- 
    Document   : index
    Created on : Sep 24, 2025, 10:11:14 PM
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
    // ตรวจสอบ session
        //HttpSession session = request.getSession(false);
    if(session == null || session.getAttribute("id_member") == null){
        response.sendRedirect("login.html");
        out.print("expired");
        return;
    }else {
                out.print("active");
            }
           
    int id_member = (Integer) session.getAttribute("id_member");
    String username = (String) session.getAttribute("username");
%>

    </body>
</html>
