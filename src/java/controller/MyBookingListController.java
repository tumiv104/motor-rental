/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Booking;
import model.Users;

/**
 *
 * @author Nitro
 */
public class MyBookingListController extends HttpServlet {

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
        BookingDAO bdb = new BookingDAO();
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        ArrayList<Booking> list;
        String status = request.getParameter("status");
        if (status == null || status.equals("")) {
            status = "";
            list = bdb.getBookingByUserId(user.getUserId());
        } else {
            list = bdb.getBookingByUserIdStatus(user.getUserId(), status);
        }
        int page = 1;
        int pageSize = 4;
        int totalPage = (list.size() + (pageSize - 1)) / pageSize;
        try {
             int p = Integer.parseInt(request.getParameter("page"));
             if (p < 1) {
                 page = 1;
             } else {
                 page = p;
             }
        } catch (Exception ex) {
            page = 1;
        }
        int start = (page - 1) * pageSize;
        int end = start + pageSize - 1;
        int count = 0;
        ArrayList<Booking> bookings = new ArrayList<>();
        for (Booking booking : list) {
            if (count >= start) {
                bookings.add(booking);
            }
            ++count;
            if (count > end) {
                break;
            }
        }
        request.setAttribute("bookings", bookings);
        request.setAttribute("status", status);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPage", totalPage);
        request.getRequestDispatcher("mybooking.jsp").forward(request, response);
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
