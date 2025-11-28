<%-- 
    Document   : EditEpisodeForm
    Created on : Sep 24, 2025, 1:20:12 AM
    Author     : Admin
--%>

<%@page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>แก้ไขตอนการ์ตูน</title>
        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>
        <!-- Bootstrap Icons --> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="../../stylesheet.css">
        <!--bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

        <!-- css -->
        <style>
            .button-insert {
                background-color: gray;
                border: none;
            }

            .button-update {
                background: gray;
                border: none;
            }

            .button-delete {
                margin-bottom: 10px;
                background: gray;
                border: none;
            }

            .button{
                margin-top: 15px;
            }
        </style>
    </head>

    <body>
        <!--bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>

        <div class="box">
            <h1 class="header-title">
                แก้ไขตอนการ์ตูน
            </h1>

            <!-- update -->
            <%
                //response.setContentType("text/xml;charset=UTF-8");
                request.setCharacterEncoding("UTF-8");
                Connection connect = null;
                Statement s = null;
                //    try {
                Class.forName("com.mysql.jdbc.Driver");
                connect = DriverManager.getConnection("jdbc:mysql://localhost/projectweb2204?autoReconnect=true&useSSL=false", "root", "mink20685");
                s = connect.createStatement();
                String sql = "SELECT * FROM  episode WHERE id_episode= '" + request.getParameter("id") + "'  ";
                //request.getParameter("id")  "id" คือตัวแปรที่แสดงอยู่ตรง Url
                //ซึ่งมันจะต้องตรงกับตอนที่เราลิ้งมาหน้านี้ ตัวแปรที่เก็บค่า id_episode ชื่อว่าอะไร
                ResultSet rs = s.executeQuery(sql);

                if (rs != null) {
                    rs.next();
            %>

            <div class="box">

                <!--Form Add Cartoon-->
                <div class="box">
                    <div class="item-box">
                        <div id="Add" class="frame-bg">

                            <!-- เพิ่มตอน -->
                            <h1 class="header-title">Edit Episode</h1>
                            <form action="/JraBraWeb/UpdateEpisode" method="post" enctype="multipart/form-data">

                                ID:
                                <input class="form-control" type="number" name="id" 
                                       value="<%=rs.getString("id_episode")%>"
                                       aria-label="default input example" readonly>

                                <label>Cartoon ID:</label>
                                <input class="form-control" type="number" name="cartoonId" required value="<%= rs.getInt("cartoon_ref")%>" placeholder="รหัสการ์ตูน">

                                <label>Episode Number:</label>
                                <input class="form-control" type="number" name="episodeNumber" required value="<%= rs.getInt("episode_num")%>" placeholder="ตอนการ์ตูน">

                                <label>Episode Title:</label>
                                <input class="form-control" type="text" name="episodeTitle" required value="<%= rs.getString("episode_title")%>" placeholder="ชื่อตอนการ์ตูน">

                                <label>Release Date:</label>
                                <input class="form-control" type="date" name="releaseDate" required value="<%= rs.getDate("release_date")%>" placeholder="วันที่ปล่อย">

                                <label>Coin Required:</label>
                                <input class="form-control" type="number" name="coinRequired" value="<%= rs.getInt("coin")%>" placeholder="เหรียญ">

                                Current File: <a href="ViewEpisodePDF.jsp?id=<%= rs.getInt("id_episode")%>" target="_blank">
                                    เปิด PDF
                                </a><br>
                                Upload New PDF (optional): <input class="form-control" type="file" name="episodeFile" >

                                <button class="button button-insert" type="submit" name="action" >Update</button>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!------------->

        <% } %>

        <% /*  } catch (Exception e) {
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
          }*/
        %>

    </body>
</html>