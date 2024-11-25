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
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.RentalRequest;
import model.Users;

/**
 *
 * @author hungv
 */
public class UpdatePendingServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdatePendingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatePendingServlet at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        Users admin = (Users) request.getSession().getAttribute("user");
        if (admin == null || !admin.getRole().equals("Admin")) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            UserDAO ud = new UserDAO();

            // Lấy danh sách yêu cầu
            List<RentalRequest> requests = ud.getAllRentalRequests();
            request.setAttribute("requests", requests);

            // Lấy thống kê
            Map<String, Integer> stats = ud.getRentalRequestStats();
            request.setAttribute("pendingCount", stats.get("pendingCount"));
            request.setAttribute("approvedCount", stats.get("approvedCount"));
            request.setAttribute("rejectedCount", stats.get("rejectedCount"));

            // Forward đến trang quản lý
            request.getRequestDispatcher("updatepending.jsp").forward(request, response);

        } catch (SQLException e) {
            // Log lỗi
            log("Error in ProcessRentalRequestServlet.doGet: " + e.getMessage());
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("updatepending.jsp").forward(request, response);
        }
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
        Users admin = (Users) request.getSession().getAttribute("user");
        if (admin == null || !admin.getRole().equals("Admin")) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            UserDAO ud = new UserDAO();

            int requestId = Integer.parseInt(request.getParameter("requestId"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            String action = request.getParameter("action");
            String rejectReason = request.getParameter("rejectReason");
            log("RequestID: " + requestId + ", UserID: " + userId + ", Reason: " + rejectReason);

            // Kiểm tra xem yêu cầu có tồn tại và đang ở trạng thái Pending không
            if (!ud.isRequestPending(requestId)) {
                request.setAttribute("errorMessage", "Yêu cầu không tồn tại hoặc đã được xử lý!");
                doGet(request, response);
                return;
            }

            boolean success = false;
            String message = "";

            if ("approve".equals(action)) {
                success = ud.approveRentalRequest(requestId, userId, admin.getUserId());
                message = success ? "Đã phê duyệt yêu cầu nâng cấp thành công!" : "Có lỗi xảy ra khi phê duyệt yêu cầu.";
            } else if ("reject".equals(action)) {
                rejectReason = request.getParameter("rejectReason");
                if (rejectReason == null || rejectReason.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Vui lòng nhập lý do từ chối!");
                    doGet(request, response);
                    return;
                }
                success = ud.rejectRentalRequest(requestId, admin.getUserId(), rejectReason);
                message = success ? "Đã từ chối yêu cầu nâng cấp!" : "Có lỗi xảy ra khi từ chối yêu cầu.";
            }

            if (success) {
                request.setAttribute("successMessage", message);
            } else {
                request.setAttribute("errorMessage", message);
            }

            // Refresh trang với thông tin mới
            doGet(request, response);

        } catch (SQLException e) {
            log("Error in ProcessRentalRequestServlet.doPost: " + e.getMessage());
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi xử lý yêu cầu.");
            doGet(request, response);
        } catch (NumberFormatException e) {
            log("Error parsing parameters in ProcessRentalRequestServlet.doPost: " + e.getMessage());
            request.setAttribute("errorMessage", "Thông tin yêu cầu không hợp lệ.");
            request.getRequestDispatcher("updatepending.jsp").forward(request, response);
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
