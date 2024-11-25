package controller;

import dal.CRUDUser;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Users;

public class AdmCreateUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CRUDUser cr = new CRUDUser();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("createuserbyadmin.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy các thông tin từ form
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String dob = request.getParameter("dateOfBirth");
            //String userType = request.getParameter("userType");
            String role = request.getParameter("role");

            // Kiểm tra các trường bắt buộc
            if (username == null || username.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || password == null || password.trim().isEmpty()
                    || fullName == null || fullName.trim().isEmpty()
                    //|| userType == null || userType.trim().isEmpty()
                    || role == null || role.trim().isEmpty()
                    || !role.matches("(Admin|Manager)")) { // Kiểm tra role hợp lệ

                request.setAttribute("message", "Please fill in all required fields correctly.");
                request.getRequestDispatcher("createuserbyadmin.jsp").forward(request, response);
                return;
            }

            // Chuyển đổi date
            Date dateOfBirth = null;
            if (dob != null && !dob.isEmpty()) {
                dateOfBirth = Date.valueOf(dob);
            }

            // Tạo đối tượng Users
            Users newUser = new Users();
            newUser.setUsername(username);
            newUser.setEmail(email);
            newUser.setPassword(password);
            newUser.setFullName(fullName);
            newUser.setPhoneNumber(phoneNumber);
            newUser.setDateOfBirth(dateOfBirth);
            //newUser.setUserType(userType);
            newUser.setRole(role);

            // Thêm user mới
            cr.addUser(newUser);

            // Chuyển hướng sau khi thành công
            response.sendRedirect("manageuser");

        } catch (SQLException ex) {
            if (ex.getMessage().contains("UNIQUE")) {
                request.setAttribute("message", "Username or email already exists.");
            } else {
                request.setAttribute("message", "An error occurred while creating the user.");
            }
            request.getRequestDispatcher("createuserbyadmin.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
