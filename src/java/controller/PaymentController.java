/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BookingDAO;
import dal.CartDAO;
import dal.EmailSender;
import dal.PromotionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import model.Booking;
import model.Motorbike;
import dal.PaymentDAO;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import model.PaymentMethod;
import model.Promotion;
import model.Users;

/**
 *
 * @author Nitro
 */
public class PaymentController extends HttpServlet {

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
            out.println("<title>Servlet PaymentController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        BigDecimal total_cost = (BigDecimal) session.getAttribute("total_cost");
        int days = (Integer) session.getAttribute("days");
        BigDecimal actual_amount = calculateRental(total_cost, days, 0);
        PromotionDAO pdb = new PromotionDAO();
        PaymentDAO paydb = new PaymentDAO();
        CartDAO cdb = new CartDAO();
        ArrayList<Promotion> promotions = pdb.getAllAvailablePromotion(actual_amount);
        ArrayList<PaymentMethod> methods = paydb.getAllMethod();
        BigDecimal deposit = cdb.getDeposit(user.getUserId());
        request.setAttribute("methods", methods);
        request.setAttribute("promotions", promotions);
        session.setAttribute("deposit", deposit);
        request.getRequestDispatcher("payment.jsp").forward(request, response);
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
        String method = request.getParameter("payment_method");
        String proid = request.getParameter("proid");
        int pid = 0;
        PromotionDAO prodb = new PromotionDAO();
        if (proid != null && !proid.equals("")) {
            pid = Integer.parseInt(proid);
            prodb.updateCurrentUse(pid);
        }
        double d = prodb.getDiscountById(pid);
        
        HttpSession session = request.getSession();
        BigDecimal total_cost = (BigDecimal) session.getAttribute("total_cost");
        int days = (Integer) session.getAttribute("days");
        Users user = (Users) session.getAttribute("user");
        Booking booking = (Booking) session.getAttribute("booking");
        BigDecimal deposit = (BigDecimal) session.getAttribute("deposit");
        
        BigDecimal rental = calculateRental(total_cost, days, d);
        
        booking.setTotalCost(rental);
        booking.setUserId(user.getUserId());
        BookingDAO bdb = new BookingDAO();
        booking.setCode(bdb.generateTransactionCode());

        PaymentDAO pdb = new PaymentDAO();
        String vnp_TxnRef = pdb.generateTransactionCode(method);
        BigDecimal cost = rental.add(deposit);
        BigDecimal discount = calculateRental(total_cost, days, 0).subtract(rental);
        if ("def".equals(method)) {
            booking.setStatus("booked");
            bdb.insert(booking);
            int bid = bdb.getNewestBookingId().getBookingId();
            
            if (pid != 0) {
                prodb.insertBookingPromotion(pid, bid);
            }
            
            pdb.insertPayment(bid, cost, null, method, "notyet", vnp_TxnRef, discount, rental, deposit, "notyet");
            CartDAO cdb = new CartDAO();
            ArrayList<Integer> mids = cdb.getListMotoridByUid(user.getUserId());
            for (Integer mid : mids) {
                bdb.insertDetail(mid, bid);
            }
            HashMap<Integer, Motorbike> list = cdb.getListCartByUid(user.getUserId());
            cdb.deleteAll(user.getUserId());
            Timestamp createDate = bdb.getNewestBookingId().getCreatedAt();
            request.setAttribute("list", list);
            request.setAttribute("days", days);
            request.setAttribute("discount", discount);
            request.setAttribute("rental", rental);
            request.setAttribute("deposit", deposit);
            request.setAttribute("booking", booking);
            request.setAttribute("createDate", createDate);
            request.setAttribute("status", "Thanh toán khi nhận xe");
            
            EmailSender e = new EmailSender();
            e.sendInvoice(user.getEmail(), booking.getCode(), createDate, list, days, discount, rental, deposit, cost);
            
            session.setAttribute("quantity", 0);
            session.removeAttribute("total_cost");
            session.removeAttribute("days");
            session.removeAttribute("booking");
            request.getRequestDispatcher("contract.jsp").forward(request, response);
        } else {
            session.setAttribute("pid", pid);
            request.getRequestDispatcher("vnpay?amount=" + cost + "&vnp_TxnRef=" + vnp_TxnRef).forward(request, response);
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
