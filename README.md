# CloudToon — เว็บอ่านการ์ตูน (สรุปการทำงาน)

สรุปสั้น ๆ ของโปรเจกต์นี้: CloudToon เป็นเว็บแอป Java/JSP ที่จัดการการ์ตูน (โชว์หน้าแรก, หมวดหมู่, รายละเอียดตอน, บุ๊คมาร์ก, ระบบเติมเหรียญ/ประวัติ) โดยใช้ฐานข้อมูล MySQL และเก็บภาพเป็น BLOB แล้วแปลงเป็น Base64 สำหรับแสดงบนหน้าเว็บ

## คุณสมบัติหลัก
- หน้าแรกแสดงการ์ตูนยอดนิยม / ปรับตามฐานข้อมูล — [web/index.jsp](web/index.jsp)
- หน้ารวมการ์ตูน — [web/AllCartoon.jsp](web/AllCartoon.jsp)
- หน้ารายละเอียดการ์ตูน (ดึง BLOB → Base64) — [web/CartoonDetail.jsp](web/CartoonDetail.jsp)
- ระบบบุ๊คมาร์ก (เพิ่ม/ลบ/รายการ) — [web/bookmark.jsp](web/bookmark.jsp) และ servlet: [`com.BookmarkServlet`](src/java/com/BookmarkServlet.java)
- ระบบเติมเหรียญ & ตรวจสอบยอดเหรียญ — servlets: [`com.PayCoinServlet`](src/java/com/PayCoinServlet.java) และ [`com.CheckCoinServlet`](src/java/com/CheckCoinServlet.java)
- พื้นที่แอดมิน (จัดการแพ็กเกจ, ดูประวัติเติมเหรียญ ฯลฯ) — ตัวอย่าง: [web/Back/Package/UpdatePackage.jsp](web/Back/Package/UpdatePackage.jsp), [web/Back/ShowCoinHistory.jsp](web/Back/ShowCoinHistory.jsp)
- โปรไฟล์ผู้ใช้และเปลี่ยนรหัสผ่าน — [web/profile-user/UpdateProfile.jsp](web/profile-user/UpdateProfile.jsp)

## โครงสร้างไฟล์สำคัญ (ลิงก์ให้เปิดได้)
- หน้า UI / JSP:
  - [web/index.jsp](web/index.jsp)
  - [web/AllCartoon.jsp](web/AllCartoon.jsp)
  - [web/AllCategory.jsp](web/AllCategory.jsp)
  - [web/CartoonDetail.jsp](web/CartoonDetail.jsp)
  - [web/bookmark.jsp](web/bookmark.jsp)
  - [web/profile-user/UpdateProfile.jsp](web/profile-user/UpdateProfile.jsp)
  - [web/Back/Package/UpdatePackage.jsp](web/Back/Package/UpdatePackage.jsp)
  - [web/Back/ShowCoinHistory.jsp](web/Back/ShowCoinHistory.jsp)
- Servlets / Backend:
  - [`com.PayCoinServlet`](src/java/com/PayCoinServlet.java) — จัดการการซื้อ/ธุรกรรมเหรียญ
  - [`com.CheckCoinServlet`](src/java/com/CheckCoinServlet.java) — คืนยอดเหรียญเป็น JSON
  - [`com.BookmarkServlet`](src/java/com/BookmarkServlet.java) — เพิ่ม/ลบบุ๊คมาร์ก
- การเชื่อมต่อ DB:
  - [src/java/connectDB/MyCon.java](src/java/connectDB/MyCon.java) (ใช้ใน JSP/servlet หลายไฟล์ — ปรับค่าการเชื่อมต่อที่นี่)
- สคริปต์/การ build:
  - [build.xml](build.xml), ไดเรกทอรี NetBeans: `nbproject/`

> Note: ส่วนใหญ่มีทั้งโค้ดที่ build แล้วใน `build/web/...` และไฟล์ต้นฉบับใน `web/...` — แก้ใน `web/` และ `src/java/` เป็นหลัก

## ฐานข้อมูล (MySQL)
- ตารางที่ใช้(ตัวอย่างจากโค้ด):
  - `cartoon` (รวม `cover` เป็น BLOB)
  - `register` (ผู้ใช้, coins, password, email)
  - `bookmark`, `purchase_episode`, `coin_history`, `packages_coin` ฯลฯ
- ปรับข้อมูลการเชื่อมต่อใน `connectDB.MyCon` (ไฟล์เชื่อมต่อ) ให้ตรงกับ environment ของคุณ

