<%-- 
    Document   : BackIndex
    Created on : Oct 9, 2025, 6:34:44 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="th">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
       
        <title>ระบบจัดการเว็บ</title>
        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>

        <style>

            .header-title {
                font-size: 2.5rem;
                font-weight: 600;
                margin-bottom: 10px;
                text-align: center;
            }

            .menu-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 25px;
                margin-top: 20px;
            }

            .menu-icon {
                width: 70px;
                height: 70px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                font-size: 2rem;
                color: white;
                position: relative;
                transition: all 0.3s ease;
            }

            .stock-icon {
                background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            }

            .form-icon {
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            }

            .menu-card:hover .menu-icon {
                transform: scale(1.1);
            }

            .menu-title {
                font-size: 1.4rem;
                font-weight: 600;
                text-align: center;
                margin-bottom: 15px;
                color: black;
            }

            .menu-description {
                color: #6c757d;
                text-align: center;
                font-size: 0.95rem;
                line-height: 1.6;
                margin-bottom: 0;
            }


            @media (max-width: 768px) {
                .header-title {
                    font-size: 2rem;
                }

                .menu-grid {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }

                .menu-card {
                    padding: 25px 20px;
                }
            }


        </style>
    </head>

    <body>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>
        <!------------------------------------ Header -------------------------------->
        <jsp:include page="navBack/nav-admin.jsp"/>

        <!--Backend -->
        <div class="box my-6">
            <!-- Header Section -->
            <div>
                <h1 class="header-title">
                    ระบบจัดการเว็บ
                </h1>

            </div>

            <!------------------ Cartoon ----------------------------->
            <div class="menu-grid">
                <!-- Stock Management Card -->
                <a href="ShowDataCartoon.jsp" class="frame-bg">
                    <div class="menu-icon stock-icon">
                        <i class="bi bi-book-half"></i>
                    </div>
                    <h3 class="menu-title">จัดการข้อมูลการ์ตูน</h3>
                    <p class="menu-description">
                        แสดงรายละเอียดข้อมูลการ์ตูน 
                        สามารถเพิ่ม แก้ไข และลบข้อมูล

                    </p>
                </a>

                <!---------------------ตอนการ์ตูน------------------------------>

                <!-- Stock Management Card -->
                <a href="./episode/ShowEpisode.jsp" class="frame-bg">
                    <div class="menu-icon stock-icon">
                        <i class="bi bi-plus-circle"></i>
                    </div>
                    <h3 class="menu-title">จัดการตอนการ์ตูน</h3>
                    <p class="menu-description">
                        แสดงรายละเอียดของข้อมูลตอนการ์ตูน
                        สามารถเพิ่ม แก้ไข และลบตอนการ์ตูน

                    </p>
                </a>

                <!------------------- หมวดหมู่การ์ตูน -------------------->

                <!-- Stock Management Card -->
                <a href="./category/ShowCategory.jsp"  class="frame-bg" >
                    <div class="menu-icon stock-icon">
                        <i class="bi bi-boxes"></i>
                    </div>
                    <h3 class="menu-title">จัดการหมวดหมู่การ์ตูน</h3>
                    <p class="menu-description">
                        แสดงรายละเอียดหมวดหมู่การ์ตูน
                        สามารถเพิ่ม แก้ไข และลบหมวดหมู่

                    </p>
                </a>

                <!--------------------- รายการโปรด------------------------------>

                <!-- Stock Management Card -->
                <a href="./Package/ShowPackage.jsp" class="frame-bg">
                    <div class="menu-icon stock-icon">
                        <i class="bi bi-coin" width="20" height="20" fill="white"></i>
                    </div>
                    <h3 class="menu-title">จัดการข้อมูลแพ็คเกจ</h3>
                    <p class="menu-description">
                        แสดงรายละเอียดแพ็คเกจ
                        สามารถเพิ่ม แก้ไข และลบแพ็คเกจ
                    </p>
                </a>

                <!--------------------- รายการโปรด------------------------------>

                <!-- Stock Management Card -->
                <a href="./bookmark/ShowBookMark.jsp" class="frame-bg">
                    <div class="menu-icon stock-icon">
                        <img src='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="202" height="22" fill="white" class="bi bi-bookmarks-fill" viewBox="0 0 16 16"><path d="M2 4a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v11.5a.5.5 0 0 1-.777.416L7 13.101l-4.223 2.815A.5.5 0 0 1 2 15.5z"/><path d="M4.268 1A2 2 0 0 1 6 0h6a2 2 0 0 1 2 2v11.5a.5.5 0 0 1-.777.416L13 13.768V2a1 1 0 0 0-1-1z"/></svg>'
                             alt="Library Icon">
                    </div>
                    <h3 class="menu-title">ข้อมูลรายการโปรด</h3>
                    <p class="menu-description">
                        แสดงรายละเอียดของข้อมูลรายการโปรดของuser
                        สามารถเรียกดูได้เท่านั้น

                    </p>
                </a>

                <!--------------------- เติม------------------------------>
                <!-- Form Management Card -->
                <a href="ShowCoinHistory.jsp" class="frame-bg">
                    <div class="menu-icon stock-icon">
                        <i class="bi bi-cash-coin" width="20" height="20" fill="white"></i>
                    </div>
                    <h3 class="menu-title">ข้อมูลรายการเติมเหรียญ</h3>
                    <p class="menu-description">
                        แสดงประวัติการเติมเหรียญของuser
                        สามารถเรียกดูได้เท่านั้น
                    </p>
                </a>
            </div>

            <!------------------------ Register ---------------------------->
            <div class="menu-grid">
                <!-- Form Management Card -->
                <a href="./register/ShowRegister.jsp" class="frame-bg">
                    <div class="menu-icon form-icon">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <h3 class="menu-title">จัดการบัญชี (Register)</h3>
                    <p class="menu-description">
                        ดูแลและจัดการข้อมูลบัญชีของลูกค้าและพนักงาน
                    </p>
                </a>
            </div>
        </div>
    </body>
</html>