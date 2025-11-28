/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// Filter สำหรับเช็ค session ทุกครั้งก่อนเข้าหน้าบางหน้า 
//ไม่ต้องเรียกใช้ในโค้ดแค่ทุกครั้งที่มีการทำงานมันจะเรียกเองแบบออโต้
@WebFilter(urlPatterns = {"/profile2.jsp", /*"/coin.jsp","/bookmark.jsp","/*Back", "/coinHistory.jsp"*/})  
public class CheckSession implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // ไม่ต้องทำอะไรก็ได้
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        // ถ้ายังไม่ได้ login
        if (session == null || session.getAttribute("email") == null) {
            res.sendRedirect(req.getContextPath() + "/login.html");
            return; // หยุดไม่ให้ไปต่อ
        }

        // ถ้า login แล้ว ให้ไปต่อ
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // ไม่ต้องทำอะไรก็ได้
    }
}
