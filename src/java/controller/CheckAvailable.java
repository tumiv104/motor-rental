/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BookingDAO;
import dal.CartDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Booking;
import model.Motorbike;
import model.Users;

/**
 *
 * @author Nitro
 */
public class CheckAvailable extends HttpServlet {

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
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        // Chuyển đổi String sang LocalDateTime
        LocalDateTime startDateTime = LocalDateTime.parse(startDate, formatter);
        LocalDateTime endDateTime = LocalDateTime.parse(endDate, formatter);
        // Chuyển đổi LocalDateTime sang java.sql.Timestamp
        Timestamp startTimestamp = Timestamp.valueOf(startDateTime);
        Timestamp endTimestamp = Timestamp.valueOf(endDateTime);
        BookingDAO bdb = new BookingDAO();
        Map<Motorbike, List<Booking>> list = bdb.getMotorbikeBookedByDate(startTimestamp, endTimestamp);
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        CartDAO cdb = new CartDAO();
        HashMap<Integer, Motorbike> carts = cdb.getListCartByUid(user.getUserId());
        List<Motorbike> toRemove = new ArrayList<>();
        for (Motorbike entry : list.keySet()) {
            boolean check = false;
            for (Motorbike cart : carts.values()) {
                if (cart.getMotorbikeId() == entry.getMotorbikeId()) {
                    check = true;
                    break;
                }
            }
            if (!check) {
                toRemove.add(entry);
            }
        }
        for (Motorbike motorbike : toRemove) {
            list.remove(motorbike);
        }
        StringBuilder result = new StringBuilder();
        for (Motorbike entry : list.keySet()) {
            result.append("<strong>Xe '").append(entry.getModel()).append("' không khả dụng trong ngày:</strong><ul>");

            for (Booking b : list.get(entry)) {
                result.append("<li>").append(b.getStartDate()).append(" - ").append(b.getEndDate()).append("</li>");
            }
            result.append("</ul>");
        }
        if (!list.isEmpty()) {
            result.append("<strong>Vui lòng thay đổi ngày đặt hoặc chọn xe khác !</strong><br>");
            result.append("<input type=\"hidden\" name=\"check\" value=\"1\"><br>");
        } else {
            result.append("<input type=\"hidden\" name=\"check\" value=\"0\"><br>");
        }
        long daysBetween = ChronoUnit.DAYS.between(startDateTime.toLocalDate(), endDateTime.toLocalDate());
        int days = daysBetween >= 0 ? (int) daysBetween : 0;
        result.append("<strong>Tổng số ngày thuê:</strong> ").append(days);
        Booking booking = new Booking();
        booking.setUserId(user.getUserId());
        booking.setStartDate(startTimestamp);
        booking.setEndDate(endTimestamp);
        session.setAttribute("booking", booking);
        session.setAttribute("days", days);
        response.getWriter().print(result.toString());
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
