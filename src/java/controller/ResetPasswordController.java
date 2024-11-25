package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ResetPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy email từ session
        String email = (String) request.getSession().getAttribute("emailForReset");

        // Lấy mật khẩu mới từ request
        String newPassword1 = request.getParameter("newPassword1");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        // Kiểm tra xem mật khẩu mới và mật khẩu xác nhận có khớp hay không
        if (!newPassword1.equals(confirmNewPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu mới
        UserDAO userDAO = new UserDAO();
        userDAO.updatePasswordByEmail(email, newPassword1);

        request.setAttribute("successMessage", "Mật khẩu đã được đặt lại thành công.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Reset Password Controller";
    }
}
