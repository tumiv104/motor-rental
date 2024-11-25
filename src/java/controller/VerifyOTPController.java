/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.EmailSender;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;

/**
 *
 * @author ADMIN
 */
public class VerifyOTPController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("verifyotp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String inputOtp = request.getParameter("otp");
        String sessionOtp = (String) request.getSession().getAttribute("otpCode");
        Long otpCreationTime = (Long) request.getSession().getAttribute("otpCreationTime");

        if (otpCreationTime == null || sessionOtp == null) {
            request.setAttribute("error", "OTP không tồn tại. Vui lòng yêu cầu lại OTP.");
            request.getRequestDispatcher("verifyotp.jsp").forward(request, response);
            return;
        }

        long currentTime = System.currentTimeMillis();
        long otpExpiryTime = 1 * 60 * 1000; // 1 phút = 60 giây = 60 * 1000 ms

        if ((currentTime - otpCreationTime) > otpExpiryTime) {
            request.setAttribute("error", "OTP đã hết hạn. Vui lòng yêu cầu lại mã OTP.");
            request.getRequestDispatcher("verifyotp.jsp").forward(request, response);
        } else if (inputOtp.equals(sessionOtp)) {
            request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Mã OTP không chính xác.");
            request.getRequestDispatcher("verifyotp.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = (String) request.getSession().getAttribute("emailForReset");

        if (email != null) {
            String otpCode = generateRandomOTP();
            long otpCreationTime = System.currentTimeMillis();

            request.getSession().setAttribute("otpCode", otpCode);
            request.getSession().setAttribute("otpCreationTime", otpCreationTime);

            String emailContent = "Your OTP code is: " + otpCode + "\nPlease enter the OTP and reset your password immediately.";
            EmailSender.sendEmail(email, "OTP Verification", emailContent);

            response.getWriter().write("OTP has been resent to your email.");
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No email found in session.");
        }
    }

    private String generateRandomOTP() {
        String characters = "0123456789";
        Random random = new Random();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            otp.append(characters.charAt(random.nextInt(characters.length())));
        }
        return otp.toString();
    }
}
