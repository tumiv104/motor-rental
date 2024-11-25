/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ListMotoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Motorbike;

/**
 *
 * @author hungv
 */
public class ApprovalMotorbikeServlet extends HttpServlet {

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
            out.println("<title>Servlet ApprovalMotorbikeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApprovalMotorbikeServlet at " + request.getContextPath() + "</h1>");
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
        ListMotoDAO list = new ListMotoDAO();
        try {
            List<Motorbike> pendingMotorbikes = list.getPendingMotorbikes();
            request.setAttribute("pendingMotorbikes", pendingMotorbikes);
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Error loading pending motorbikes: " + ex.getMessage());
        }
        request.getRequestDispatcher("adminapproval.jsp").forward(request, response);
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
        ListMotoDAO listmt = new ListMotoDAO();
        String action = request.getParameter("action");
        String motorbikeIdParam = request.getParameter("motorbikeId");
        int motorbikeId = motorbikeIdParam != null ? Integer.parseInt(motorbikeIdParam) : 0;

        try {
            boolean success = false;
            String message = "";

            if ("approve".equals(action)) {
                success = listmt.approveMotorbike(motorbikeId);
                message = success ? "Motorbike has been approved successfully" : "Failed to approve motorbike";
            } else if ("reject".equals(action)) {
                success = listmt.rejectMotorbike(motorbikeId);
                message = success ? "Motorbike has been rejected" : "Failed to reject motorbike";
            }

            // Refresh the pending motorbikes list
            List<Motorbike> pendingMotorbikes = listmt.getPendingMotorbikes();
            request.setAttribute("pendingMotorbikes", pendingMotorbikes);

            if (success) {
                request.setAttribute("successMessage", message);
            } else {
                request.setAttribute("errorMessage", message);
            }

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "System error: " + e.getMessage());
        }

        request.getRequestDispatcher("adminapproval.jsp").forward(request, response);
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
