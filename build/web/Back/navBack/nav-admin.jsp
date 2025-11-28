<%-- 
    Document   : nav-admin
    Created on : Oct 9, 2025, 6:36:44 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#ffffff">

    <!-- Bootstrap CSS and JS -->
    <!--โหลด Bootstrap CSS (เช่น grid, typography, utilities ฯลฯ)-->
    <!--โหลด Bootstrap JS (เช่น modal, dropdown, carousel ฯลฯ)-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml"
          href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>

    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet.css" type="text/css"/>
    -->
    <!--css-->
    <style>
        hr {
            border: 0;
            margin: 0;
            height: 1px;
            background: #333;
            background-image: linear-gradient(to right, #ccc, #333, #ccc);
        }

        header {
            position: fixed;
            z-index: 1000;
            width: 100%;
            top: 0;
        }

        .col-md-4 {
            width: 25%;
        }

        a:hover {
            text-decoration: none;
        }

        .navbar-nav{
            flex-direction: row;
        }
    </style>

</head>

<body>
    <div>
        <!------------------------------------ Header -------------------------------->
        <header>
            <nav class="navbar navbar-expand-lg bg-body-tertiary">
                <div class="container-fluid">

                    <!-- Logo as inline SVG -->
                    <!--<a href="/projectweb2204/Back/BackIndex.jsp"></a>-->
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/Back/BackIndex.jsp">
                        <img src="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' fill='lightblue'  viewBox='0 0 16 16'><path d='M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383'/></svg>"
                             alt="CloudToon Logo" width="30" height="30" class="d-inline-block align-text-top">
                        CloudToon : <span id="userEmail"></span>
                    </a>


                    <a class="d-flex- nav-item nav-link " href="../logout.jsp" >
                        <i class="bi bi-box-arrow-right"> </i>log out
                    </a>

                </div>
            </nav>
            <hr>
        </header>
    </div>

    <%
        Object email = session.getAttribute("email");
        if (email == null) {
            // ถ้า session ไม่มี email ให้ redirect ไป login
            response.sendRedirect("login.html");
        }
    %>
    <!-- ฝั่ง Client -->
    <script>
        // ดึง email จาก session ฝั่ง server มาใส่ JS
        const email = "<%= (email != null ? email.toString() : "")%>";

        if (email === "") {
            //window.location = "login.html";
        } else {
            document.getElementById("userEmail").innerText = email;
        }
    </script>
</body>
</html>