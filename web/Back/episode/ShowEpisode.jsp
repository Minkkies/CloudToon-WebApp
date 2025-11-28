<%-- 
    Document   : ShowEpisode
    Created on : Sep 23, 2025, 5:46:33 PM
    Author     : Admin
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=UTF-8"%>
<html>
    <head>
        <title>ข้อมูลตอนการ์ตูน</title>
        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>
      <style>
            /*.align-center{
                padding-left: 2rem !important;
            }*/
            td a i{
                font-size: 24px;
                padding-left: 1.2rem !important;
            }

            td a i:hover{
                opacity: 0.5;
            }

        </style>
    </head>
    <body>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>
        <!------------------------------------ Header -------------------------------->
        <jsp:include page="../navBack/nav-admin.jsp"/>

            <div class="box my-6">
                <h1 class="header-title">จัดการข้อมูลตอนการ์ตูน</h1>
                <table class="table table-hover table-bordered align-middle ">
                    <thead>
                        <tr class="table-info">
                            <th scope="col" class="align-center">ID</th>
                            <th  scope="col" class="align-center">Cartoon Name</th>
                            <th  scope="col" class="align-center">ID Cartoon</th>
                            <th scope="col" class="align-center">Episode</th>
                            <th scope="col" class="align-center">Episode Name</th>
                            <th scope="col" class="align-center">Release Date</th>
                            <th scope="col" class="align-center">Coin Required</th>
                            <th scope="col" class="align-center">File PDF</th>
                            <th scope="col" class="align-center">Add</th>
                            <th scope="col" class="align-center">Edit</th>
                            <th scope="col" class="align-center">Delete</th>
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
                                ResultSet rs = stmt.executeQuery(
                                        "SELECT e.id_episode, e.cartoon_ref, c.title, "
                                        + "e.episode_num, e.episode_title, e.release_date, "
                                        + "e.coin, e.episode_file "
                                        + "FROM episode e " //ใช้ episode เป็นตารางหลัก และตั้ง alias ว่า e
                                        + "JOIN cartoon c ON e.cartoon_ref = c.id_cartoon "//เอาตาราง episode มาต่อกับตาราง cartoon โดยเงื่อนไขคือ cartoon_ref ใน episode ต้องตรงกับ id_cartoon ใน cartoon
                                        + "ORDER BY e.id_episode"
                                );

                                while (rs.next()) {
                        %>
                        <tr>
                            <td scope="row"><%= rs.getInt("id_episode")%></td>
                            <td scope="row"><%= rs.getString("title")%></td> <!-- ✅ เพิ่มชื่อการ์ตูน -->
                            <td scope="row"><%= rs.getInt("cartoon_ref")%></td>
                            <td scope="row"><%= rs.getInt("episode_num")%></td>
                            <td scope="row"><%= rs.getString("episode_title")%></td>
                            <td scope="row"><%= rs.getDate("release_date")%></td>
                            <td scope="row"><%= rs.getInt("coin")%></td>

                            <td scope="row">
                                <a href="ViewEpisodePDF.jsp?id=<%= rs.getInt("id_episode")%>" target="_blank">เปิด PDF</a>
                            </td>

                            <td scope="row"> 
                                <a href="AddEpisodeForm.jsp?id=<%=rs.getString("id_episode")%> "  target="_blank" ><i class="bi bi-plus"></i></a>
                            </td>

                            <td scope="row"> 
                                <a href="EditEpisodeForm.jsp?id=<%=rs.getString("id_episode")%> " target="_blank" ><i class="bi bi-pencil-fill"></i> </a>
                            </td>

                            <td scope="row">
                                <a href="DeleteEpisode.jsp?id=<%=rs.getString("id_episode")%>" onclick="return confirm('⚠️ คุณแน่ใจหรือไม่ที่จะลบข้อมูลนี้?')">
                                    <i class="bi bi-trash3-fill"></i>
                                </a>
                            </td>
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
    </body>
</html>
