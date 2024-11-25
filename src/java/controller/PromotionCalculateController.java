/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.PromotionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;

/**
 *
 * @author Nitro
 */
public class PromotionCalculateController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int pid = Integer.parseInt(request.getParameter("promo_id"));
        int act = Integer.parseInt(request.getParameter("action"));
        HttpSession session = request.getSession();
        BigDecimal total_cost = (BigDecimal) session.getAttribute("total_cost");
        int days = (Integer) session.getAttribute("days");
        
        PromotionDAO pdb = new PromotionDAO();
        double discount = pdb.getDiscountById(pid);
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.'); 
        DecimalFormat df = new DecimalFormat("#,###", symbols); 

        
        if (act == 1) {
            BigDecimal rental = calculateRental(total_cost, days, discount);
            String formattedNumber = df.format(rental.setScale(0, RoundingMode.DOWN));
            response.getWriter().print("<strong>Tiền thuê : </strong> " + formattedNumber + " VND");
        } else if (act == 0) {
            discount = 0;
            BigDecimal rental = calculateRental(total_cost, days, discount);
            String formattedNumber = df.format(rental.setScale(0, RoundingMode.DOWN));
            response.getWriter().print("<strong>Tiền thuê : </strong> " + formattedNumber + " VND");
        }
        
    } 
    
    public BigDecimal calculateRental(BigDecimal cost, int days, double discount) {
        BigDecimal daysBD = BigDecimal.valueOf(days);
        BigDecimal discountBD = BigDecimal.valueOf(discount);

        BigDecimal hundred = BigDecimal.valueOf(100);
        BigDecimal discountMultiplier = hundred.subtract(discountBD); // 100 - discount

        BigDecimal rental = cost
                .multiply(daysBD)                        // total_cost * days
                .multiply(discountMultiplier)            // * (100 - discount)
                .divide(hundred, 2, RoundingMode.HALF_UP); // /100
        return rental;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
