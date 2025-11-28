<%-- 
    Document   : profile2
    Created on : Oct 1, 2025, 3:20:33 PM
    Author     : Admin
--%>

<%@page import="model.coinModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="th">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>โปรไฟล์ของฉัน</title>


        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>

        <style>
            .profile-card {
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0,0,0,0.1);
                overflow: hidden;
            }
            .profile-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                padding: 40px 20px;
                text-align: center;
                color: white;
            }
            .profile-avatar {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                border: 5px solid white;
                margin: 0 auto 15px;
                object-fit: cover;
                background: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 48px;
            }
            .profile-body {
                padding: 40px;
            }
            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 8px;
            }
            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
            }
            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                padding: 12px 40px;
                border-radius: 10px;
                font-weight: 600;
            }
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
            }
            .btn-secondary {
                padding: 12px 40px;
                border-radius: 10px;
                font-weight: 600;
            }
            .input-group-text {
                background-color: #f8f9fa;
                border-right: none;
            }
            .form-control {
                border-left: none;
            }
            .form-control:focus + .input-group-text {
                border-color: #667eea;
            }

            .container{
                margin-top: 50px;
            }

        </style>
    </head>
    <body>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>

        <!------------------------------------ Header -------------------------------->
        <!-- rest api คือที่เราทำอยู่มี ใช้ HTTP Method มาตรฐาน (GET, POST, PUT, DELETE )  -->
        <jsp:include page="./nav/nav-index.jsp"/>

        <%
            if (session == null || session.getAttribute("email") == null) {
                response.sendRedirect("login.html");
                return;
            }
 
            // ตรวจสอบ session
            //ใช้ session.getAttribute("email") เป็นตัวบังคับ login → ถ้าไม่มีค่า email จะ redirect ไป login
            String email = (String) session.getAttribute("email");
            Integer userId= (Integer) session.getAttribute("userId");
            String username = (String) session.getAttribute("username");
            String phone = (String) session.getAttribute("phone");
            String birthdate = (String) session.getAttribute("birthdate");
             
            //สร้างอ็อบเจ็กต์ของคลาส coinModel ชื่อโมเดลเพื่อเรียกใช้ข้อมูล
            coinModel model = new coinModel();// สร้างอ็อบเจ็กต์ไว้เรียกใช้ข้อมูลเหรียญ
            int coins = model.getUserCoins(userId);// ดึงจำนวนเหรียญของ userId ที่กำหนด
        %>

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">
                    <div class="profile-card">
                        <!-- Profile Header -->
                        <div class="profile-header">
                            <div class="profile-avatar">
                                <svg xmlns="http://www.w3.org/2000/svg" width="100px" height="100px" fill="gray" class="bi bi-person-circle" viewBox="0 0 16 16">
                                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                                <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                                </svg>
                            </div>
                            <h3 class="mb-1"><%= username != null ? username : "ไม่ระบุ"%></h3>
                            <p class="mb-0"><%= email%></p>
                        </div>
                        
                        <!-- coin -->
                        <div class="profile-body">
                            <h4 class="mb-4">
                                <i class="bi bi-coin"></i> <%= coins %> เหรียญ
                            </h4>
                        
                        <!-- Profile Body -->
                            <h4 class="mb-4">
                                <i class="bi bi-pencil-square text-primary me-2"></i>
                                แก้ไขข้อมูลส่วนตัว
                            </h4>

                            <form action="profile-user/UpdateProfile.jsp" method="post" id="profileForm">
                                <!-- Username -->
                                <div class="mb-4">
                                    <label for="username" class="form-label">
                                        <i class="bi bi-person me-1"></i>ชื่อผู้ใช้
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                                        <input type="text" class="form-control" id="username" name="username" 
                                               value="<%= username%>" required>
                                    </div>
                                </div>

                                <!-- Email -->
                                <div class="mb-4">
                                    <label for="email" class="form-label">
                                        <i class="bi bi-envelope me-1"></i>อีเมล
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                        <input type="email" class="form-control" id="email" name="email" 
                                               value="<%= email%>" required>
                                    </div>
                                </div>

                                <!-- Phone -->
                                <div class="mb-4">
                                    <label for="phone" class="form-label">
                                        <i class="bi bi-telephone me-1"></i>เบอร์โทรศัพท์
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                        <input type="tel" class="form-control" id="phone" name="phone" 
                                               value="<%= phone%>" pattern="[0-9]{10}" 
                                               placeholder="0812345678" required>
                                    </div>
                                </div>

                                <!-- Birthdate -->
                                <div class="mb-4">
                                    <label for="birthdate" class="form-label">
                                        <i class="bi bi-calendar me-1"></i>วันเกิด
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-calendar"></i></span>
                                        <input type="date" class="form-control" id="birthdate" name="birthdate" 
                                               value="<%= birthdate%>" required>
                                    </div>
                                </div>

                                <!-- Password Section -->
                                <div class="border-top pt-4 mt-4">
                                    <h5 class="mb-3">
                                        <i class="bi bi-shield-lock text-primary me-2"></i>
                                        เปลี่ยนรหัสผ่าน
                                    </h5>

                                    <div class="mb-3">
                                        <label for="currentPassword" class="form-label">
                                            <i class="bi bi-lock me-1"></i>รหัสผ่านปัจจุบัน
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                            <input type="password" class="form-control" id="currentPassword" 
                                                   name="currentPassword" placeholder="ใส่รหัสผ่านปัจจุบัน">
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">
                                            <i class="bi bi-key me-1"></i>รหัสผ่านใหม่
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-key"></i></span>
                                            <input type="password" class="form-control" id="newPassword" 
                                                   name="newPassword" placeholder="ใส่รหัสผ่านใหม่">
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label for="confirmPassword" class="form-label">
                                            <i class="bi bi-check-circle me-1"></i>ยืนยันรหัสผ่านใหม่
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-check-circle"></i></span>
                                            <input type="password" class="form-control" id="confirmPassword" 
                                                   name="confirmPassword" placeholder="ยืนยันรหัสผ่านใหม่">
                                        </div>
                                    </div>
                                </div>

                                <!-- Buttons -->
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                    <button type="button" class="btn btn-secondary" onclick="window.history.back()">
                                        <i class="bi bi-x-circle me-2"></i>ยกเลิก
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-check-circle me-2"></i>บันทึกการเปลี่ยนแปลง
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Form Validation
            document.getElementById('profileForm').addEventListener('submit', function (e) {
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const currentPassword = document.getElementById('currentPassword').value;

                // ถ้ากรอกรหัสผ่านใหม่ แต่ไม่กรอกรหัสผ่านปัจจุบัน
                if ((newPassword || confirmPassword) && !currentPassword) {
                    e.preventDefault();
                    alert('กรุณาใส่รหัสผ่านปัจจุบัน');
                    return false;
                }

                // ตรวจสอบรหัสผ่านใหม่กับการยืนยัน
                if (newPassword && newPassword !== confirmPassword) {
                    e.preventDefault();
                    alert('รหัสผ่านใหม่และการยืนยันรหัสผ่านไม่ตรงกัน');
                    return false;
                }

                // ตรวจสอบความยาวรหัสผ่าน
                if (newPassword && newPassword.length < 6) {
                    e.preventDefault();
                    alert('รหัสผ่านต้องมีความยาวอย่างน้อย 6 ตัวอักษร');
                    return false;
                }

                return true;
            });

            // แสดง/ซ่อนรหัสผ่าน
            function togglePassword(inputId) {
                const input = document.getElementById(inputId);
                input.type = input.type === 'password' ? 'text' : 'password';
            }
        </script>
    </body>
</html>