<%-- 
    Document   : ShowCategory
    Created on : Sep 22, 2025, 4:46:46 PM
    Author     : Admin
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=UTF-8"%>
<html>
    <head>
        <title>ข้อมูลหมวดหมู่</title>
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
                <h1 class="header-title">ตารางหมวดหมู่ทั้งหมด</h1>
                <table class="table table-hover table-bordered align-middle ">
                    <thead>
                        <tr class="table-info">
                            <th scope="col" class="align-center">ID</th>
                            <th  scope="col" class="align-center">ชื่อหมวดหมู่</th>
                            <th scope="col" class="align-center">Add & Delete Category</th>
                            <th scope="col" class="align-center">Add & Delete Cartoon Category</th>
                        </tr>
                    </thead>

                    <tbody class="table-group-divider">
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection(
                                        "jdbc:mysql://localhost/projectweb2204?allowPublicKeyRetrieval=true&useSSL=false",
                                        "root", "mink20685");
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM category");
                                while (rs.next()) {
                        %>
                        <tr>
                            <td scope="row"><%=rs.getInt("id_category")%></td>
                            <td scope="row"><%=rs.getString("name_category")%></td>
                            <td scope="row"> <a href="Category.jsp" target="_blank">Category</a> </td>
                            <td scope="row"> <a href="CartoonCategory.jsp" target="_blank">Cartoon Category</a></td>
                        </tr>
                        <%
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                out.println(e);
                            }
                        %>
                    </tbody>
                </table>
            </div>


            <div class="box">
                <h1 class="header-title">รายการการ์ตูนและหมวดหมู่</h1>
                <table class="table table-hover table-bordered align-middle ">
                    <thead >
                        <tr class="table-info">
                            <th scope="col" class="align-center">ID Cartoon:</th>
                            <th scope="col" class="align-center">Title</th>
                            <th scope="col" class="align-center">หมวดหมู่</th>
                        </tr>
                    </thead>
                    <tbody class="table-group-divider">
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection(
                                        "jdbc:mysql://localhost/projectweb2204?allowPublicKeyRetrieval=true&useSSL=false",
                                        "root", "mink20685"
                                );
                                Statement stmt = conn.createStatement();
                                String sql = "SELECT c.id_cartoon, c.title, c.status, c.short_story, c.cover, cat.name_category "
                                        + "FROM cartoon c "
                                        + "LEFT JOIN cartoon_category cc ON c.id_cartoon = cc.id_cartoon "
                                        + "LEFT JOIN category cat ON cc.id_category = cat.id_category "
                                        + "ORDER BY c.id_cartoon";
                                ResultSet rs = stmt.executeQuery(sql);
                                java.util.Base64.Encoder encoder = java.util.Base64.getEncoder();
                                while (rs.next()) {
                        %>
                        <tr>
                            <td scope="row"><%= rs.getInt("id_cartoon")%></td>
                            <td scope="row"><%= rs.getString("title")%></td>
                            <td scope="row"><%= rs.getString("name_category") != null ? rs.getString("name_category") : "-"%></td>
                        </tr>
                        <%
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                out.println(e.toString());
                            }
                        %>
                    </tbody>
                </table>
            </div>
    </body>
</html>
