package controller;

import dal.AddressDAO;
import dal.DBContext;
import dal.UserDAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Date;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Province;

public class SignupController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AddressDAO adb = new AddressDAO();
        ArrayList<Province> provinces = adb.getAllProvince();
        request.setAttribute("provinces", provinces);
        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmpassword");
        String email = request.getParameter("email");
        String fullName = request.getParameter("full_name");
        String phoneNumber = request.getParameter("phone_number");
        String address = request.getParameter("address");
        String dob = request.getParameter("date_of_birth");

        // Validate input fields
        String error = validateInput(username, password, confirmPassword, email, phoneNumber);
        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        // Check if username already exists
        if (userDAO.checkUserNameExist(username)) {
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // Add new user
        Date sqlDob = Date.valueOf(dob);  // Chuyển đổi ngày sinh sang kiểu java.sql.Date
        userDAO.addUser(username, password, fullName, email, phoneNumber, sqlDob, address);

        // Create OTP
        

        // Redirect to login page after successful signup
        response.sendRedirect("login.jsp");
    }

    private String validateInput(String username, String password, String confirmPassword,
            String email, String phoneNumber) {
        // Username validation (any characters, at least 6 characters)
        if (username.length() < 6) {
            return "Username must be at least 6 characters!";
        }
        // Password validation (between 8 and 32 characters, no special validation)
        if (password.length() < 8 || password.length() > 32) {
            return "Password must be between 8 and 32 characters!";
        }
        // Confirm password match
        if (!password.equals(confirmPassword)) {
            return "Passwords do not match.";
        }
        // Phone number validation
        if (!Pattern.matches("^[0-9]{10}$", phoneNumber)) {
            return "The phone number you entered is invalid.";
        }
        return null; // No errors
    }
    
    @Override
    public String getServletInfo() {
        return "Signup Controller";
    }
}
