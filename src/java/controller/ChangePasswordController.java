package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;
import dal.UserDAO;

public class ChangePasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("changepassword.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Users user = (Users) session.getAttribute("user");
        String username = user.getUsername(); // Lấy tên người dùng từ session
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");
        
        UserDAO userDAO = new UserDAO();
        // Kiểm tra mật khẩu hiện tại
        if (!userDAO.checkPassword(username, currentPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu hiện tại không chính xác.");
            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xem mật khẩu mới và mật khẩu xác nhận có khớp hay không
        if (!newPassword.equals(confirmNewPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu mới
        userDAO.updatePassword(user.getUserId(), newPassword);
        request.setAttribute("successMessage", "Mật khẩu đã được thay đổi thành công.");
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

}
