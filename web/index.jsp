<%-- 
    Document   : index
    Created on : Sep 24, 2025, 11:52:33 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connectDB.MyCon m = new connectDB.MyCon();
        conn = m.myConnect();

        //เรียงจากอันล่าสุดไปเก่า
        ps = conn.prepareStatement("SELECT * FROM cartoon ORDER BY id_cartoon  DESC LIMIT 4");
        rs = ps.executeQuery();
        java.util.Base64.Encoder encoder = java.util.Base64.getEncoder();
%>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html lang="en">

    <head>
        <title>CloudToon - รวมการ์ตูนสุดฮิตออนไลน์ไว้ภายในแอปเดียว ห้ามพลาด</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="CloudToon - รวมการ์ตูนสุดฮิตออนไลน์ไว้ภายในแอปเดียว ห้ามพลาด">
        <meta name="keywords" content="CloudToon, การ์ตูน, ออนไลน์, แอป, รวมการ์ตูน, อ่านการ์ตูน, เว็บการ์ต">
        <meta name="author" content="Ornpreeya">
        <meta name="theme-color" content="#ffffff">
   
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
        <jsp:include page="./nav/nav-index.jsp"/>

        <!------------------------------------ Main Content -------------------------------->

        <!-- Main Banner Carousel -->
        <div class="container my-4">
            <div id="carouselExampleCaptions" class="carousel slide">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active"
                            aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"
                            aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"
                            aria-label="Slide 3"></button>
                </div>

                <!--ว่าจะใส่ลิ้งในรูปค่อยทำคิดไม่ออก->ไม่ทำละ-->
                <div class="carousel-inner">
                    <div id="home" class="carousel-item active">
                        <img src="img/solo-long.png" class="d-block w-100" alt="sololeveling">
                        <div class="carousel-caption d-none d-md-block">
                            <h5>Solo leveling (End) ch.179 </h5>
                            <p>ในโลกที่ฮันเตอร์ถูกแบ่งเป็นระดับต่างๆ ตามพรสวรรค์ที่ได้มาแต่เกิด
                                ไม่สามารถเพิ่มระดับความสามารถได้ ซองจินอู ฮันเตอร์ระดับ E ผู้ไร้ความสามารถตลอดกาล
                                เดิมพันกับความตายที่อยูตรงหน้าในดันเจี้ยนประหลาด
                                ทว่าวิกฤตมักมาพร้อมโอกาสเสมอ เมื่อพลังในตัวของซองจินอูตื่นจากการหลับใหล
                                แถมยังพร้อมสรรพด้วยระบบซัพพอร์ตและการอัพเลเวลสูงขึ้นไปได้อีก เพียงแค่คนเดียวบนโลก</p>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <img src="img/villian.jpg" class="d-block w-100" alt="villian">
                        <div class="carousel-caption d-none d-md-block"></div>
                    </div>

                    <div class="carousel-item">
                        <img src="img/bl cover.jpg" class="d-block w-100" alt="blcover">
                        <div class="carousel-caption d-none d-md-block"></div>
                    </div>
                </div>

                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions"
                        data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>

                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions"
                        data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
            <!-------------------------------------- yoyoooyoyo------------------------------->

            <!------------------------- Content Layout ------------------------------------------->
            <div class="container my-5">
                <div class="row">
                    <!------------- Sidebar ---------------------->
                    <div class="col-md-3 mb-4">
                        <div class="sidebar">
                            <h5 class="mb-3">หมวดหมู่การ์ตูน</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><a href="AllCategory.jsp?id_category=2&name_category=Action">Action</a></li>
                                <li class="list-group-item"><a href="AllCategory.jsp?id_category=3&name_category=Romance">Romance</a></li>
                                <li class="list-group-item"><a href="AllCategory.jsp?id_category=6&name_category=Drama">Drama</a></li>
                                <li class="list-group-item"><a href="AllCategory.jsp?id_category=5&name_category=Fantasy">Fantasy</a></li>
                                <li class="list-group-item"><a href="AllCategory.jsp?id_category=4&name_category=Sci-fi">Sci-fi</a></li>
                                <li class="list-group-item"><a href="AllCategory.jsp?id_category=1&name_category=BL">BL</a></li>
                                <li class="list-group-item"><a href="AllCartoon.jsp">ดูทั้งหมด</a></li>

                            </ul>
                        </div>
                    </div>

                    <!----------------- Comics Section -------------------------->
                    <div class="col-md-9">
                        <h2 class="mb-4">การ์ตูนยอดนิยม</h2>
                        <div class="row g-4">

                            <!------- การ์ด --------->

                            <%
                                while (rs.next()) {
                                    int id_cartoon = rs.getInt("id_cartoon");
                                    String title = rs.getString("title");
                                    String status = rs.getString("status");
                                    // ดึงรูปและ encode ใน loop
                                    byte[] imgData = rs.getBytes("cover");
                                    String base64Image = "";
                                    if (imgData != null) {
                                        base64Image = java.util.Base64.getEncoder().encodeToString(imgData);
                                    }
                            %>
                            <div class="col-md-4">
                                <div class="card shadow-sm h-100">
                                    <img src="data:image/jpeg;base64,<%= base64Image%>" alt="<%= title%>" class="card-img-top" >
                                    <div class="card-body d-flex flex-column">
                                        <h6 class="card-title"><%= title%> <%= status%></h6>
                                        <p class="card-text text-muted">ch. ... Update!!</p>
                                        <a href="CartoonDetail.jsp?id=<%= id_cartoon%>" class="btn btn-primary mt-auto w-100">อ่านเลย</a>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <!------------------------------------ Footer -------------------------------->
    <footer>
        <div class="text-center p-4" style="background-color: lightgray;">
            <div class="container py-4">
                <div class="row justify-content-center">
                    <!-- Social Media Links -->
                    <div class="col-md-6 mb-4">
                        <h6 class="fw-bold fs-2">Follow Us</h6>
                        <div class="d-flex justify-content-center gap-4">
                            <a href="https://www.facebook.com/mink.ax?comment_id=Y29tbWVudDoxMDI1OTgwMzQ2MTc4NzI5XzEwNDQ4OTM2ODA5NTQwNjI%3D"
                               target="_blank" class="text-dark">
                                <i class="bi bi-facebook" style="font-size: 2.5rem;"></i>
                            </a>
                            <a href="https://www.instagram.com/nocaffeineinmydrink/" target="_blank" class="text-dark">
                                <i class="bi bi-instagram" style="font-size: 2.5rem;"></i>
                            </a>
                            <a href="https://github.com/Minkkies" target="_blank" class="text-dark">
                                <i class="bi bi-github" style="font-size: 2.5rem;"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center mt-4">
                    <!-- Company Info -->
                    <div class="col-md-6 text-center">
                        <h6 class="fw-bold fs-4">CloudToon Entertainment</h6>
                        <p class="small text-muted mb-0 fs-5">
                            © 2025 CloudToon Entertainment Corp. All rights reserved
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script>
        // ดึง query string
        const params = new URLSearchParams(window.location.search);
        const email = params.get('email');

        if (!email) {

            //window.location = "login.html";
        } else {
            document.getElementById("userEmail").innerText = email;
        }
    </script>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (Exception ex) {
        }
        try {
            if (ps != null) {
                ps.close();
            }
        } catch (Exception ex) {
        }
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (Exception ex) {
        }
    }
%>