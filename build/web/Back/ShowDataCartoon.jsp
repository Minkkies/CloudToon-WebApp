<%-- 
    Document   : showDataDB
    Created on : Sep 5, 2024, 1:09:03 PM
    Author     : chouv
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns:h="jakarta.faces.html" xmlns:f="jakarta.faces.core">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ข้อมูลการ์ตูน</title>
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
        <jsp:include page="navBack/nav-admin.jsp"/>

            <div class="box my-6">
                <h1 class="header-title">ข้อมูลการ์ตูน</h1>
                <table class="table table-hover table-bordered align-middle ">
                    <thead>
                        <tr class="table-info">
                            <th scope="col" class="align-center">ID</th>
                            <th  scope="col" class="align-center">Title</th>
                            <th scope="col" class="align-center">Status</th>
                            <th scope="col" class="align-center">Short Story</th>
                            <th scope="col" class="align-center">Cover</th>
                            <th scope="col" class="align-center">Add</th>
                            <th scope="col" class="align-center">Edit</th>
                            <th scope="col" class="align-center">Delete</th>
                        </tr>
                    </thead>


                    <tbody class="table-group-divider">

                        <%
                            try {
                                connectDB.MyCon m = new connectDB.MyCon(); //อันนี้เรียกใช้การเชื่อมต่อที่อีกpackages นึง ไฟล์เดียวใช้เชื่อม connectDB ได้หมด
                                try {
                                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                                } catch (Exception e) {
                                }
                                try {
                                    Connection c = m.myConnect();
                                    Statement s = c.createStatement();
                                    ResultSet r = s.executeQuery("Select * from projectweb2204.cartoon");
                                    //out.print("**********************************************************<br>");
                                    //out.print("     ID        Title    Status     Short Story     <br>");
                                    //out.print("**********************************************************<br>");
                                    java.util.Base64.Encoder encoder = java.util.Base64.getEncoder();
                                    while (r.next()) {
                        %>
                        <tr>
                            <td><%=r.getString("id_cartoon")%></td>
                            <td><%=r.getString("title")%></td>
                            <td><%=r.getString("status")%></td>
                            <td><%=r.getString("short_story")%></td>

                            <td >
                                <%
                                    byte[] imgData = r.getBytes("cover");
                                    String base64Image = encoder.encodeToString(imgData);
                                %>
                                <img src="data:image/jpeg;base64,<%= base64Image%>" alt="bak Image" style="width: 150px; height: auto;">
                            </td>

                            <td scope="row">
                                <a href="Cartoon.jsp?#Add" target="_blank">
                                    <i class="bi bi-plus"></i>
                                </a> 
                            </td>
                            <td scope="row"> 
                                <a href="EditForm.jsp?id_cartoon=<%=r.getString("id_cartoon")%>">
                                    <i class="bi bi-pencil-fill"></i>
                                </a>
                            </td>

                            <td scope="row"> 
                                <a href="Cartoon.jsp?#Delete" target="_blank">
                                    <i class="bi bi-trash3-fill"></i>
                                </a>
                            </td>
                        </tr>
                        <%
                                        //    out.print("  " + r.getString("Id") + "   " + r.getString("Name") + "     " + r.getString("Surname")
                                        //            + "        " + r.getString("Address") + "<br>");

                                    }
                                    s.close();
                                    r.close();
                                } catch (SQLException e) {
                                    out.print(e);
                                }
                            } finally {
                                out.close();
                            }
                        %>
                    </tbody>
                </table>
            </div>
    </body>
</html>
