<%-- 
    Document   : ReadEpisode
    Created on : Oct 4, 2025, 10:30:17 PM
    Author     : Admin
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ตอนการ์ตูน</title>

        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>
        
        <style>

            /*.pdf-container {width: 100%;height: 90vh; /* สูงเกือบเต็มหน้าจอ }*/

            #pdf-viewer {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 20px;
                margin-top: 20px;
            }
            /* canvas ปกติ */
            canvas {
                border: 1px solid #ccc;
                box-shadow: 0 2px 8px rgba(0,0,0,0.2);
                width: 100%;       /* ปรับขนาดเต็ม container */
                height: auto;      /* คงอัตราส่วน */
                max-width: 800px;  /* ขนาดสูงสุดบน desktop */
            }
            /* ขนาดจอ medium (tablet) */
            @media (max-width: 992px) {
                canvas {
                    max-width: 600px;
                }
            }

            /* ขนาดจอ small (mobile) */
            @media (max-width: 576px) {
                canvas {
                    max-width: 100%;  /* เต็มหน้าจอ */
                }
            }

        </style>
    </head>

    <body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous">
        </script>

        <!-- Header -->
        <jsp:include page="./nav/nav-index.jsp"/>

        <div class="container my-5">

            <%
                // ดึง userId จาก session
                Integer userId = (Integer) session.getAttribute("userId");
                // ดึงค่า email จาก session (server-side)
                String email = (String) session.getAttribute("email");
                String idCartoonParam = request.getParameter("id_cartoon");
                String episodeParam = request.getParameter("epNum");
                int idCartoon = 1, episodeNum = 1;

                if (idCartoonParam != null) {
                    idCartoon = Integer.parseInt(idCartoonParam);
                }
                if (episodeParam != null) {
                    episodeNum = Integer.parseInt(episodeParam);
                }

                Connection conn = null;
                PreparedStatement pst = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connectDB.MyCon m = new connectDB.MyCon();
                    conn = m.myConnect();

                    String sql = "SELECT * FROM episode WHERE cartoon_ref = ? AND episode_num = ?";
                    pst = conn.prepareStatement(sql);
                    pst.setInt(1, idCartoon);
                    pst.setInt(2, episodeNum);
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        int epNum = rs.getInt("episode_num");
                        String title = rs.getString("episode_title");
                        String releaseDate = rs.getString("release_date");
                        // ตรวจสอบว่าตอนนี้ต้องใช้เหรียญหรือไม่
                        int episodeCoin = rs.getInt("coin"); // สมมติว่ามี rs จาก query episode

                        if (episodeCoin > 0) {
                            // ต้องใช้เหรียญ → ตรวจสอบว่าซื้อแล้วหรือยัง

                            // ถ้าไม่ได้ login
                            if (userId == null) {
                                out.println("<div class='container mt-5'>");
                                out.println("<div class='alert alert-danger text-center'>");
                                out.println("<i class='bi bi-lock-fill' style='font-size: 3rem;'></i>");
                                out.println("<h4 class='mt-3'>ตอนนี้ต้องใช้ " + episodeCoin + " เหรียญ</h4>");
                                out.println("<p>กรุณาเข้าสู่ระบบก่อนอ่านตอนที่ต้องใช้เหรียญ</p>");
                                out.println("<a href='Login.jsp' class='btn btn-primary mt-2'>");
                                out.println("<i class='bi bi-box-arrow-in-right'></i> เข้าสู่ระบบ</a>");
                                out.println("</div></div>");
                                return;
                            }

                            // ตรวจสอบว่าซื้อตอนนี้แล้วหรือยัง
                            PreparedStatement pstPurchase = conn.prepareStatement(
                                    "SELECT 1 FROM purchase_episode WHERE id_member = ? AND id_cartoon = ? AND episode_num = ?"
                            );
                            pstPurchase.setInt(1, userId);
                            pstPurchase.setInt(2, idCartoon);
                            pstPurchase.setInt(3, episodeNum);
                            ResultSet rsPurchase = pstPurchase.executeQuery();

                            boolean hasPurchased = rsPurchase.next();
                            rsPurchase.close();
                            pstPurchase.close();

                            if (!hasPurchased) {
                                // ยังไม่ได้ซื้อ → ไม่อนุญาตให้อ่าน
                                out.println("<div class='container mt-5'>");
                                out.println("<div class='alert alert-warning text-center'>");
                                out.println("<i class='bi bi-coin text-warning' style='font-size: 3rem;'></i>");
                                out.println("<h4 class='mt-3'>ตอนนี้ต้องใช้ " + episodeCoin + " เหรียญ</h4>");
                                out.println("<p>คุณยังไม่ได้ซื้อตอนนี้ กรุณากลับไปหน้ารายละเอียดเพื่อทำการซื้อ</p>");
                                out.println("<a href='CartoonDetail.jsp?id=" + idCartoon + "' class='btn btn-warning mt-2'>");
                                out.println("<i class='bi bi-arrow-left'></i> กลับไปหน้ารายละเอียด</a>");
                                out.println("</div></div>");
                                return;
                            }

                        }

            %>
            <h2><%= title%></h2>
            <p>เผยแพร่เมื่อ: <%= releaseDate%></p>
            <hr>

            <!-- ✅ ฝัง PDF ผ่าน iframe แบบนี้มันขึ้นตัว viewer ใสด้วยไม่สวย
            <div class="pdf-container">
                <iframe src="EpisodeFileServlet?id_episode=<= idEpisode%>" 
                        width="100%" height="100%"></iframe>
            </div> -->

            <div id="pdf-viewer"></div>

            <%
                } else {
                    out.println("<div class='alert alert-warning'>ไม่พบตอนนี้</div>");
                }

                // คำนวณก่อนหน้า/ถัดไป นับ จำนวนตอนทั้งหมดของการ์ตูนนี้
                String sqlCount = "SELECT COUNT(*) FROM episode WHERE cartoon_ref = ? ";
                pst = conn.prepareStatement(sqlCount);
                pst.setInt(1, idCartoon);
                ResultSet rsCount = pst.executeQuery();
                int totalEpisodes = 0;
                if (rsCount.next()) {
                    totalEpisodes = rsCount.getInt(1);
                }

                int prev = episodeNum - 1;
                int next = episodeNum + 1;
            %>
            <div class="mt-3">
                <% if (prev > 0) {%>
                <a href="ReadEpisode.jsp?id_cartoon=<%= idCartoon%>&epNum=<%= prev%>" class="btn btn-primary">ก่อนหน้า</a>
                <% }%>
                <a href="CartoonDetail.jsp?id=<%= idCartoon%>" class="btn btn-primary">
                    <h5 class="card-title"><i class="bi bi-book"></i></h5>
                </a>
                <% if (next <= totalEpisodes) {%>
                <a href="ReadEpisode.jsp?id_cartoon=<%= idCartoon%>&epNum=<%= next%>" class="btn btn-primary">ถัดไป</a>
                <% } %>
            </div>
            <%
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>เกิดข้อผิดพลาด: " + e.getMessage() + "</div>");
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
        </div>

        <!-- โหลด PDF.js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.16.105/pdf.min.js"></script>
        <script>
                    // ดึงไฟล์ PDF จาก servlet ที่ส่ง PDF กลับมา
                    const url = "EpisodeFileServlet?id_cartoon=<%= idCartoon%>&epNum=<%= episodeNum%>";

                    // ตั้งค่า worker
                    pdfjsLib.GlobalWorkerOptions.workerSrc = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.16.105/pdf.worker.min.js";

                    // โหลด PDF
                    const loadingTask = pdfjsLib.getDocument(url);
                    loadingTask.promise.then(pdf => {
                        console.log("PDF loaded, total pages: " + pdf.numPages);

                        // loop ทุกหน้า
                        for (let i = 1; i <= pdf.numPages; i++) {
                            pdf.getPage(i).then(page => {
                                const scale = 1.2; // ขยาย
                                const viewport = page.getViewport({scale: scale});

                                const canvas = document.createElement("canvas");
                                const context = canvas.getContext("2d");
                                canvas.height = viewport.height;
                                canvas.width = viewport.width;

                                document.getElementById("pdf-viewer").appendChild(canvas);

                                page.render({canvasContext: context, viewport: viewport});
                            });
                        }
                    }).catch(err => {
                        console.error("Error loading PDF: " + err);
                    });
        </script>


        <!-- เก็บตอนที่อ่านล่าสุดของยูสเซอร์ไว้ที่ local storage แล้วไปแสดงที่หน้ารายละเอียดการ์ตูน  
        Local Storage ->ก็ ข้อมูลใหญ่ได้, ใช้งาน JS ง่าย ถูกเก็บ ฝังอยู่ในเบราว์เซอร์
                            -> ข้อมูลไม่ส่งกลับ server → ใช้กับ last read, bookmark, UI settings
        ใช้กับการ Bookmark / Last Read / Preferences → Local Storage แต่ขกแก้รายการโปรด
        เก็บตอนล่าสุดของผู้ใช้ (ReadEpisode.jsp) ใช้ localStorage แยกตาม user → cartoon  ข้อมูลไม่หายและไม่ทับกัน
        
        -->
        <script>//Local storage
            (function () {
                // ดึงข้อมูลจาก session
                const userEmail = "<%= email != null ? email : ""%>";
                const cartoonId = "<%= request.getParameter("id_cartoon") != null ? request.getParameter("id_cartoon") : ""%>";
                const episodeNum = "<%= request.getParameter("epNum") != null ? request.getParameter("epNum") : ""%>";

                console.log("📖 กำลังอ่านตอน:", {userEmail, cartoonId, episodeNum});//เปิดดูใน Inspect

                // ตรวจสอบว่ามีข้อมูลครบถ้วน
                if (!userEmail || userEmail === "null" || userEmail.trim() === "") {
                    console.warn("⚠️ ยังไม่ได้ login - ไม่บันทึกประวัติการอ่าน");
                    return;
                }

                if (!cartoonId || !episodeNum) {
                    console.warn("⚠️ ข้อมูลการ์ตูนหรือตอนไม่ครบ");
                    return;
                }

                try {
                    // อ่านข้อมูลเก่าจาก localStorage จัดเก็บข้อมูลเป็น โครงสร้างแบบ user → cartoon → episode
                    //JSON.stringify / JSON.parse → แปลงวัตถุ JS เป็น string เพื่อเก็บ และแปลงกลับ
                    let lastReads = JSON.parse(localStorage.getItem("lastReads") || "{}");

                    // ถ้ายังไม่มีข้อมูลของ user นี้ ให้สร้างใหม่
                    if (!lastReads[userEmail]) {
                        lastReads[userEmail] = {};
                    }

                    /* บันทึกตอนที่อ่าน โค้ดบนสุดใช้แยกผู้ใช้กับเรื่อง เป็น Obj 
                     Key ระดับแรก → userEmail แยกผู้ใช้
                     Key ระดับสอง → cartoonId แยกแต่ละการ์ตูนของผู้ใช้นั้น
                     Value → Object ของตอนล่าสุด (episodeNum) + ข้อมูลเวลา (timestamp, lastRead)
                     {
                     "user1@example.com": {       // แยกตาม user
                     "101": {                   // แยกตาม cartoonId
                     episodeNum: 5,
                     timestamp: "2025-10-07T15:00:00Z",
                     lastRead: "07/10/2025, 15:00"
                     },
                     "102": {
                     episodeNum: 2,
                     timestamp: "2025-10-06T12:00:00Z",
                     lastRead: "06/10/2025, 12:00"
                     }
                     },
                     }
                     */
                    lastReads[userEmail][cartoonId] = {
                        //เก็บ episodeNum + timestamp เพื่อเรียกใช้ต่อ
                        episodeNum: parseInt(episodeNum),
                        timestamp: new Date().toISOString(),
                        lastRead: new Date().toLocaleString('th-TH')
                    };

                    // บันทึกลง localStorage
                    localStorage.setItem("lastReads", JSON.stringify(lastReads));

                    console.log("✅ บันทึกประวัติการอ่านสำเร็จ");
                    console.log("📊 ข้อมูลที่บันทึก:", lastReads[userEmail][cartoonId]);

                } catch (error) {
                    console.error("❌ เกิดข้อผิดพลาดในการบันทึก:", error);
                }
            })();
        </script>
</html>
</body>
</html>
