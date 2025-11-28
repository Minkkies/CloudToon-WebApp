<%-- 
    Document   : coin
    Created on : Sep 24, 2025, 10:51:02 PM
    Author     : Admin
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="th">

    <head>
        <title>เติมเหรียญ</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>

        <style>
            .package-card {
                cursor: pointer;
                transition: all 0.3s ease;
                border: 3px solid transparent;
            }
            .package-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            }
            .package-card.active {
                border-color: #28a745;
                background: linear-gradient(to bottom, #ffffff 0%, #e8f5e9 100%);
            }
            .coin-badge {
                background: linear-gradient(135deg, #ffd700, #ffed4e);
                color: #333;
                font-weight: bold;
            }
            .price-tag {
                font-size: 2rem;
                color: #667eea;
                font-weight: bold;
            }
            .qr-section {
                background: white;
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }
            .upload-area {
                border: 3px dashed #667eea;
                border-radius: 10px;
                padding: 40px;
                text-align: center;
                transition: all 0.3s ease;
            }
            .upload-area:hover {
                background: #f8f9fa;
                border-color: #764ba2;
            }
            .btn-confirm {
                background: linear-gradient(135deg, #667eea, #764ba2);
                border: none;
                padding: 15px 50px;
                font-size: 1.2rem;
                font-weight: bold;
            }
        </style>
    </head>

    <body>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>
        <jsp:include page="./nav/nav-index.jsp"/>

        <!-- Page Content -->
        <div class="container my-5 ">
            <div class="text-center mb-5">
                <h1 class="text-black mb-3">
                    <i class="bi bi-coin"></i> เติมเหรียญอ่านการ์ตูน
                </h1>
                <p class="text-black">เลือกแพ็คเกจที่คุณต้องการและชำระเงินเพื่อรับเหรียญทันที</p>
            </div>

            <form action="/JraBraWeb/ProcessCoin" method="post" enctype="multipart/form-data">
                <!-- แพ็คเกจเติมเงิน -->
                <div class="row mb-5">
                    <div class="col-md-3 col-sm-6 mb-4">
                        <div class="card package-card h-100" onclick="selectPackage(1, 50, 100)">
                            <div class="card-body text-center">
                                <span class="badge bg-danger mb-3 p-3">
                                    <i class="bi bi-coin"></i> 55 เหรียญ
                                </span>
                                <div class="price-tag">฿50</div>
                                <p class="text-muted mt-2">สำหรับผู้เริ่มต้น</p>
                                <input type="radio" name="package" value="1" class="package-radio" hidden>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6 mb-4">
                        <div class="card package-card h-100" onclick="selectPackage(2, 100, 200)">
                            <div class="card-body text-center">
                                <span class="badge bg-danger mb-3 p-3">
                                    <i class="bi bi-coin"></i> 110 เหรียญ
                                </span>
                                <div class="price-tag">฿100</div>
                                <p class="text-muted mt-2">คุ้มค่า</p>
                                <input type="radio" name="package" value="2" class="package-radio" hidden>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6 mb-4">
                        <div class="card package-card h-100" onclick="selectPackage(3, 500, 1000)">
                            <div class="card-body text-center">
                                <span class="badge bg-danger mb-3 p-3">
                                    <i class="bi bi-star-fill"></i> 550 เหรียญ
                                </span>
                                <div class="price-tag">฿500</div>
                                <p class="text-muted mt-2">ยอดนิยม</p>
                                <input type="radio" name="package" value="3" class="package-radio" hidden>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6 mb-4">
                        <div class="card package-card h-100" onclick="selectPackage(4, 1000, 1200)">
                            <div class="card-body text-center">
                                <span class="badge bg-danger mb-3 p-3">
                                    <i class="bi bi-gem"></i> 1,200 เหรียญ
                                </span>
                                <div class="price-tag">฿1,000</div>
                                <p class="text-muted mt-2">สุดคุ้ม</p>
                                <input type="radio" name="package" value="4" class="package-radio" hidden>
                            </div>
                        </div>
                    </div>
                </div>

                <input type="hidden" name="selectedPrice" id="selectedPrice">
                <input type="hidden" name="selectedCoins" id="selectedCoins">

                <!-- ส่วนชำระเงิน -->
                <div class="qr-section" id="paymentSection" style="display: none;">
                    <h3 class="text-center mb-4">
                        <i class="bi bi-credit-card"></i> ช่องทางการชำระเงิน
                    </h3>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="text-center p-4 border rounded">
                                <h5 class="mb-3"><i class="bi bi-qr-code"></i> สแกน QR Code</h5>
                                <img id="qrImage" src="" alt="QR Code" class="img-fluid mb-3" style="max-width: 250px;">
                                <p class="text-muted">สแกนเพื่อชำระเงินผ่าน Mobile Banking</p>
                            </div>
                        </div>

                        <div class="col-md-6 mb-4">
                            <div class="p-4 border rounded bg-light">
                                <h5 class="mb-3"><i class="bi bi-bank"></i> โอนเงินผ่านบัญชีธนาคาร</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>ธนาคาร:</strong></td>
                                        <td>ธนาคารไทยพาณิชย์</td>
                                    </tr>
                                    <tr>
                                        <td><strong>ชื่อบัญชี:</strong></td>
                                        <td>บริษัท คลาวด์ตูน จำกัด</td>
                                    </tr>
                                    <tr>
                                        <td><strong>เลขบัญชี:</strong></td>
                                        <td class="text-primary fw-bold">123-4-56789-0</td>
                                    </tr>
                                    <tr>
                                        <td><strong>จำนวนเงิน:</strong></td>
                                        <td class="text-danger fw-bold" id="displayPrice">-</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- อัปโหลดสลิป -->
                    <div class="mt-4">
                        <h5 class="mb-3"><i class="bi bi-cloud-upload"></i> อัปโหลดslip</h5>
                        <div class="upload-area">
                            <div class="mt-2" id="slipPreview" style="display: none;">
                                <img id="previewImage" src="" alt="Preview" class="img-fluid" style=" border: 1px solid #ccc; padding: 5px; border-radius: 5px;">
                            </div>
                            <input type="file" name="slipFile" id="slipFile" 
                                   accept="image/*" class="form-control" required>
                            <small class="text-muted">รองรับไฟล์: JPG, PNG(ไม่เกิน 5MB)</small>
                        </div>
                    </div>

                    <!-- ปุ่มยืนยัน -->
                    <div class="text-center mt-5">
                        <button type="submit" class="btn btn-confirm btn-lg text-white">
                            <i class="bi bi-check-circle"></i> ยืนยันการชำระเงิน
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Modal แจ้งเตือนสำเร็จ -->
        <div class="modal fade" id="successModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body text-center p-5">
                        <i class="bi bi-check-circle-fill text-success" style="font-size: 5rem;"></i>
                        <h3 class="mt-4">เติมเหรียญสำเร็จ!</h3>
                        <p class="text-muted mt-3">คุณได้รับ <span class="text-success fw-bold" id="addedCoins"></span> เหรียญ</p>
                        <div class="alert alert-info mt-4">
                            <h5>ยอดเหรียญคงเหลือ</h5>
                            <h2 class="text-primary"><i class="bi bi-coin"></i> <span id="totalCoinsDisplay"></span> เหรียญ</h2>
                        </div>
                        <a href="/JraBraWeb/index.jsp" class="btn btn-primary btn-lg mt-3">
                            เริ่มอ่านการ์ตูน
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <script>
                            let selectedPackageId = null;

                            function selectPackage(id, price, coins) {
                                // ลบ active class จากทั้งหมดที่เคยกด ล้างการเลือกเก่า ถ้าไม่มี คลิกหลายอันจะ active ทั้งหมด
                                document.querySelectorAll('.package-card').forEach(card => {
                                    card.classList.remove('active');
                                });

                                // เพิ่ม active class ให้กับที่เลือกอันล่าสุด ไฮไลต์การเลือกใหม่ ถ้าไม่มี คลิกใหม่ไม่เห็นสีเลย
                                event.currentTarget.classList.add('active');

                                // เลือก radio button
                                document.querySelectorAll('.package-radio').forEach(radio => {
                                    radio.checked = false;
                                });
                                event.currentTarget.querySelector('.package-radio').checked = true;//ตัวเลือกล่าสุด

                                // เก็บค่า
                                selectedPackageId = id;
                                document.getElementById('selectedPrice').value = price;
                                document.getElementById('selectedCoins').value = coins;
                                document.getElementById('displayPrice').textContent = '฿' + price.toLocaleString();

                                 // ✅ สร้าง QR อัตโนมัติ
                                const promptPayNumber = "0654155446"; // ใส่เบอร์/เลข PromptPay ของร้าน
                                const qrUrl = "https://promptpay.io/" + promptPayNumber + "/" + price + ".png";
                                document.getElementById('qrImage').src = qrUrl;

                                // แสดงส่วนชำระเงิน
                                document.getElementById('paymentSection').style.display = 'block';
                                document.getElementById('paymentSection').scrollIntoView({behavior: 'smooth'});

                                // Scroll ไปยังส่วนชำระเงิน
                                document.getElementById('paymentSection').scrollIntoView({behavior: 'smooth'});
                            }

                            // Preview ไฟล์ที่อัปโหลด
                            document.getElementById('slipFile').addEventListener('change', function (e) {
                                const previewDiv = document.getElementById('slipPreview');
                                const previewImg = document.getElementById('previewImage');

                                if (e.target.files.length > 0) {
                                    const file = e.target.files[0];
                                    const fileSize = (file.size / 1024 / 1024).toFixed(2); // MB

                                    // ตรวจสอบขนาดไฟล์
                                    if (fileSize > 5) {
                                        alert('ไฟล์มีขนาดใหญ่เกิน 5MB');
                                        e.target.value = '';
                                        previewDiv.style.display = 'none';
                                        previewImg.src = '';
                                        return;
                                    }

                                    // ตรวจสอบชนิดไฟล์
                                    if (!file.type.startsWith('image/')) {
                                        alert('รองรับเฉพาะไฟล์รูปภาพ JPG, PNG');
                                        e.target.value = '';
                                        previewDiv.style.display = 'none';
                                        previewImg.src = '';
                                        return;
                                    }

                                    // แสดงพรีวิว
                                    const reader = new FileReader();
                                    reader.onload = function (event) {
                                        previewImg.src = event.target.result;
                                        previewDiv.style.display = 'block';
                                    };
                                    reader.readAsDataURL(file);

                                } else {
                                    // ไม่มีไฟล์ → ซ่อนพรีวิว
                                    previewDiv.style.display = 'none';
                                    previewImg.src = '';
                                }
                            });
        </script>

        <script>
            <% if (request.getAttribute("addedCoins") != null) {%>
            document.addEventListener('DOMContentLoaded', function () {
                // ใส่ค่าที่เติมและยอดคงเหลือ
                document.getElementById('addedCoins').textContent = <%= request.getAttribute("addedCoins")%>;
                document.getElementById('totalCoinsDisplay').textContent = <%= request.getAttribute("totalCoins")%>;

                // สร้าง Modal Bootstrap
                var successModalEl = document.getElementById('successModal');
                var successModal = new bootstrap.Modal(successModalEl);

                // แสดง Modal
                successModal.show();

                // ซ่อนอัตโนมัติหลัง 5 วินาที
                setTimeout(function () {
                    successModal.hide();
                }, 5000);
            });
            <% }%>
        </script>
    </script>
</body>
</html>