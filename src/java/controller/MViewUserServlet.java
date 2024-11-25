/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import java.util.List;
import model.Users;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.SQLException;

/**
 *
 * @author hungv
 */
public class MViewUserServlet extends HttpServlet {

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
            out.println("<title>Servlet ManageUserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageUserServlet at " + request.getContextPath() + "</h1>");
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
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || (!role.equals("Admin") && !role.equals("Manager"))) {
            response.sendRedirect("home");
            return;
        }

        int page = 1;
        int recordsPerPage = 3;

        try {
            page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
        } catch (NumberFormatException e) {
            page = 1;
        }

        CRUDUser crudUser = new CRUDUser();

        // Get paginated data
        List<Users> userList = crudUser.getPaginatedUsers((page - 1) * recordsPerPage, recordsPerPage);
        int totalRecords = crudUser.getTotalUsers();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        // Check and unban users whose ban period has expired
        for (Users user : userList) {
            if (user.getBannedUntil() != null && user.getBannedUntil().before(new Date(System.currentTimeMillis()))) {
                crudUser.unbanUser(user.getUserId());
                user.setBannedUntil(null);
            }
        }

        request.setAttribute("userList", userList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("recordsPerPage", recordsPerPage);

        request.getRequestDispatcher("manageuser.jsp").forward(request, response);
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
        CRUDUser cr = new CRUDUser();
        String action = request.getParameter("action");

        if ("ban".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String reason = request.getParameter("banReason");
            String bannedUntilStr = request.getParameter("bannedUntil");

            if (bannedUntilStr != null && !bannedUntilStr.isEmpty()) {
                try {
                    Date bannedUntil = Date.valueOf(bannedUntilStr);
                    if (bannedUntil.after(new Date(System.currentTimeMillis()))) {
                        cr.banUser(userId, reason, bannedUntil);
                        request.setAttribute("message", "User banned successfully.");
                    } else {
                        request.setAttribute("error", "Banned date must be greater than the current date.");
                    }
                } catch (IllegalArgumentException e) {
                    request.setAttribute("error", "Invalid date format for bannedUntil. Please use yyyy-mm-dd.");

                }
            } else {
                request.setAttribute("error", "bannedUntil date cannot be empty.");
            }
        } else if ("unban".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            cr.unbanUser(userId);
            request.setAttribute("message", "User unbanned successfully.");
        } else if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            cr.deleteUser(userId);
            request.setAttribute("message", "User deleted successfully.");
        }
        response.sendRedirect("manageuser");
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
