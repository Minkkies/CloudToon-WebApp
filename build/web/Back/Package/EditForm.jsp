<%-- 
    Document   : AddForm
    Created on : Oct 9, 2025, 11:23:35 PM
    Author     : Admin
--%>
<%@page import="java.sql.*" %> 
<%@page import="connectDB.MyCon"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>แก้ไขแพ็กเกจ</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .container {
                margin-top: 50px;
            }
        </style>
    </head>

    <body class="bg-light">
        <div class="container">
            <h2 class="text-center mb-4">แก้ไขข้อมูลแพ็กเกจ</h2>

            <%
                request.setCharacterEncoding("UTF-8");

                String id = request.getParameter("id"); // รับค่า id จาก URL เช่น EditPackage.jsp?id=PK001
                if (id != null && !id.isEmpty()) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = new connectDB.MyCon().myConnect();

                        String sql = "SELECT * FROM packages_coin WHERE packages_id = ?";
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, id);
                        ResultSet rs = pstmt.executeQuery();

                        if (rs.next()) {
                            String packageName = rs.getString("packages_name");
                            String price = rs.getString("price");
                            String coins = rs.getString("coins");
            %>

            <!-- ฟอร์มแก้ไข -->
            <form action="UpdatePackage.jsp" method="post" class="border p-4 bg-white rounded shadow-sm">
                <input type="hidden" name="package_id" value="<%= id %>">

                <div class="mb-3">
                    <label class="form-label">ชื่อแพ็กเกจ</label>
                    <input type="text" name="package_name" class="form-control" value="<%= packageName %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">ราคา (บาท)</label>
                    <input type="number" name="price" class="form-control" value="<%= price %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">จำนวนเหรียญ</label>
                    <input type="number" name="coins" class="form-control" value="<%= coins %>" required>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="ShowPackage.jsp" class="btn btn-secondary">ย้อนกลับ</a>
                    <button type="submit" class="btn btn-primary">บันทึกการแก้ไข</button>
                </div>
            </form>

            <%
                        } else {
                            out.println("<div class='alert alert-danger mt-4'>ไม่พบข้อมูลแพ็กเกจ</div>");
                        }
                        rs.close();
                        pstmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger mt-4'>เกิดข้อผิดพลาด: " + e.getMessage() + "</div>");
                    }
                } else {
                    out.println("<div class='alert alert-warning mt-4'>ไม่พบรหัสแพ็กเกจใน URL</div>");
                }
            %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
