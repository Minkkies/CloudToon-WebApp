<%-- 
    Document   : c-register
    Created on : Sep 22, 2025, 8:23:33 PM
    Author     : Admin
--%>

<%@page import="java.sql.*" %> 
<%@page import="connectDB.MyCon"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>เพิ่มข้อมูลแพ็คเกจ</title>
        <link rel="stylesheet" href="../../stylesheet.css">

        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>

    </head>
    <body>
 
        <%
            request.setCharacterEncoding("UTF-8");
            Connection conn=null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = new connectDB.MyCon().myConnect();
               
                String packageId = request.getParameter("package_id");
                String packageName = request.getParameter("package_name");
                String price= request.getParameter("price");
                String coins = request.getParameter("coins");

                String sql = "INSERT INTO packages_coin (packages_id, packages_name, price, coins) VALUES (?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, packageId); //(colที่, ตัวแปรที่ getParameter)
                pstmt.setString(2, packageName);
                pstmt.setString(3, price);
                pstmt.setString(4, coins);

                int rows = pstmt.executeUpdate();
               if (rows > 0) {
        response.getWriter().println("<script>alert('✅ Upload successfully!'); window.location='ShowPackage.jsp';</script>");
    } else {
        response.getWriter().println("<script>alert('❌ Upload failed!');</script>");
    }

} catch (Exception e) {
    out.print(e);
} finally {
    try {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        out.print(e);
    }
}
%>
    </body>
</html>

