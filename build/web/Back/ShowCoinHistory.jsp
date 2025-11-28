<%-- 
    Document   : ShowCoinHistory
    Created on : Oct 8, 2025, 12:18:08 AM
    Author     : Admin
--%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="th">
    <head>
        <meta charset="UTF-8">
        <title>ประวัติการเติมเหรียญ</title>
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
        <jsp:include page="navBack/nav-admin.jsp"/>

            <div class="box my-6">
                <h1 class="header-title">ข้อมูลประวัติการเติมเหรียญ</h1>
                <table class="table table-hover table-bordered align-middle ">
                    <thead>
                        <tr class="table-info">
                            <th scope="col" class="align-center">UserId</th>
                            <th scope="col" class="align-center">UserEmail</th>
                            <th scope="col" class="align-center">UserName</th>
                            <th scope="col" class="align-center">ชื่อแพ็คเกจ</th>
                            <th  scope="col" class="align-center">จำนวนเงิน (฿)</th>
                            <th scope="col" class="align-center">จำนวนเหรียญ</th>
                            <th scope="col" class="align-center">วันที่เติม</th>
                            <th scope="col" class="align-center">สถานะ</th>
                            <th scope="col" class="align-center">สลิป</th>
                        </tr>
                    </thead>

                    <tbody class="table-group-divider">
                        <%

                            request.setCharacterEncoding("UTF-8");

                            Connection con = null;
                            PreparedStatement pst = null;
                            ResultSet rs = null;

                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                connectDB.MyCon m = new connectDB.MyCon();
                                con = m.myConnect();

                                String sql = "SELECT h.*, r.email,r.username, p.packages_name, p.price, p.coins, p.bonus "
                                        + "FROM coin_history h "
                                        + "JOIN register r ON h.id_member = r.id_member "
                                        + "LEFT JOIN packages_coin p ON h.packages_id = p.packages_id "
                                        + "ORDER BY h.created_date DESC";

                                pst = con.prepareStatement(sql);
                                rs = pst.executeQuery();
                                java.util.Base64.Encoder encoder = java.util.Base64.getEncoder();
                                while (rs.next()) {
                        %>
                        <tr>
                            <td scope="row"><%= rs.getInt("id_member")%></td>
                            <td scope="row"><%= rs.getString("username")%></td>
                            <td scope="row"><%= rs.getString("email")%></td>
                            <td scope="row"><%= rs.getString("packages_name")%></td>
                            <td scope="row"><%=  rs.getInt("amount")%></td>
                            <td scope="row"><%=rs.getInt("coins")%></td>
                            <td scope="row"><%=rs.getString("created_date")%></td>
                            <td scope="row">
                                <% if ("1".equals(rs.getString("paid"))) { %>
                                <span class="badge bg-success">สำเร็จ</span>
                                <% } else { %>
                                <span class="badge bg-warning text-dark">รอดำเนินการ</span>
                                <% } %>
                            </td>

                            <td  scope="row">
                                <%
                                    byte[] imgData = rs.getBytes("slip");
                                    String base64Image = encoder.encodeToString(imgData);
                                %>
                                <img src="data:image/jpeg;base64,<%= base64Image%>" alt="bak Image" style="width: 150px; height: auto;">
                            </td >  
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                                e.printStackTrace();
                            } finally {
                                try {
                                    if (rs != null) {
                                        rs.close();
                                    }
                                } catch (Exception e) {
                                }
                                try {
                                    if (pst != null) {
                                        pst.close();
                                    }
                                } catch (Exception e) {
                                }
                                try {
                                    if (con != null) {
                                        con.close();
                                    }
                                } catch (Exception e) {
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
    </body>
</html>

