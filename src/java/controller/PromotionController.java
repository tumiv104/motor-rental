/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PromotionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.ArrayList;
import model.Booking;
import model.Promotion;

/**
 *
 * @author Nitro
 */
public class PromotionController extends HttpServlet {

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
            out.println("<title>Servlet PromotionController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PromotionController at " + request.getContextPath() + "</h1>");
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
        PromotionDAO pdb = new PromotionDAO();
        String action = request.getParameter("action");
        if (action != null && !action.equals("")) {
            String name = request.getParameter("name");
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            String discountRateStr = request.getParameter("discount_rate");
            String startDate = request.getParameter("start_date");
            String endDate = request.getParameter("end_date");
            String maxUseStr = request.getParameter("max_use");
            String minAmountStr = request.getParameter("min_amount");
            double discount = Double.parseDouble(discountRateStr);
            int maxUse = Integer.parseInt(maxUseStr);
            BigDecimal minAmount = new BigDecimal(minAmountStr);
            if (action.equals("add")) {
                pdb.insertPromotion(name, code, description, discount, startDate, endDate, maxUse, minAmount);
            } else if (action.equals("update")) {
                int id = Integer.parseInt(request.getParameter("promotionId"));
                pdb.updatePromotion(id, name, code, description, discount, startDate, endDate, maxUse, minAmount);
            }
        }
        String search = request.getParameter("txtSearch");
        if (search == null) {
            search = "";
        }
        ArrayList<Promotion> pros = pdb.searchPromotion(search);
        int page = 1;
        int pageSize = 3;
        int totalPage = (pros.size() + (pageSize - 1)) / pageSize;
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
        ArrayList<Promotion> promotions = new ArrayList<>();
        for (Promotion pro : pros) {
            if (count >= start) {
                promotions.add(pro);
            }
            ++count;
            if (count > end) {
                break;
            }
        }
        request.setAttribute("search", search);
        request.setAttribute("promotions", promotions);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPage", totalPage);
        request.getRequestDispatcher("managepromotion.jsp").forward(request, response);
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
        
        int pid = Integer.parseInt(request.getParameter("pid"));
        String status = request.getParameter("status");
        PromotionDAO pdb = new PromotionDAO();
        pdb.updateStatus(pid, status);
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
