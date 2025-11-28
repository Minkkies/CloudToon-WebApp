<%-- 
    Document   : DeleteEpisode
    Created on : Sep 24, 2025, 1:11:47 AM
    Author     : Admin
--%>

<%@page import="java.sql.*" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Episode</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");%>
        <%
            Connection conn = null;
            Statement s = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = new connectDB.MyCon().myConnect();
                s = conn.createStatement();

                String Id = request.getParameter("id");

                String sql = "Delete from packages_coin  WHERE packages_id = '" + Id + "' ";
                out.println(sql);
                s.execute(sql);
                out.println("Record Deleted Successfully");
                response.sendRedirect("ShowPackage.jsp");

            } catch (Exception e) {
                // TODO Auto-generated catch block
                out.println(e.getMessage());
                e.printStackTrace();
            }

            try {
                if (s != null) {
                    s.close();
                    conn.close();
                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                out.println(e.getMessage());
                e.printStackTrace();
            }
        %>
    </body>
</html>
