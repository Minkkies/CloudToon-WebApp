<%-- 
    Document   : login
    Created on : Sep 22, 2025, 9:13:06 PM
    Author     : Admin
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
                out.println("<script>alert('กรุณากรอกข้อมูลให้ครบถ้วน'); window.location='login.html';</script>");
                return;
            }

            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connectDB.MyCon m = new connectDB.MyCon();
                con = m.myConnect();

                // ตรวจสอบ user
                //String query = "SELECT email, role FROM register WHERE email = ? AND password = ?";
                String query = "SELECT * FROM register WHERE email=? AND password = ?";
                pst = con.prepareStatement(query);
                pst.setString(1, email);
                pst.setString(2, password);
                rs = pst.executeQuery();

                if (rs.next()) {
                    // สร้าง session HttpSession session = request.getSession();สร้างหรือใช้ session ที่มีอยู่
                    // เก็บข้อมูลผู้ใช้ลง session
                    //ใช้ ResultSet (rs) จาก SELECT query ที่ดึงมาทั้งหมดจาก table register แล้วเอาข้อมูลเหล่านี้ไปเก็บใน session
                    session.setAttribute("userId", rs.getInt("id_member")); // id เป็น primary key เ
                    session.setAttribute("username", rs.getString("username"));//เผื่อใช้
                    session.setAttribute("email", rs.getString("email"));
                    session.setAttribute("birthdate", rs.getString("birthday"));
                    session.setAttribute("phone", rs.getString("phone_num"));
                    session.setAttribute("role", rs.getString("role"));
                    // ดึง coins จาก DB และเก็บลง session
                    int Coins = rs.getInt("coins");
                    if (rs.wasNull()) {
                        Coins = 0;
                    }
                    session.setAttribute("coins", Coins);

                    //ตั้งค่าให้ session หมดอายุ
                    // -1 = session จะไม่หมดอายุเอง จนกว่าผู้ใช้จะปิด browser หรือ logout
                    session.setMaxInactiveInterval(30 * 60); // 30 นาที

                    // แยกการ redirect ตามประเภทผู้ใช้
                    String role = rs.getString("role");
                    if ("admin".equals(role)) {
                        response.getWriter().println(
                                "<script>alert('✅ เข้าสู่ระบบสำเร็จ! (แอดมิน)'); window.location='./Back/BackIndex.jsp';</script>"
                        );
                    } else {
                        //ต้องใช้ URL parameter เพราะหน้าเว็บเราเป็น html เลยเรียกแบบไม่ต้องส่งผ่าน URL  = 'index.html?email=" + email + "'
                        /*แต่ถ้าใช้ jsp ได้เลยเพราะ session เก็บข้อมูลไว้ให้ทุกหน้า
                    HttpSession session = request.getSession(false);
                    if(session == null || session.getAttribute("email") == null){
                        response.sendRedirect("login.html");
                        return;
                    }

                    String email = (String) session.getAttribute("email");
                        
                        out.println("DEBUG: Coins from session = " + session.getAttribute("coins")); // 0
                        out.println("DEBUG: userId from session = " + session.getAttribute("userId")); // ถูกต้อง
                        out.println("DEBUG: name from session = " + session.getAttribute("username")); // ถูกต้อง
                        out.println("DEBUG: date from session = " + session.getAttribute("birthdate")); // ถูกต้อง
                        out.println("DEBUG: phone from session = " + session.getAttribute("phone")); // ถูกต้อง
                        out.println("DEBUG: pass from session = " + session.getAttribute("password")); // null เพราะยังไม่ได้เซ็ต  */
                          response.getWriter().println(
                                "<script>alert('✅ เข้าสู่ระบบสำเร็จ!'); window.location = 'index.jsp';</script>"
                        );
                    }
                } else {
                    response.getWriter().println(
                            "<script>alert('⚠️ เข้าสู่ระบบไม่สำเร็จ กรุณาตรวจสอบ email หรือ password'); window.location = 'login.html';</script>"
                    );
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
                e.printStackTrace();
            } finally { // ปิด resource ให้เรียบร้อย
                try {
                    if (rs != null) {
                        rs.close();
                    }
                } catch (Exception e) {
                }
                try {
                    if (pst != null) {
                        pst.close();
                    }
                } catch (Exception e) {
                }
                try {
                    if (con != null) {
                        con.close();
                    }
                } catch (Exception e) {
                }
            }
        %>
    </body>
</html>
