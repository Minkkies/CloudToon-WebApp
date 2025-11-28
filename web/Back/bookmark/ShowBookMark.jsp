<%-- 
    Document   : ShowBookMark
    Created on : Sep 22, 2025, 11:28:39 PM
    Author     : Admin
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns:h="jakarta.faces.html" xmlns:f="jakarta.faces.core">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>รายการบุ๊คมาร์ค</title>
        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>
      </head>
    <body>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>
        <!------------------------------------ Header -------------------------------->
        <jsp:include page="../navBack/nav-admin.jsp"/>

        
            <div class="box my-6">
                <h1 class="header-title">รายการบุ๊คมาร์คของผู้ใช้</h1>
                <table class="table table-hover table-bordered align-middle ">
                    <thead>
                        <tr class="table-info">
                            <th scope="col" class="align-center">ID User</th>
                            <th  scope="col" class="align-center">Username</th>
                            <th scope="col" class="align-center">Title</th>
                            <th scope="col" class="align-center">Cover</th>
                        </tr>
                    </thead>

                    <tbody class="table-group-divider">
                        <%
                            Connection con = null;
                            PreparedStatement pst = null;
                            ResultSet rs = null;

                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                con = DriverManager.getConnection(
                                        "jdbc:mysql://localhost/projectweb2204?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC",
                                        "root", "mink20685");

                                String sql = "SELECT b.id_member, r.username, c.title, c.cover "
                                        + "FROM bookmark b "
                                        + "JOIN register r ON b.id_member = r.id_member "
                                        + "JOIN cartoon c ON b.id_cartoon = c.id_cartoon "
                                        + "ORDER BY b.id_bookmark ASC";

                                pst = con.prepareStatement(sql);
                                rs = pst.executeQuery();
                                java.util.Base64.Encoder encoder = java.util.Base64.getEncoder();
                                while (rs.next()) {
                        %>
                        <tr>
                            <td scope="row"><%= rs.getInt("id_member")%></td>
                            <td scope="row"><%= rs.getString("username")%></td>
                            <td scope="row"><%= rs.getString("title")%></td>
                            <td  scope="row">
                                <%
                                    byte[] imgData = rs.getBytes("cover");
                                    String base64Image = encoder.encodeToString(imgData);
                                %>
                                <img src="data:image/jpeg;base64,<%= base64Image%>" alt="bak Image" style="width: 150px; height: auto;">
                            </td >  
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                                e.printStackTrace();
                            } finally {
                                try {
                                    if (rs != null) {
                                        rs.close();
                                    }
                                } catch (Exception e) {
                                }
                                try {
                                    if (pst != null) {
                                        pst.close();
                                    }
                                } catch (Exception e) {
                                }
                                try {
                                    if (con != null) {
                                        con.close();
                                    }
                                } catch (Exception e) {
                                }
                            }
                        %>
                    </tbody>
                </table>
          
        </div>
    </body>
</html>

