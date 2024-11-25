/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CartDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import model.Motorbike;
import model.Users;

/**
 *
 * @author Nitro
 */
public class CartDetailController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            request.getRequestDispatcher("login").forward(request, response);
            return;
        }
        CartDAO cdb = new CartDAO();
        try {
            String cidStr = request.getParameter("cid");
        if (!cidStr.isEmpty() && cidStr != null) {
            int cid = Integer.parseInt(cidStr);
            cdb.delete(cid);
            Integer quantity = (Integer) session.getAttribute("quantity");
            session.setAttribute("quantity", quantity - 1);
        }
        } catch (Exception e) {
        }
        
        HashMap<Integer, Motorbike> carts = cdb.getListCartByUid(user.getUserId());
        BigDecimal total_cost = new BigDecimal(0);
        for (Map.Entry<Integer, Motorbike> entry : carts.entrySet()) {
            BigDecimal dailyRate = BigDecimal.valueOf(entry.getValue().getDailyRate());
            total_cost = total_cost.add(dailyRate);
        }
        session.setAttribute("total_cost", total_cost);
        request.setAttribute("carts", carts);
        //request.setAttribute("total_cost", total_cost);
        request.getRequestDispatcher("cartdetail.jsp").forward(request, response);
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
