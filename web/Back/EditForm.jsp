<%-- 
    Document   : EditForm
    Created on : Sep 12, 2025, 12:08:22 PM
    Author     : Admin
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>จัดการข้อมูลการ์ตูน</title>
        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>
        <!-- Bootstrap Icons --> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="../stylesheet.css">
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
                จัดการข้อมูลการ์ตูน
            </h1>
            <%
                //response.setContentType("text/xml;charset=UTF-8");
                request.setCharacterEncoding("UTF-8");
                Connection connect = null;
                Statement s = null;
                //    try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connect = DriverManager.getConnection("jdbc:mysql://localhost/projectweb2204?autoReconnect=true&useSSL=false", "root", "mink20685");
                s = connect.createStatement();
                String sql = "SELECT * FROM  cartoon WHERE id_cartoon= '" + request.getParameter("id_cartoon") + "'  ";
                ResultSet rec = s.executeQuery(sql);
                Base64.Encoder encoder = Base64.getEncoder();

                if (rec != null) {
                    rec.next();
            %>
        </div>
        <!--Form Add Cartoon-->
        <div class="box">
            <div class="item-box">
                <div id="Edit" class="frame-bg">
                    <h1>Edit</h1>
                    <form action="/JraBraWeb/EditCartoon" method="post" enctype="multipart/form-data">
                        ID:
                        <input class="form-control" type="number" name="id" 
                               value="<%=rec.getString("id_cartoon")%>"
                               aria-label="default input example" readonly>

                        Title:
                        <input class="form-control" type="text" name="title" 
                               value="<%=rec.getString("title")%>" required
                               aria-label="default input example">

                        Status:
                        <input class="form-control" type="text" name="status"
                               value="<%=rec.getString("status")%>"
                               aria-label="default input example">

                        Short Story
                        <input class="form-control" type="text" name="short_story"
                               value="<%=rec.getString("short_story")%>"
                               aria-label="default input example">

                        <!<!-- Cover -->
                        <div class="mb-3">
                            <label for="formFile" class="form-label"></label>
                            <input class="form-control" type="file" id="formFile" name="cover">
                        </div>
                        <!<!-- button -->
                        <div class="box-button">
                            <button type="submit" class="button button-insert">
                                <span>Update</span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
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

