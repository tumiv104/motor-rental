/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package statistic;

import dal.StatisticDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hungv
 */
public class StatisticServlet extends HttpServlet {

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
            out.println("<title>Servlet StatisticServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StatisticServlet at " + request.getContextPath() + "</h1>");
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
        StatisticDAO statisticsDAO = new StatisticDAO();
        int totalBookings = 0;
        try {
            totalBookings = statisticsDAO.getTotalBookings();
        } catch (SQLException ex) {
            Logger.getLogger(StatisticServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        Map<String, BigDecimal> revenueData = new HashMap<>();
        try {
            revenueData = statisticsDAO.getTotalRevenue(); // Lấy dữ liệu từ DAO
        } catch (SQLException ex) {
            Logger.getLogger(StatisticServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("paymentData", revenueData);
        double avgRating = 0;
        try {
            avgRating = statisticsDAO.getAverageRating();
        } catch (SQLException ex) {
            Logger.getLogger(StatisticServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        double totalFees = 0;
        try {
            totalFees = statisticsDAO.getTotalAdditionalFees();
        } catch (SQLException ex) {
            Logger.getLogger(StatisticServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        int totalPayments = 0;
        try {
            totalPayments = statisticsDAO.getTotalPayments();
        } catch (SQLException ex) {
            Logger.getLogger(StatisticServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            // Lấy thống kê doanh thu theo ngày
            Map<String, Double> revenueByDay = statisticsDAO.getRevenueByDay();
            request.setAttribute("revenueByDay", revenueByDay);

            // Lấy thống kê doanh thu theo tuần
            Map<String, Double> revenueByWeek = statisticsDAO.getRevenueByWeek();
            request.setAttribute("revenueByWeek", revenueByWeek);

            // Lấy thống kê doanh thu theo tháng
            Map<String, Double> revenueByMonth = statisticsDAO.getRevenueByMonth();
            request.setAttribute("revenueByMonth", revenueByMonth);

            // Lấy thống kê doanh thu theo năm
            Map<String, Double> revenueByYear = statisticsDAO.getRevenueByYear();
            request.setAttribute("revenueByYear", revenueByYear);
            
            List<Object[]> staticMotorbike = statisticsDAO.getMotorbikeStatisticsByType();
            request.setAttribute("statistic", staticMotorbike);

        } catch (SQLException ex) {
            // Ghi log lỗi
            Logger.getLogger(StatisticServlet.class.getName()).log(Level.SEVERE, "Error getting statistics", ex);
            // Có thể thêm thông báo lỗi cho người dùng
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi lấy dữ liệu thống kê");
        }

        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("avgRating", avgRating);
        request.setAttribute("totalFees", totalFees);
        request.setAttribute("totalPayments", totalPayments);
        request.getRequestDispatcher("statistic.jsp").forward(request, response);

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
