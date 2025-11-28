<%-- 
    Document   : coinHistory
    Created on : Oct 7, 2025, 10:50:04 PM
    Author     : Admin
--%>

<%@page import="model.coinModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="java.sql.*" %>
<!doctype html>
<html lang="th">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ประวัติการเติมเงิน</title>

        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>

        <style>
            body {
                background: #f8f9fa;
                color: #212529;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                padding: 40px 20px;
            }
            .card-light {
                background: #ffffff;
                border: 1px solid #dee2e6;
                border-radius: 14px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.05);
            }
            .balance-bar {
                background: #f1f3f5;
                border-radius: 10px;
                padding: 16px;
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom: 16px;
            }
            .balance-amount {
                color: #f6b21a;
                font-weight:700;
                font-size:1.25rem;
            }
            .btn-yellow {
                background: #f6b21a;
                color: #111;
                border: none;
                font-weight: 600;
            }
            .btn-yellow:hover {
                background: #ffca2c;
            }
            .nav-tabs .nav-link {
                color: #6c757d;
            }
            .nav-tabs .nav-link.active {
                background: #f6b21a;
                color: #111;
                border-radius: 8px;
                font-weight:700;
                border: none;
            }
            .table th {
                color: #f6b21a;
                border-bottom: 2px solid #dee2e6;
            }
            .table td {
                border-top: 1px solid #dee2e6;
            }
            .pagination .page-link {
                color: #6c757d;
            }
            .pagination .page-link:hover {
                color: #111;
                background: #ffe082;
                border-color: #ffc107;
            }
            .container-card {
                max-width: 820px;
                margin: 0 auto;
            }
        </style>
    </head>

    <body>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>
        <!------------------------------------ Header -------------------------------->
        <jsp:include page="./nav/nav-index.jsp"/>

        <%
            if (session == null || session.getAttribute("userId") == null) {
                response.sendRedirect("login.html");
                return;
            }

            Integer userId = (Integer) session.getAttribute("userId");
            coinModel model = new coinModel();
            int coins = model.getUserCoins(userId);
            List<coinModel.History> historyList = null;
            try {
                historyList = model.getUserHistory(userId);
            } catch (Exception e) {
                out.println("<div class='alert alert-danger'>เกิดข้อผิดพลาด: " + e.getMessage() + "</div>");
            }
        %>

        <div class="container-card">
            <div class="card card-light p-4">
                <h3 class="text-center mb-3 fw-bold">ประวัติ</h3>

                <div class="balance-bar">
                    <div style="font-size:0.95rem; color:#555;">ยอดเหรียญคงเหลือ</div>
                    <div class="balance-amount"><i class="bi bi-coin"></i> <%= coins%></div>
                </div>

                <!-- Tabs -->
                <ul class="nav nav-tabs mb-3" role="tablist">
                    <li class="nav-item">
                        <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#topup-history" type="button">
                            ประวัติการเติมเงิน
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#purchase-history" type="button">
                            ประวัติการซื้อ
                        </button>
                    </li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane fade show active" id="topup-history">
                        <div class="table-responsive">
                            <table class="table table-borderless align-middle text-center">
                                <thead>
                                    <tr>
                                        <th>แพ็คเกจ</th>
                                        <th>จำนวนเงิน (฿)</th>
                                        <th>จำนวนเหรียญ</th>
                                        <th>วันที่เติม</th>
                                        <th>สถานะ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (historyList != null && !historyList.isEmpty()) {
                                            for (coinModel.History h : historyList) {
                                                String packageDisplay = "";
                                                String packageName = "";
                                                try {
                                                    coinModel.Package pkg = model.getPackageById(h.getPackageId());
                                                    if (pkg != null) {
                                                        packageName = pkg.getPackageName();
                                                    }
                                                } catch (Exception e) {
                                                    out.println("เกิดข้อผิดพลาดในการดึงข้อมูลแพ็คเกจ");
                                                }
                                    %>
                                    <tr>
                                        <td><%= packageName%></td>
                                        <td>฿<%= h.getAmount()%></td>
                                        <td><i class="bi bi-coin"></i>  <%= h.getCoins()%></td>
                                        <td><%= h.getDate()%></td>
                                        <td><%= h.getPaid()%></td>
                                    </tr>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <tr>
                                        <td colspan="6" class="text-center">ยังไม่มีประวัติการเติมเหรียญ</td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- Tab ประวัติการซื้อ-->
                    <div class="tab-pane fade" id="purchase-history">
                        <div class="table-responsive">
                            <table class="table table-borderless align-middle text-center">
                                <thead>
                                    <tr>
                                        <th>เรื่่อง</th>
                                        <th>ตอนที่</th>
                                        <th>จำนวนเหรียญ</th>
                                        <th>วันที่</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        request.setCharacterEncoding("UTF-8");

                                        Connection conn = null;
                                        PreparedStatement pst = null;
                                        ResultSet rs = null;

                                        try {
                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                            connectDB.MyCon m = new connectDB.MyCon();
                                            conn = m.myConnect();

                                            String sql
                                                    = "SELECT c.title, e.episode_num, p.coin_spent, p.purchase_date "
                                                    + "FROM purchase_episode p "
                                                    + "JOIN cartoon c ON p.id_cartoon = c.id_cartoon "
                                                    + "JOIN episode e ON p.id_cartoon = e.cartoon_ref AND p.episode_num = e.episode_num "
                                                    + "WHERE p.id_member = ? "
                                                    + "ORDER BY p.purchase_date DESC";

                                            pst = conn.prepareStatement(sql);
                                            pst.setInt(1, userId);
                                            rs = pst.executeQuery();

                                            boolean hasData = false;
                                            while (rs.next()) {
                                                hasData = true;
                                    %>
                                    <tr>
                                        <td><%= rs.getString("title")%></td>
                                        <td>ตอนที่ <%= rs.getInt("episode_num")%></td>
                                        <td><i class="bi bi-coin"></i> <%= rs.getInt("coin_spent")%></td>
                                        <td><%= rs.getString("purchase_date")%></td>
                                    </tr>
                                    <%
                                        }
                                        if (!hasData) {
                                    %>
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">
                                            ยังไม่มีประวัติการซื้อตอน
                                        </td>
                                    </tr>
                                    <%
                                            }
                                        } catch (Exception e) {
                                            out.println("<tr><td colspan='5' class='text-danger'>เกิดข้อผิดพลาด: " + e.getMessage() + "</td></tr>");
                                        } finally {
                                            if (rs != null) {
                                                rs.close();
                                            }
                                            if (pst != null) {
                                                pst.close();
                                            }
                                            if (conn != null) {
                                                conn.close();
                                            }
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
