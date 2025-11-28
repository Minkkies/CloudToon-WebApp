<%-- 
    Document   : c-register
    Created on : Sep 22, 2025, 8:23:33 PM
    Author     : Admin
--%>

<%@page import="java.sql.*" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>จัดการบัญชีผู้ใช้</title>
        <link rel="stylesheet" href="../../stylesheet.css">

        <!-- Favicon -->
        <link rel="icon" type="image/svg+xml"
              href='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="lightblue"  viewBox="0 0 16 16"><path d="M4.406 3.342A5.53 5.53 0 0 1 8 2c2.69 0 4.923 2 5.166 4.579C14.758 6.804 16 8.137 16 9.773 16 11.569 14.502 13 12.687 13H3.781C1.708 13 0 11.366 0 9.318c0-1.763 1.266-3.223 2.942-3.593.143-.863.698-1.723 1.464-2.383"/></svg>'>
          
    </head>
    <body>
        <%	
            request.setCharacterEncoding("UTF-8");
	Connection conn = null;
	Statement s = null;
               PreparedStatement pstmt = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		
		conn =  DriverManager.getConnection("jdbc:mysql://localhost/projectweb2204?autoReconnect=true&useSSL=false","root", "mink20685");
		
		s = conn.createStatement();
		
		String Username = request.getParameter("username");
		String Email = request.getParameter("email");
		String Birthday = request.getParameter("birthday");// yyyy-MM-dd
                                String Phone = request.getParameter("phone_num");
                                String Password = request.getParameter("password");


                 String sql = "INSERT INTO register (username, email, birthday, phone_num, password, role) VALUES (?, ?, ?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, Username); //(colที่, ตัวแปรที่ getParameter)
                    pstmt.setString(2, Email);
                    pstmt.setString(3, Birthday);
                    pstmt.setString(4, Phone);
                    pstmt.setString(5, Password);
                    pstmt.setString(6, "customer");

                    int rows = pstmt.executeUpdate();
                                        if (rows > 0) {
                        //response.sendRedirect("./backOffice/r-stock.jsp");
                        //response.getWriter().println("✅ Image uploaded successfully!");
                        
                        //แสดงข้อความแจ้งเดตือนและกลับไปหน้า insert
                        response.getWriter().println(
                                "<script>alert('✅ signup successfully!'); window.location='../../login.html';</script>"
                        );

                    } else {
                        //response.sendRedirect("./backOffice/error_page.jsp");
                        //response.getWriter().println("❌ Image upload failed.");
                         response.getWriter().println(
                                "<script>alert('❌ signup failed');</script>"
                        );
                    }

                out.println(sql);
         s.execute(sql);
//         out.println("Record Insert Successfully");       
//         response.sendRedirect("ShowRegister.jsp");
	  		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
		}
	
		try {
			if(s!=null){
				s.close();
				conn.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
                                                response.getWriter().println("Error: " + e.getMessage());
		}
	%>
    </body>
</html>

