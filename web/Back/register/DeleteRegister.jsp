<%-- 
    Document   : DeleteRegister
    Created on : Sep 22, 2025, 8:46:26 PM
    Author     : Admin
--%>

<%@page import="java.sql.*" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
                //   response.setContentType("text/xml;charset=UTF-8");
                request.setCharacterEncoding("UTF-8");%>
        <%
            request.setCharacterEncoding("UTF-8");
            Connection connect = null;
            Statement s = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");

                connect = DriverManager.getConnection("jdbc:mysql://localhost/projectweb2204?autoReconnect=true&useSSL=false", "root", "mink20685");

                s = connect.createStatement();

                String Id = request.getParameter("id");

                String sql = "Delete from register  WHERE id_member = '" + Id + "' ";
                out.println(sql);
                s.execute(sql);
                out.println("Record Deleted Successfully");
                response.sendRedirect("ShowRegister.jsp");

            } catch (Exception e) {
                // TODO Auto-generated catch block
                out.println(e.getMessage());
                e.printStackTrace();
            }

            try {
                if (s != null) {
                    s.close();
                    connect.close();
                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                out.println(e.getMessage());
                e.printStackTrace();
            }
        %>
    </body>
</html>
