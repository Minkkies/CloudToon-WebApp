<%-- 
    Document   : EditRegister
    Created on : Sep 22, 2025, 8:48:45 PM
    Author     : Admin
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <!------------>

        <!-- Bootstrap Icons CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

        <title>จัดการบัญชีผู้ใช้</title>
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>
        <link rel="stylesheet" href="../../stylesheet.css">

        <style>
            .item-box {
                width: 60%;
                margin-left: 20%;
            }

            .button-insert {
                background-color: lightgreen;
                border: none;
            }

            .button-update {
                background: lightskyblue;
                border: none;
            }

            .button-delete {
                background: lightcoral;
                border: none;
            }

            /*update*/
            .product_pic {
                width: 600px;      /* ขนาด cell */
                height: 150px;     /* ความสูง cell */
            }
            .product_pic img {
                width: 100%;
                height: 100%;
                object-fit: cover; /* ครอบรูปเต็ม cell */
            }
            /*-------*/
        </style>
    </head>
    <body>

        <div class="box">
            <h1 class="header-title">
                จัดการบัญชีผู้ใช้
            </h1>

        </div>

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
            String sql = "SELECT * FROM  register WHERE id_member= '" + request.getParameter("id") + "'  ";
            //request.getParameter("id")  "id" คือตัวแปรที่แสดงอยู่ตรง Url
            //ซึ่งมันจะต้องตรงกับตอนที่เราลิ้งมาหน้านี้ ตัวแปรที่เก็บค่า id_register ชื่อว่าอะไร
            ResultSet rec = s.executeQuery(sql);

            if (rec != null) {
                rec.next();
        %>

        <div class="box">
            <div class="item-box" id="update">
                <div class="frame-bg">
                    <h1>Edit</h1>
                    <form action="UpdateRegister.jsp?id_member=<%=rec.getString("id_member")%>" method="post" >
                        ID:
                        <input class="form-control" type="number" name="id" 
                               value="<%=rec.getString("id_member")%>"
                               aria-label="default input example" readonly>

                        Username:
                        <input class="form-control" type="text" name="username" 
                               value="<%=rec.getString("username")%>" required
                               aria-label="default input example">

                        Email:
                        <input class="form-control" type="text" name="email"
                               value="<%=rec.getString("email")%>"
                               aria-label="default input example">

                        Birthday:
                        <input class="form-control" type="date" name="birthday"
                               value="<%=rec.getString("birthday")%>"
                               aria-label="default input example"placeholder="yyyy/mm/dd">

                        Phone Number:
                        <input class="form-control" type="text" name="phone_num" 
                               value="<%=rec.getString("phone_num")%>"
                               aria-label="default input example">

                        password:
                        <input class="form-control" type="text" name="password" 
                               value="<%=rec.getString("password")%>"
                               aria-label="default input example">

                        <!-- button -->
                        <div class="box-button">
                            <button type="submit" class="button button-insert">
                                <span>Update</span>
                            </button>
                        </div>
                    </form>
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
