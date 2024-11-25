package controller;

import dal.EmailSender;
import dal.UserDAO;
import java.io.IOException;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Users;

public class ForgotPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        UserDAO userDao = new UserDAO();
        Users user = userDao.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Email không tồn tại");
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
            return;
        }

        // Tạo mã OTP ngẫu nhiên
        String otpCode = generateRandomOTP();
        long otpCreationTime = System.currentTimeMillis();

        // Lưu email và OTP vào session
        request.getSession().setAttribute("otpCode", otpCode);
        request.getSession().setAttribute("otpCreationTime", otpCreationTime);
        request.getSession().setAttribute("emailForReset", email); // Lưu email vào session

        // Gửi mã OTP đến email người dùng
        String emailContent = "Your OTP code is: " + otpCode + "\nPlease enter the OTP and reset your password immediately.";
        EmailSender.sendEmail(email, "OTP Verification", emailContent);

        // Chuyển hướng người dùng đến trang xác nhận OTP
        request.setAttribute("message", "A OTP Code has been sent to your email.");
        request.getRequestDispatcher("verifyotp.jsp").forward(request, response);
    }

    // Phương thức tạo mã OTP ngẫu nhiên
    private String generateRandomOTP() {
        String characters = "0123456789";
        Random random = new Random();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            otp.append(characters.charAt(random.nextInt(characters.length())));
        }
        return otp.toString();
    }

    @Override
    public String getServletInfo() {
        return "Forgot Password Controller";
    }
}
