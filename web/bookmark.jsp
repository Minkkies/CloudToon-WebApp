<%-- 
    Document   : bookmark
    Created on : Sep 24, 2025, 10:51:15 PM
    Author     : Admin
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Base64"%>

<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html>

    <head>
        <title>บุ๊คมาร์ก - CloudToon</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
  </head>

    <body>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>

        <jsp:include page="./nav/nav-index.jsp"/>

        <%

            // ดึง userId จาก session
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId == null) {
                out.println("<div class='alert alert-danger mt-5'>กรุณาเข้าสู่ระบบก่อนเข้าชั้นหนังสือ</div>");
                return;
            }

            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connectDB.MyCon m = new connectDB.MyCon();
                conn = m.myConnect();

                String sql = "SELECT c.id_cartoon, c.title, c.cover, c.status "
                        + "FROM bookmark b "
                        + "JOIN cartoon c ON b.id_cartoon = c.id_cartoon "
                        + "WHERE b.id_member = ? "
                        + "ORDER BY b.id_bookmark DESC";

                pst = conn.prepareStatement(sql);
                pst.setInt(1, userId);
                rs = pst.executeQuery();

                java.util.Base64.Encoder encoder = Base64.getEncoder();
        %>

        <!------------------------------------ Library-------------------------------->
        <div class="container my-5">
            <h3 class="mb-4">ชั้นหนังสือของคุณ</h3>
            <div class="row g-4">
                <%
                    boolean hasBookmark = false;
                    while (rs.next()) {
                        hasBookmark = true;
                        int cartoonId = rs.getInt("id_cartoon");
                        String title = rs.getString("title");
                        String status = rs.getString("status");
                        byte[] imgData = rs.getBytes("cover");
                        String base64Image = "";
                        if (imgData != null) {
                            base64Image = encoder.encodeToString(imgData);
                        }
                %>
                <div class="col-md-4">
                    <div class="card shadow-sm h-100">
                        <img src="data:image/jpeg;base64,<%=base64Image%>" class="card-img-top"  alt="<%=title%>">
                        <div class="card-body d-flex flex-column">
                            <h6 class="card-title"><%=title%> <%=status%></h6>
                            <p class="card-text text-muted">ch. ... Update!!</p>
                            <a href="CartoonDetail.jsp?id=<%=cartoonId%>" class="btn btn-primary mt-auto w-100">อ่านเลย</a>
                        </div>
                    </div>

                </div>
                <%
                    }

                    if (!hasBookmark) {
                %>
                <div class="col-12">
                    <div class="alert alert-info text-center">คุณยังไม่มีการ์ตูนในชั้นหนังสือ</div>
                </div>
            </div>
            <%
                }
            %>
        </div>
        <%
            } catch (Exception e) {
                out.println("<div class='alert alert-danger'>เกิดข้อผิดพลาด: " + e.getMessage() + "</div>");
                e.printStackTrace();
            } finally {
                if (rs != null) try {
                    rs.close();
                } catch (Exception e) {
                }
                if (pst != null) try {
                    pst.close();
                } catch (Exception e) {
                }
                if (conn != null) try {
                    conn.close();
                } catch (Exception e) {
                }
            }
        %>
    </body>
</html>