<%-- 
    Document   : CartoonIndex
    Created on : Sep 24, 2025, 9:39:04 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
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
        //น้อยไปมาก
        ps = conn.prepareStatement("SELECT * FROM cartoon ORDER BY id_cartoon ASC");
        rs = ps.executeQuery();
        java.util.Base64.Encoder encoder = java.util.Base64.getEncoder();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>การ์ตูนทั้งหมด</title>
        
        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>

    </head>
  
    <body >
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>
        <!------------------------------------ Header -------------------------------->
        <jsp:include page="/nav/nav-index.jsp"/>

        <!------------------------------------ Main Content -------------------------------->
        <div class="container my-5">
            <h2 class="mb-4">การ์ตูนทั้งหมด</h2>
            <div class="row g-4">
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
                <div class="col-md-3 text-center">
                    <div class="card shadow-sm p-2">
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
