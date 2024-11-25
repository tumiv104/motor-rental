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
import java.util.List;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Motorbike;

/**
 *
 * @author hungv
 */
public class ListMotobikeServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ListMotobikeServlet.class.getName());

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
            out.println("<title>Servlet ListMotobikeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListMotobikeServlet at " + request.getContextPath() + "</h1>");
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
        String searchTerm = request.getParameter("search");
        String priceOrder = request.getParameter("priceOrder");
        int page = 1;
        int pageSize = 6;

        // Phân trang
        try {
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) {
                    page = 1;
                }
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        ListMotoDAO motorbikeDAO = new ListMotoDAO();
        try {
            List<Motorbike> motorbikes;
            int totalMotorbikes;

            boolean ascending = "asc".equals(priceOrder);
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                motorbikes = motorbikeDAO.searchMotorbikes(searchTerm, page, pageSize);
                totalMotorbikes = motorbikeDAO.getTotalSearchResults(searchTerm);
            } else if (priceOrder != null) {
                motorbikes = motorbikeDAO.getMotorbikesByPrice(page, pageSize, ascending);
                totalMotorbikes = motorbikeDAO.getTotalMotorbikesByPrice(ascending);
            } else {
                motorbikes = motorbikeDAO.getMotorbikes(page, pageSize);
                totalMotorbikes = motorbikeDAO.getTotalMotorbikes();
            }

            int totalPages = (int) Math.ceil((double) totalMotorbikes / pageSize);
            request.setAttribute("motorbikes", motorbikes);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchTerm", searchTerm);
            request.setAttribute("priceOrder", priceOrder);
            request.getRequestDispatcher("listmotorbike.jsp").forward(request, response);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL error", e);
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
        processRequest(request, response);
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
