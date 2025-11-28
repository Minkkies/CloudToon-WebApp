<%-- 
    Document   : ShowRegister
    Created on : Sep 22, 2025, 8:34:46 PM
    Author     : Admin
--%>

<%@page import="java.util.List"%>
<%@page import="model.coinModel"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>จัดการข้อมูลแพ็คเกจ</title>

        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>

        <style>
            /*.align-center{
                padding-left: 2rem !important;
            }*/
            td a i{
                font-size: 24px;
                padding-left: 1.2rem !important;
            }

            td a i:hover{
                opacity: 0.5;
            }

        </style>

    </head>
    <body>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>
        <!------------------------------------ Header -------------------------------->
        <jsp:include page="../navBack/nav-admin.jsp"/>

        <!-Read-->
        <div class="box my-6">
            <h3 class="header-title">ข้อมูลแพ็คเกจ</h3>
            <table class="table table-hover table-bordered align-middle ">
                <thead>
                    <tr class="table-info">
                        <th scope="col" class="align-center">Package ID</th>
                        <th scope="col" class="align-center">Name</th>
                        <th scope="col" class="align-center">Price</th>
                        <th scope="col" class="align-center">Coins</th>
                        <th scope="col" class="align-center">Add</th>
                        <th scope="col" class="align-center">Edit</th>
                        <th scope="col" class="align-center">Delete</th>
                    </tr>
                </thead>

                <tbody class="table-group-divider">

                    <%
                        try {
                            List<coinModel.Package> list = coinModel.getAllPackage();
                            for (coinModel.Package p : list) {
                    %>
                    <tr>
                        <td scope="row"><%= p.getPackageId()%></td>
                        <td scope="row"><%= p.getPackageName()%></td>
                        <td scope="row"><%= p.getPrice()%></td>
                        <td scope="row"><%= p.getCoins()%></td>
                        <td scope="row">
                                <a href="AddForm.jsp?id=<%= p.getPackageId()%>"" target="_blank">
                                    <i class="bi bi-plus"></i>
                                </a> 
                            </td>
                        <td>
                            <a href="EditForm.jsp?id=<%= p.getPackageId()%>">
                                <i class="bi bi-pencil-fill"></i>
                            </a>
                        </td>
                        <td>
                            <a href="DeletePackage.jsp?id=<%= p.getPackageId()%>" 
                               onclick="return confirm('⚠️ คุณแน่ใจหรือไม่ที่จะลบข้อมูลนี้?')">
                                <i class="bi bi-trash3-fill"></i>
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>
