/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;
import java.sql.Timestamp;
import java.util.Date;
import model.RentalUpgradeRequest;

/**
 *
 * @author hungv
 */
public class UpdateAccountRoleServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateAccountRoleServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAccountRoleServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        UserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession(false);

        try {
            Users user = (Users) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy thông tin từ form
            String phoneNumber = request.getParameter("phone_number");
            String address = request.getParameter("address");
            String reason = request.getParameter("reason");

            // Validate dữ liệu một lần nữa ở server
            if (phoneNumber == null || !phoneNumber.matches("\\d{10}")) {
                request.setAttribute("errorMessage", "Số điện thoại không hợp lệ");
                request.getRequestDispatcher("updateaccountrole.jsp").forward(request, response);
                return;
            }

            if (address == null || address.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Địa chỉ không được để trống");
                request.getRequestDispatcher("updateaccountrole.jsp").forward(request, response);
                return;
            }

            if (reason == null || reason.trim().length() < 10) {
                request.setAttribute("errorMessage", "Lý do phải có ít nhất 10 ký tự");
                request.getRequestDispatcher("updateaccountrole.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng request
            RentalUpgradeRequest upgradeRequest = new RentalUpgradeRequest();
            upgradeRequest.setUserId(user.getUserId());
            upgradeRequest.setPhoneNumber(phoneNumber.trim());
            upgradeRequest.setAddress(address.trim());
            upgradeRequest.setReason(reason.trim());
            upgradeRequest.setStatus("Pending");
            upgradeRequest.setRequestDate(new Date());

            // Lưu request và cập nhật user type
            userDAO.saveRentalUpgradeRequest(upgradeRequest);
            userDAO.updateUserType(user.getUserId(), "PendingRental");

            // Cập nhật session
            user.setUserType("PendingRental");
            session.setAttribute("user", user);

            // Chuyển hướng với thông báo thành công
            request.setAttribute("successMessage", "Yêu cầu nâng cấp tài khoản đã được gửi thành công! Vui lòng đợi admin phê duyệt.");
            request.getRequestDispatcher("updatepending.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("updateaccountrole.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