## การรัน / พัฒนา
1. เปิดโปรเจกต์ใน NetBeans (แนะนำ) หรือ build ด้วย Ant:
   - NetBeans: เปิดโฟลเดอร์โปรเจกต์ (มี `nbproject/`) แล้ว Run on Apache Tomcat
   - Ant: รัน `ant` (มี [build.xml](build.xml))
2. ตั้งค่า MySQL และ schema ให้ตรง
3. แก้การตั้งค่า DB ใน [src/java/connectDB/MyCon.java](src/java/connectDB/MyCon.java)
4. เข้าถึงเว็บผ่าน Tomcat (เช่น http://localhost:8080/JraBraWeb/) — หน้าหลัก: [web/index.jsp](web/index.jsp)

## ข้อสังเกต / แนะนำสั้น ๆ
- รูปภาพเก็บเป็น BLOB แล้วแปลงเป็น Base64 ก่อนแสดง (ดูตัวอย่างใน [web/CartoonDetail.jsp](web/CartoonDetail.jsp), [web/AllCartoon.jsp](web/AllCartoon.jsp))
- ควรย้าย logic ด้านธุรกรรม/DB จาก JSP ไปยัง Servlets/DAO สำหรับความปลอดภัยและแยก concerns
- รหัสผ่านใน DB ปัจจุบันเก็บ plaintext — แนะนำใช้งาน hashing (bcrypt) และ prepared statements (ซึ่งโปรเจกต์ใช้ แต่ตรวจสอบทุกที่ให้ครบ)
- ตรวจสอบการปิด resource (ResultSet/PreparedStatement/Connection) ให้ครบถ้วน — มีหลายที่ใช้ try-finally แล้วแต่อาจมีจุดหลุด

## เอกสารอ้างอิง (ไฟล์ที่ควรเปิดดู)
- หน้าแรก: [web/index.jsp](web/index.jsp)  
- รายละเอียดการ์ตูน: [web/CartoonDetail.jsp](web/CartoonDetail.jsp)  
- บุ๊คมาร์ก backend: [`com.BookmarkServlet`](src/java/com/BookmarkServlet.java) — [src/java/com/BookmarkServlet.java](src/java/com/BookmarkServlet.java)  
- จัดการเหรียญ: [`com.PayCoinServlet`](src/java/com/PayCoinServlet.java) — [src/java/com/PayCoinServlet.java](src/java/com/PayCoinServlet.java)  
- ตรวจสอบเหรียญ: [`com.CheckCoinServlet`](src/java/com/CheckCoinServlet.java) — [src/java/com/CheckCoinServlet.java](src/java/com/CheckCoinServlet.java)  
- การเชื่อมต่อ DB: [src/java/connectDB/MyCon.java](src/java/connectDB/MyCon.java)  
- Build (NetBeans/Ant): [build.xml](build.xml)

// ...existing code...

## ภาพรวมจาก ProjectReport.pdf

สรุปสั้น ๆ ของไฟล์รายงานโปรเจกต์ (ProjectReport.pdf):

- วัตถุประสงค์: พัฒนาเว็บ CloudToon ให้ผู้ใช้สามารถอ่านการ์ตูนออนไลน์ จัดการบุ๊คมาร์ก และเติมเหรียญเพื่อซื้อเนื้อหาได้อย่างสะดวกบนแพลตฟอร์มเว็บ
- ขอบเขตงาน: ครอบคลุมการออกแบบระบบ การพัฒนาอินเทอร์เฟซด้วย JSP, การเชื่อมต่อฐานข้อมูล MySQL, การจัดเก็บภาพเป็น BLOB และการแปลงเป็น Base64 เพื่อแสดงผล รวมถึงฟังก์ชันผู้ใช้-ผู้ดูแล (user/admin)
- สถาปัตยกรรมและเทคโนโลยี: ใช้ Java Servlet/JSP รันบน Apache Tomcat, MySQL เป็นฐานข้อมูล, โค้ดบางส่วนอยู่ใน Servlets สำหรับธุรกรรม (เช่น การเติมเหรียญ, บุ๊คมาร์ก) และมีการใช้ PreparedStatement ในการเข้าถึง DB
- โครงสร้างข้อมูล: ออกแบบตารางหลัก เช่น cartoon (เก็บ cover เป็น BLOB), register (ข้อมูลผู้ใช้และยอดเหรียญ), bookmark, coin_history, purchase_episode และ packages_coin
- การออกแบบหน้าจอ/ฟีเจอร์หลัก: หน้าแรกแสดงการ์ตูนยอดนิยม, หน้ารายละเอียดการ์ตูนพร้อมภาพและตอน, ระบบบุ๊คมาร์ก, ระบบการเติมเหรียญและประวัติการซื้อ, หน้าจอจัดการแพ็กเกจสำหรับแอดมิน
