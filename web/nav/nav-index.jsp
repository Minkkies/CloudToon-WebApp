<%-- 
    Document   : nav-index
    Created on : Sep 25, 2025, 12:15:23 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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

        </style>

    </head>

    <body>

        <!-- Bootstrap JS -->

        <!------------------------------------ Header -------------------------------->
        <header>
            <nav class="navbar navbar-expand-lg bg-body-tertiary">
                <div class="container-fluid">
                    <!-- Logo as inline SVG -->
                    <a class="navbar-brand" href="index.jsp">
                        <img src="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' fill='lightblue'  viewBox='0 0 16 16'><path d='M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383'/></svg>"
                             alt="CloudToon Logo" width="30" height="30" class="d-inline-block align-text-top">
                        CloudToon
                    </a>

                    <!-- Navbar toggler for mobile view -->
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <!-- Navbar links -->
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                            <!-- Home Icon as inline SVG -->
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="./index.jsp">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-houses" viewBox="0 0 16 16">
                                    <path
                                        d="M5.793 1a1 1 0 0 1 1.414 0l.647.646a.5.5 0 1 1-.708.708L6.5 1.707 2 6.207V12.5a.5.5 0 0 0 .5.5.5.5 0 0 1 0 1A1.5 1.5 0 0 1 1 12.5V7.207l-.146.147a.5.5 0 0 1-.708-.708zm3 1a1 1 0 0 1 1.414 0L12 3.793V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v3.293l1.854 1.853a.5.5 0 0 1-.708.708L15 8.207V13.5a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 4 13.5V8.207l-.146.147a.5.5 0 1 1-.708-.708zm.707.707L5 7.207V13.5a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5V7.207z" />
                                    </svg>
                                    Home
                                </a>
                            </li>

                            <!-- Library Icon as inline SVG -->
                            <li class="nav-item">
                                <a class="nav-link" aria-current="page" href="bookmark.jsp">
                                    <img src='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="black" class="bi bi-bookmarks-fill" viewBox="0 0 16 16"><path d="M2 4a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v11.5a.5.5 0 0 1-.777.416L7 13.101l-4.223 2.815A.5.5 0 0 1 2 15.5z"/><path d="M4.268 1A2 2 0 0 1 6 0h6a2 2 0 0 1 2 2v11.5a.5.5 0 0 1-.777.416L13 13.768V2a1 1 0 0 0-1-1z"/></svg>'
                                         alt="Library Icon">
                                    Library
                                </a>
                            </li>

                            <!-- History Icon as inline SVG -->
                            <li class="nav-item">
                                <a class="nav-link " aria-current="page" href="coinHistory.jsp">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-clock" viewBox="0 0 16 16">
                                    <path
                                        d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z" />
                                    <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0" />
                                    </svg>
                                    History
                                </a>
                            </li>

                            <!-- Coin Icon as inline SVG -->
                            <li class="nav-item">
                                <a class="nav-link " aria-current="page" href="./coin.jsp">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-database" viewBox="0 0 16 16">
                                    <path
                                        d="M4.318 2.687C5.234 2.271 6.536 2 8 2s2.766.27 3.682.687C12.644 3.125 13 3.627 13 4c0 .374-.356.875-1.318 1.313C10.766 5.729 9.464 6 8 6s-2.766-.27-3.682-.687C3.356 4.875 3 4.373 3 4c0-.374.356-.875 1.318-1.313M13 5.698V7c0 .374-.356.875-1.318 1.313C10.766 8.729 9.464 9 8 9s-2.766-.27-3.682-.687C3.356 7.875 3 7.373 3 7V5.698c.271.202.58.378.904.525C4.978 6.711 6.427 7 8 7s3.022-.289 4.096-.777A5 5 0 0 0 13 5.698M14 4c0-1.007-.875-1.755-1.904-2.223C11.022 1.289 9.573 1 8 1s-3.022.289-4.096.777C2.875 2.245 2 2.993 2 4v9c0 1.007.875 1.755 1.904 2.223C4.978 15.71 6.427 16 8 16s3.022-.289 4.096-.777C13.125 14.755 14 14.007 14 13zm-1 4.698V10c0 .374-.356.875-1.318 1.313C10.766 11.729 9.464 12 8 12s-2.766-.27-3.682-.687C3.356 10.875 3 10.373 3 10V8.698c.271.202.58.378.904.525C4.978 9.71 6.427 10 8 10s3.022-.289 4.096-.777A5 5 0 0 0 13 8.698m0 3V13c0 .374-.356.875-1.318 1.313C10.766 14.729 9.464 15 8 15s-2.766-.27-3.682-.687C3.356 13.875 3 13.373 3 13v-1.302c.271.202.58.378.904.525C4.978 12.71 6.427 13 8 13s3.022-.289 4.096-.777c.324-.147.633-.323.904-.525" />
                                    </svg>
                                    Coin
                                </a>
                            </li>

                            <!-- Profile Icon as inline SVG -->
                            <li class="nav-item">
                                <a class="nav-link " href="./profile2.jsp" >
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-person" viewBox="0 0 16 16">
                                    <path
                                        d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z" />
                                    </svg>
                                    Profile: <span id="userEmail"></span>
                                </a>
                            </li>
                            
                            <li class="d-flex nav-item">
                                <a class="nav-link " href="./logout.jsp" >
                                    <i class="bi bi-box-arrow-right"> </i>log out
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <hr>
        </header>

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
