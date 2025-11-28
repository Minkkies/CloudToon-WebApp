<%-- 
    Document   : CartoonDetail
    Created on : Oct 1, 2025, 9:50:51 PM
    Author     : Admin
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>รายละเอียดการ์ตูน</title>

        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>

        <link rel="stylesheet" href="stylesheet.css" type="text/css"/>

        <style>
            .cover-image {
                max-height: 450px;
                object-fit: cover;
                width: 100%;
            }
            .episode-item:hover {
                background-color: #f8f9fa;
            }
        </style>
    </head>

    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>

        <!-- Header -->
        <jsp:include page="./nav/nav-index.jsp"/>

        <%
            // ดึง userId จาก session
            Integer userId = (Integer) session.getAttribute("userId");
            // ดึงค่า email จาก session (server-side)
            String email = (String) session.getAttribute("email");
            // รับ id_cartoon และตรวจสอบ
            String idCartoonParam = request.getParameter("id");
            int idCartoon = 0;

            if (idCartoonParam == null || idCartoonParam.isEmpty()) {
                out.println("<div class='container mt-5'><div class='alert alert-danger'>ไม่พบ ID การ์ตูน</div></div>");
                return;
            }

            try {
                idCartoon = Integer.parseInt(idCartoonParam);
            } catch (NumberFormatException e) {
                out.println("<div class='container mt-5'><div class='alert alert-danger'>รูปแบบ ID ไม่ถูกต้อง</div></div>");
                return;
            }

            // ตัวแปรเก็บข้อมูล
            String title = "", story = "", coverBase64 = "", status = "";
            List<String> categories = new ArrayList<>();
            int firstEpisode = 0, latestEpisode = 0, firstEpisodeNum = 0, latestEpisodeNum = 0;
            boolean foundData = false;

            Connection conn = null;
            PreparedStatement psCartoon = null, psCat = null, psFirst = null, psLatest = null, psEpisodes = null;
            ResultSet rsCartoon = null, rsCat = null, rsFirst = null, rsLatest = null, rsEpisodes = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connectDB.MyCon m = new connectDB.MyCon();
                conn = m.myConnect();

                // ดึงข้อมูลการ์ตูน ? คือ parameter placeholder
                psCartoon = conn.prepareStatement("SELECT * FROM cartoon WHERE id_cartoon=?");
                psCartoon.setInt(1, idCartoon);
                rsCartoon = psCartoon.executeQuery();

                //รายละเอียดข้อมูลการ์ตูนเมื่อเจอข้อมูล
                if (rsCartoon.next()) {
                    foundData = true;
                    title = rsCartoon.getString("title");
                    status = rsCartoon.getString("status");
                    story = rsCartoon.getString("short_story");

                    // แปลง BLOB เป็น Base64
                    Blob coverBlob = rsCartoon.getBlob("cover");
                    if (coverBlob != null) {
                        byte[] imgBytes = coverBlob.getBytes(1, (int) coverBlob.length());
                        coverBase64 = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imgBytes);
                    } else {
                        coverBase64 = "https://via.placeholder.com/300x400?text=No+Image";//Fallback → ถ้าไม่มีภาพ ใช้ placeholder จากเว็บ
                    }

                    // ดึงหมวดหมู่การ์ตูน
                    psCat = conn.prepareStatement(
                            "SELECT cat.name_category "
                            + "FROM category cat "
                            + "JOIN cartoon_category cc ON cat.id_category = cc.id_category "
                            + "WHERE cc.id_cartoon=?"
                    );
                    psCat.setInt(1, idCartoon);
                    rsCat = psCat.executeQuery();
                    while (rsCat.next()) {
                        categories.add(rsCat.getString("name_category"));
                    }

                    // ดึงข้อมูลการ์ตูนตอนแรก  
                    psFirst = conn.prepareStatement(
                            "SELECT id_episode, episode_num FROM episode WHERE cartoon_ref=? ORDER BY episode_num ASC LIMIT 1"
                    );
                    psFirst.setInt(1, idCartoon);
                    rsFirst = psFirst.executeQuery();
                    if (rsFirst.next()) {
                        firstEpisode = rsFirst.getInt("episode_num");
                    }

                    // ตอนล่าสุด
                    psLatest = conn.prepareStatement(
                            "SELECT id_episode, episode_num FROM episode WHERE cartoon_ref=? ORDER BY episode_num DESC LIMIT 1"
                    );
                    psLatest.setInt(1, idCartoon);
                    rsLatest = psLatest.executeQuery();
                    if (rsLatest.next()) {
                        latestEpisode = rsLatest.getInt("episode_num");
                    }
                }
            } catch (Exception e) {
                out.println("<div class='container mt-5'><div class='alert alert-danger'>เกิดข้อผิดพลาด: " + e.getMessage() + "</div></div>");
                e.printStackTrace();
            }

            // ถ้าไม่พบข้อมูล
            if (!foundData) {
                out.println("<div class='container mt-5'><div class='alert alert-warning'>ไม่พบข้อมูลการ์ตูน</div></div>");
                if (conn != null) {
                    conn.close();
                }
                return;
            }
        %>

        <!-- Cartoon Detail -->
        <div class="container my-5">
            <div class="row">
                <!-- Cover -->
                <div class="col-lg-3 col-md-4 text-center">
                    <img src="<%= coverBase64%>" alt="<%= title%>" class="img-fluid rounded shadow cover-image">
                    <div class="mt-3 d-grid gap-2">
                        <% if (firstEpisode > 0) {%>
                        <a href="ReadEpisode.jsp?id_cartoon=<%= idCartoon%>&epNum=<%= firstEpisode%>" class="btn btn-primary">
                            <i class="bi bi-play-fill"></i> เริ่มอ่านตอนแรก
                        </a>
                        <% }%>

                        <!--แสดงปุ่มอ่านต่อ (CartoonDetail.jsp)โหลด localStorage สร้างปุ่ม <a> ให้ไปตอนล่าสุดที่อ่าน 
                        แยกข้อมูลตาม user → cartoon → episode เป็นการสร้างลิงก์ (hyperlink) แบบ <a> ด้วย JavaScript
                        -->
                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                console.log("🎬 เริ่มต้นระบบอ่านต่อ");

                                // ดึงข้อมูลจาก session
                                const userEmail = "<%= email != null ? email : ""%>";
                                const cartoonId = "<%= idCartoon%>";

                                console.log("👤 ผู้ใช้:", userEmail);
                                console.log("📚 การ์ตูน ID:", cartoonId);

                                // หา container ที่จะใส่ปุ่ม
                                const container = document.querySelector(".mt-3.d-grid");
                                if (!container) {
                                    console.error("❌ ไม่พบ container สำหรับปุ่ม");
                                    return;
                                }

                                // ตรวจสอบว่า login แล้วหรือยัง
                                if (!userEmail || userEmail === "null" || userEmail.trim() === "") {
                                    console.warn("⚠️ ยังไม่ได้ login - ไม่แสดงปุ่มอ่านต่อ");
                                    return;
                                }

                                try {
                                    // อ่านข้อมูลจาก localStorage แปลง string JSON ให้กลายเป็น object ของ JavaScript
                                    const lastReads = JSON.parse(localStorage.getItem("lastReads") || "{}");
                                    console.log("📖 ข้อมูลทั้งหมดใน localStorage:", lastReads);

                                    // ตรวจสอบว่ามีประวัติการอ่านของ user และการ์ตูนนี้หรือไม่
                                    if (lastReads[userEmail] && lastReads[userEmail][cartoonId]) {
                                        const data = lastReads[userEmail][cartoonId];//อ้อปเจ้ก
                                        console.log("✅ พบประวัติการอ่าน:", data);

                                        // สร้างปุ่มอ่านต่อ
                                        const continueBtn = document.createElement("a");
                                        continueBtn.href = "ReadEpisode.jsp?id_cartoon=" + cartoonId + "&epNum=" + data.episodeNum;
                                        continueBtn.className = "btn btn-warning text-white fw-bold";
                                        continueBtn.innerHTML = '<i class="bi bi-arrow-repeat"></i> อ่านต่อตอนที่ ' + data.episodeNum;

                                        // แทรกปุ่มในตำแหน่งที่ 2 (หลังปุ่มเริ่มอ่านตอนแรก)
                                        const buttons = container.querySelectorAll("a.btn");
                                        if (buttons.length > 0) {
                                            // ใส่หลังปุ่มแรก
                                            buttons[0].insertAdjacentElement('afterend', continueBtn);
                                        } else {
                                            // ถ้าไม่มีปุ่ม ให้ append ท้ายสุด
                                            container.appendChild(continueBtn);
                                        }

                                        console.log("✅ สร้างปุ่มอ่านต่อเรียบร้อย");

                                    } else {
                                        console.log("ℹ️ ยังไม่มีประวัติการอ่านการ์ตูนนี้");
                                    }

                                } catch (error) {
                                    console.error("❌ เกิดข้อผิดพลาด:", error);
                                }
                            });
                        </script>

                        <% if (latestEpisode > 0) {%>
                        <a href="ReadEpisode.jsp?id_cartoon=<%= idCartoon%>&epNum=<%= latestEpisode%>" class="btn btn-success">
                            <i class="bi bi-arrow-right-circle"></i> อ่านตอนล่าสุด
                        </a>
                        <% }%>

                        <%
                            //check follow
                            boolean isFollowed = false;
                            if (userId != null) {
                                PreparedStatement pstFollow = conn.prepareStatement(
                                        "SELECT 1 FROM bookmark WHERE id_member=? AND id_cartoon=?");//แค่ตรวจสอบว่ามีแถวที่ตรงเงื่อนไขหรือไม่
                                pstFollow.setInt(1, userId);
                                pstFollow.setInt(2, idCartoon);
                                ResultSet rsFollow = pstFollow.executeQuery();
                                if (rsFollow.next()) {
                                    isFollowed = true;
                                }
                                rsFollow.close();
                                pstFollow.close();
                            }
                        %>

                        <button id="followBtn" class="btn <%= isFollowed ? "btn-danger" : "btn-outline-secondary"%>" 
                                onclick="followCartoon(<%= idCartoon%>, <%= userId != null%>)">
                            <i id="heartIcon" class="bi <%= isFollowed ? "bi-heart-fill" : "bi-heart"%>"></i>
                            ติดตาม
                        </button>


                        <!-- Toast แบบกล่อง Alert -->
                        <div id="toastAlert" class="alert alert-primary position-fixed bottom-0 end-0 m-3" role="alert" 
                             style="display:none;
                             width: 300px;
                             height: 70px;
                             z-index: 10;
                             top: 50px;
                             background-color: #fff;
                             border-color: black;
                             color: red;
                             box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 6px;">
                            <strong><span id="toastAlertText"></span></strong>
                        </div>

                    </div>
                </div>

                <!-- Info -->
                <div class="col-lg-9 col-md-8">
                    <h2 class="fw-bold mb-3"><%= title%></h2>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <p class="mb-2">
                                <strong><i class="bi bi-info-circle"></i> สถานะ:</strong> 
                                <span class="badge <%= status.equals("On Going") ? "bg-success" : "bg-secondary"%>">
                                    <%= status%>
                                </span>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p class="mb-2">
                                <strong><i class="bi bi-tags"></i> แนว:</strong> 
                                <%= categories.isEmpty() ? "ไม่ระบุ" : String.join(", ", categories)%>
                            </p>
                        </div>
                    </div>
                    <div class="card bg-light">
                        <div class="card-body">
                            <h5 class="card-title"><i class="bi bi-book"></i> เรื่องย่อ</h5>
                            <p class="card-text text-justify"><%= story%></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Episode List -->
        <div class="container mb-5">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="fw-bold mb-0"><i class="bi bi-list-ol"></i> รายการตอน</h4>

                <%
                    // รับค่า sort จาก URL
                    String currentSort = request.getParameter("sort");
                    if (currentSort == null) {
                        currentSort = "desc";// ค่า default ใหม่-เก่า
                    }%>

                <div class="btn-group" role="group">
                    <button type="button" 
                            class="btn btn-sm btn-outline-primary <%= currentSort.equals("desc") ? "active" : ""%>" 
                            onclick="window.location.href = 'CartoonDetail.jsp?id=<%= idCartoon%>&sort=desc'">
                        <i class="bi bi-sort-down"></i> ใหม่ - เก่า
                    </button>
                    <button type="button" 
                            class="btn btn-sm btn-outline-primary <%= currentSort.equals("asc") ? "active" : ""%>" 
                            onclick="window.location.href = 'CartoonDetail.jsp?id=<%= idCartoon%>&sort=asc'">
                        <i class="bi bi-sort-up"></i> เก่า - ใหม่
                    </button>
                </div>
            </div>

            <div class="list-group shadow-sm" id="episodeList">
                <%
                    try {
                        // ใช้ค่า currentSort ที่ได้มาจากด้านบน
                        String orderBy = currentSort.equals("asc") ? "ASC" : "DESC";

                        // Query ตอน
                        String sqlEpisodes = "SELECT * FROM episode WHERE cartoon_ref=? ORDER BY episode_num " + orderBy;
                        psEpisodes = conn.prepareStatement(sqlEpisodes);
                        psEpisodes.setInt(1, idCartoon);
                        rsEpisodes = psEpisodes.executeQuery();

                        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy", new Locale("th", "TH"));
                        boolean hasEpisodes = false;

                        while (rsEpisodes.next()) {
                            hasEpisodes = true;
                            int eid = rsEpisodes.getInt("id_episode");
                            int epNum = rsEpisodes.getInt("episode_num");
                            String epTitle = rsEpisodes.getString("episode_title");
                            int coin = rsEpisodes.getInt("coin");
                            java.sql.Date release = rsEpisodes.getDate("release_date");
                            String releaseStr = release != null ? sdf.format(release) : "-";

                            // ตรวจสอบว่าซื้อตอนนี้แล้วหรือยัง
                            int displayCoin = coin;
                            boolean isPurchased = false;
                            if (userId != null) {
                                PreparedStatement pstPurchase = conn.prepareStatement(
                                        "SELECT 1 FROM purchase_episode WHERE id_member = ? AND id_cartoon=? AND episode_num=?"
                                );
                                pstPurchase.setInt(1, userId);
                                pstPurchase.setInt(2, idCartoon);
                                pstPurchase.setInt(3, epNum);
                                ResultSet rsPurchase = pstPurchase.executeQuery();

                                if (rsPurchase.next()) {  // แถวแรกที่เจอ = ซื้อแล้ว
                                    isPurchased = true;
                                    displayCoin = 0; // ซื้อแล้ว → coin = 0
                                }

                                rsPurchase.close();
                                pstPurchase.close();
                            }

                %>
                <div class="list-group-item list-group-item-action d-flex justify-content-between align-items-center episode-item" 
                     style="cursor: pointer;"
                     onclick="handleEpisodeClick(<%= idCartoon%>, <%= epNum%>, <%= displayCoin%>, <%= userId != null%>)">
                    <div>
                        <span class="fw-bold">ตอนที่ <%= epNum%></span>
                        <% if (epTitle != null && !epTitle.isEmpty()) {%>
                        <span class="text-muted"> - <%= epTitle%></span>
                        <% } %>
                        <% if (coin > 0 && !isPurchased) {%>
                        <i class="bi bi-coin text-warning ms-2"> <%= coin%></i>
                        <% } else if (coin > 0 && isPurchased) {%>
                        <i class="bi bi-check-circle-fill text-success ms-2">ซื้อแล้ว</i> 

                        <% }%>
                    </div>
                    <small class="text-muted">
                        <i class="bi bi-calendar3"></i> <%= releaseStr%>
                    </small>
                </div>
                <%
                    }
                    if (!hasEpisodes) {
                %>
                <div class="list-group-item text-center text-muted">
                    <i class="bi bi-inbox"></i> ยังไม่มีตอนในการ์ตูนเรื่องนี้
                </div>
                <%
                        }

                    } catch (Exception e) {
                        out.println("<div class='list-group-item alert-danger'>เกิดข้อผิดพลาดในการโหลดตอน: " + e.getMessage() + "</div>");
                    } finally {
                        if (rsEpisodes != null) {
                            rsEpisodes.close();
                        }
                        if (psEpisodes != null) {
                            psEpisodes.close();
                        }
                        if (rsLatest != null) {
                            rsLatest.close();
                        }
                        if (psLatest != null) {
                            psLatest.close();
                        }
                        if (rsFirst != null) {
                            rsFirst.close();
                        }
                        if (psFirst != null) {
                            psFirst.close();
                        }
                        if (rsCat != null) {
                            rsCat.close();
                        }
                        if (psCat != null) {
                            psCat.close();
                        }
                        if (rsCartoon != null) {
                            rsCartoon.close();
                        }
                        if (psCartoon != null) {
                            psCartoon.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    }
                %>
            </div>
        </div>

        <!-- เพิ่ม Modal สำหรับยืนยันการจ่ายเหรียญ -->
        <div class="modal fade" id="coinModal" tabindex="-1" aria-labelledby="coinModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-warning text-white">
                        <h5 class="modal-title" id="coinModalLabel">
                            <i class="bi bi-coin"></i> ต้องการจ่ายเหรียญ
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center">
                        <div class="mb-3">
                            <i class="bi bi-coin text-warning" style="font-size: 3rem;"></i>
                        </div>
                        <h5>ตอนนี้ต้องใช้ <span class="text-danger fw-bold" id="requiredCoin">  </span> เหรียญ</h5>
                        <p class="text-muted mb-0">คุณมี <span class="fw-bold" id="userCoinBalance"> </span> เหรียญ</p>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle"></i> ยกเลิก
                        </button>
                        <button type="button" class="btn btn-warning" id="confirmPayBtn">
                            <i class="bi bi-check-circle"></i> ยืนยัน
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal แสดงผลลัพธ์ -->
        <div class="modal fade" id="resultModal" tabindex="-1" aria-labelledby="resultModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header" id="resultModalHeader">
                        <h5 class="modal-title" id="resultModalLabel"></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center" id="resultModalBody">
                    </div>
                    <div class="modal-footer justify-content-center">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">ปิด</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- script แจ้งเตือน กดติดตาม -->
        <script>
            //ใช้ Toast/Alert แบบอัตโนมัติ แทน alert ปกติ
            function showToast(message)
            {
                const toast = document.getElementById("toastAlert");
                const toastText = document.getElementById("toastAlertText");
                toastText.innerText = message;
                toast.style.display = "block";
                // ซ่อนอัตโนมัติหลัง 3 วินาที
                setTimeout(() => {
                    toast.style.display = "none";
                }, 3000);
            }


            function followCartoon(id, isLoggedIn) {
                if (!isLoggedIn) {
                    showToast("กรุณาเข้าสู่ระบบก่อนติดตามการ์ตูน");//Toast → แจ้งผู้ใช้ด้วยกล่องเล็ก ๆ
                    return;
                }

                const heart = document.getElementById("heartIcon");
                const followBtn = document.getElementById("followBtn");

                /* ส่งข้อมูลไป Servlet แบบ AJAX  คือ วิธีส่ง/รับข้อมูลระหว่างหน้าเว็บกับ server โดยไม่ต้องรีโหลดหน้าใหม่ทั้งหมด
                 หลักการทำงาน JavaScript เรียก AJAX (ปัจจุบันใช้ fetch หรือ XMLHttpRequest) ส่ง request ไป Servlet / API
                 Server รับข้อมูล → ประมวลผล → ส่ง response กลับ JavaScript รับ response แล้วปรับหน้าเว็บทันที*/
                //ใช้ fetch API → ส่ง POST ไปยัง BookmarkServlet
                fetch('BookmarkServlet', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'id=' + encodeURIComponent(id)
                })
                        .then(response => response.text())
                        .then(message => {
                            showToast(message);

                            // เปลี่ยนสีหัวใจ + ปุ่มตามข้อความ กรณีไม่ได้ติดตาม → เพิ่มการติดตาม
                            if (message.includes("เพิ่ม")) {
                                heart.classList.remove("bi-heart");
                                heart.classList.add("bi-heart-fill", "text-danger");
                                followBtn.classList.remove("btn-outline-secondary");
                                followBtn.classList.add("btn-danger");
                                console.log("add");
                            } else if (message.includes("ลบ")) {
                                // กรณีกำลังติดตามอยู่ → ยกเลิกการติดตาม
                                heart.classList.remove("bi-heart-fill", "text-danger");
                                heart.classList.add("bi-heart");
                                followBtn.classList.remove("btn-danger");
                                followBtn.classList.add("btn-outline-secondary");
                                console.log("delete");
                            }

                        })
                        .catch(error => {
                            console.error('Error:', error);
                            showToast("เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง");
                        });
            }


            /*fetch('BookmarkServlet', {
             method: method, //POST: ส่งข้อมูลไป server , response.text() / response.json(): รับข้อมูลตอบกลับ
             /*เวลาที่เรา fetch แล้วส่งข้อมูลไป server (Servlet, API ฯลฯ) เราต้องบอกว่า 
             ข้อมูลที่ส่งไปอยู่ในรูปแบบอะไร → ตรงนี้เรียกว่า HTTP Headers
             - Content-Type = บอกชนิดของข้อมูลใน body ของ request
             - ค่า application/x-www-form-urlencoded = รูปแบบที่เหมือนเวลาส่งฟอร์มปกติ ("<form method="post">)
             headers: {'Content-Type': 'application/x-www-form-urlencoded'}, //ใช้เหมือนฟอร์ม HTML ปกติ
             body: 'id=' + encodeURIComponent(id)
             })
             .then(response => response.text())//then(...): เอาข้อมูลที่ server ตอบมาไปปรับหน้าเว็บ
             .then(message => {
             showToast(message); // ใช้ข้อความจาก Servlet
             })*/

            /* REST API การออกแบบ API ที่สื่อสารผ่าน HTTP โดยใช้ method ให้ตรงกับการกระทำ (CRUD)
             GET → ขอข้อมูล
             POST → ส่งข้อมูลใหม่ / สร้างใหม่
             PUT → อัปเดตข้อมูลทั้งก้อน
             PATCH → อัปเดตข้อมูลบางส่วน
             DELETE → ลบข้อมูล*/
        </script>

        <!-- ฟังก์ชั่น  คลิกตอนตรวจสอบเหรียญไม่มีอ่านฟรี มีให้จ่าย -->
        <script>
            // ตัวแปรเก็บข้อมูลชั่วคราว
            let pendingEpisode = {
                cartoonId: 0,
                episodeNum: 0,
                requiredCoin: 0
            };

            // ฟังก์ชันจัดการคลิกตอน
            function handleEpisodeClick(cartoonId, episodeNum, coinRequired, isLoggedIn) {
                // ถ้าไม่ต้องเสียเหรียญ → ไปอ่านเลย
                if (coinRequired === 0) {
                    window.location.href = 'ReadEpisode.jsp?id_cartoon=' + cartoonId + '&epNum=' + episodeNum;
                    return;
                }

                // ตรวจสอบการล็อกอิน
                if (!isLoggedIn) {
                    showResultModal('danger', 'ไม่สามารถอ่านได้',
                            '<i class="bi bi-exclamation-triangle" style="font-size: 3rem;"></i><br><br>กรุณาเข้าสู่ระบบก่อนเพื่อซื้อ');
                    return;
                }

                // เก็บข้อมูลตอนที่จะอ่าน
                pendingEpisode = {
                    cartoonId: cartoonId,
                    episodeNum: episodeNum,
                    requiredCoin: coinRequired
                };

                // ดึงยอดเหรียญปัจจุบันจาก server
                fetchUserCoins();
            }

            // ดึงข้อมูลเหรียญผู้ใช้ fetch API?
            function fetchUserCoins() {
                fetch('CheckCoinServlet', {
                    method: 'POST'
                })
                        .then(response => response.json())
                        .then(data => {//put sucess มา
                            if (data.success) {
                                console.log(data.message);
                                showCoinModal(data.coins);
                            } else {
                                showResultModal('danger', 'เกิดข้อผิดพลาด',
                                        '<i class="bi bi-x-circle text-danger" style="font-size: 3rem;"></i><br><br>' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('เกิดข้อผัดพลาด:', error);
                            showResultModal('danger', 'เกิดข้อผิดพลาด',
                                    '<i class="bi bi-exclamation-triangle text-danger" style="font-size: 3rem;"></i><br><br>ไม่สามารถตรวจสอบยอดเหรียญได้');
                        });
            }

            // แสดง Modal ยืนยันการจ่าย
            function showCoinModal(userCoins) {
                document.getElementById('requiredCoin').textContent = pendingEpisode.requiredCoin;
                document.getElementById('userCoinBalance').textContent = userCoins;

                const coinModal = new bootstrap.Modal(document.getElementById('coinModal'));
                coinModal.show();
            }

            // ยืนยันการจ่ายเหรียญ
            document.getElementById('confirmPayBtn').addEventListener('click', function () {
                bootstrap.Modal.getInstance(document.getElementById('coinModal')).hide();

                // ส่งคำขอจ่ายเหรียญไป Servlet
                fetch('PayCoinServlet', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'id_cartoon=' + pendingEpisode.cartoonId +
                            '&episode_num=' + pendingEpisode.episodeNum +
                            '&coin_required=' + pendingEpisode.requiredCoin
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // จ่ายสำเร็จ → แสดงผลแล้วไปหน้าอ่าน

                                showResultModal('success', 'จ่ายเหรียญสำเร็จ!',
                                        '<i class="bi bi-check-circle text-success" style="font-size: 3rem;"></i><br><br>' +
                                        'หักเหรียญแล้ว ' + pendingEpisode.requiredCoin + ' เหรียญ<br>' +
                                        'คงเหลือ <span class="fw-bold">' + data.remainingCoins + '</span> เหรียญ<br><br>' +
                                        '<small class="text-muted">กำลังเปิดหน้าอ่าน...</small>',
                                        function () {
                                            window.location.href = 'ReadEpisode.jsp?id_cartoon=' + pendingEpisode.cartoonId +
                                                    '&epNum=' + pendingEpisode.episodeNum;
                                        }
                                );
                                console.log(data.message);
                            } else {
                                // จ่ายไม่สำเร็จ (เหรียญไม่พอ)
                                showResultModal('danger', 'ยอดเหรียญไม่เพียงพอ',
                                        '<i class="bi bi-exclamation-circle text-danger" style="font-size: 3rem;"></i><br><br>' +
                                        'คุณมี <span class="fw-bold">' + data.currentCoins + '</span> เหรียญ<br>' +
                                        'ต้องการ <span class="fw-bold">' + pendingEpisode.requiredCoin + '</span> เหรียญ<br><br>' +
                                        '<div class="alert alert-warning mt-3">กรุณาเติมเหรียญก่อนอ่านตอนนี้</div>'
                                        );
                                console.log(data.message);
                            }
                        })
                        .catch(error => {
                            console.error('เกิดข้อผิดพลาด:', error);
                            showResultModal('danger', 'เกิดข้อผิดพลาด',
                                    '<i class="bi bi-x-circle text-danger" style="font-size: 3rem;"></i><br><br>ไม่สามารถดำเนินการได้ กรุณาลองใหม่อีกครั้ง');
                        });
            });

            // แสดง Modal ผลลัพธ์
            function showResultModal(type, title, message, onHideCallback) {
                const resultModal = document.getElementById('resultModal');
                const header = document.getElementById('resultModalHeader');
                const titleEl = document.getElementById('resultModalLabel');
                const body = document.getElementById('resultModalBody');

                // ปรับสีตาม type
                header.className = 'modal-header bg-' + type + ' text-white';
                titleEl.textContent = title;
                body.innerHTML = message;

                const modal = new bootstrap.Modal(resultModal);
                modal.show();

                // ถ้ามี callback ให้รันเมื่อปิด modal
                if (onHideCallback) {
                    resultModal.addEventListener('hidden.bs.modal', onHideCallback, {once: true});
                }
            }
        </script>

    </body>
</html>