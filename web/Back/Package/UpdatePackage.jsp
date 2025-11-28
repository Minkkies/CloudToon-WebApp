<%-- 
    Document   : UpdatePackage
    Created on : Oct 9, 2025, 11:47:28 PM
    Author     : Admin
--%>

<%@page import="java.sql.*"%>
<%@page import="connectDB.MyCon"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("package_id");
    String name = request.getParameter("package_name");
    String price = request.getParameter("price");
    String coins = request.getParameter("coins");
    String bonus = request.getParameter("bonus");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = new MyCon().myConnect();

        String sql = "UPDATE packages_coin SET packages_name=?, price=?, coins=?, bonus=? WHERE packages_id=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, name);
        pst.setString(2, price);
        pst.setString(3, coins);
        pst.setString(4, bonus);
        pst.setString(5, id);

        int rows = pst.executeUpdate();

        if (rows > 0) {
            out.println("<script>alert('✅ อัปเดตข้อมูลเรียบร้อย'); window.location='ShowPackage.jsp';</script>");
        } else {
            out.println("<script>alert('❌ ไม่พบข้อมูลที่ต้องการแก้ไข'); window.location='ShowPackage.jsp';</script>");
        }

        pst.close();
        conn.close();

    } catch (Exception e) {
        out.println("<script>alert('เกิดข้อผิดพลาด: " + e.getMessage() + "'); window.location='ShowPackage.jsp';</script>");
    }
%>
</body>
</html>
