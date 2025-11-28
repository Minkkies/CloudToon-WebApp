/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.SQLException;
import model.coinModel;

/**
 * รับฟอร์ม เติมเหรียญ + อัปโหลดสลิป ประมวลผลผ่าน Model (processCoin) แล้ว
 * เปลี่ยนหน้าไป coinSuccess.jsp
 *
 * @author Admin
 */
@WebServlet("/ProcessCoin")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 5)
public class ProcessCoin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ดึง userId จาก session
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        String userEmail = (String) request.getSession().getAttribute("email");
        if (userId == null || userEmail == null) {
            response.sendRedirect("login.html");
            return;
        }

        String strPackageId = request.getParameter("package");
        String strPrice = request.getParameter("selectedPrice");
        String strCoins = request.getParameter("selectedCoins");

        if (strPackageId == null || strPrice == null || strCoins == null) {
            response.getWriter().println("กรุณาเลือกแพ็คเกจ");
            return;
        }

        int packageId = Integer.parseInt(strPackageId);
        int price = Integer.parseInt(strPrice);
        int coins = Integer.parseInt(strCoins);

        // รับไฟล์
        Part slipPart = request.getPart("slipFile");
        if (slipPart == null || slipPart.getSize() == 0) {
            response.getWriter().println("กรุณาอัปโหลดสลิป");
            return;
        }

// อ่านไฟล์เป็น byte[]
        byte[] slipBytes = slipPart.getInputStream().readAllBytes();

// ใช้ coinModel บันทึกลง DB
        coinModel model = new coinModel();
        try {
            boolean ok = model.ProcessCoin(userId, packageId, price, coins, slipBytes);

            //เติมสำเร็จ?
            if (ok) {
                // ดึงยอดเหรียญล่าสุด
                int totalCoins = model.getUserCoins(userId);

                // ส่งข้อมูลไป JSP ผ่าน request/session
                request.setAttribute("addedCoins", coins); // เหรียญที่เติม
                request.setAttribute("totalCoins", totalCoins); // ยอดเหรียญล่าสุด

                // Forward กลับหน้า coin.jsp
                request.getRequestDispatcher("coin.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "เกิดข้อผิดพลาด");
                request.getRequestDispatcher("coin.jsp").forward(request, response);
            }
        } catch (IOException | ClassNotFoundException | SQLException e) {
            response.getWriter().println("เกิดข้อผิดพลาด: " + e.getMessage());
        }
    }
}
