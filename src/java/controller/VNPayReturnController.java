/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BookingDAO;
import dal.CartDAO;
import dal.EmailSender;
import dal.PaymentDAO;
import dal.PromotionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Booking;
import model.Motorbike;
import model.Users;

/**
 *
 * @author Nitro
 */
public class VNPayReturnController extends HttpServlet {

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
        String date = request.getParameter("vnp_PayDate");
        String transaction_code = request.getParameter("vnp_TxnRef");
        String status = request.getParameter("vnp_TransactionStatus");
        PaymentDAO paydb = new PaymentDAO();
        
        if (transaction_code.substring(0, 3).toLowerCase().equals("add")) {
            if (status.equals("00")) {
                int bid = Integer.parseInt(transaction_code.substring(3));
                paydb.updateAdditionStatus(bid, "paid");
                
            }
            request.getRequestDispatcher("mybookinglist").forward(request, response);
            return;
        }
        
        SimpleDateFormat formatInput = new SimpleDateFormat("yyyyMMddHHmmss");
        //SimpleDateFormat formatOutput = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Timestamp payDate = null;
        try {
            Date dateTime = formatInput.parse(date);
            payDate = new Timestamp(dateTime.getTime());
        } catch (ParseException ex) {
            Logger.getLogger(VNPayReturnController.class.getName()).log(Level.SEVERE, null, ex);
        }

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        BigDecimal total_cost = (BigDecimal) session.getAttribute("total_cost");
        int days = (Integer) session.getAttribute("days");
        Booking booking = (Booking) session.getAttribute("booking");
        Integer pid = (Integer) session.getAttribute("pid");
        BigDecimal deposit = (BigDecimal) session.getAttribute("deposit");

        booking.setStatus("booked");
        BookingDAO bdb = new BookingDAO();
        booking.setCode(bdb.generateTransactionCode());
        bdb.insert(booking);
        int bid = bdb.getNewestBookingId().getBookingId();
        PromotionDAO pdb = new PromotionDAO();
        if (pid != 0) {
            pdb.insertBookingPromotion(pid, bid);
        }
        PromotionDAO prodb = new PromotionDAO();
        double d = prodb.getDiscountById(pid);

        BigDecimal rental = calculateRental(total_cost, days, d);
        BigDecimal cost = rental.add(deposit);
        BigDecimal discount = calculateRental(total_cost, days, 0).subtract(rental);
        paydb.insertPayment(bid, cost, payDate, "vnp", "paid", transaction_code, discount, rental, deposit, "deposited");
        CartDAO cdb = new CartDAO();
        ArrayList<Integer> mids = cdb.getListMotoridByUid(user.getUserId());
        for (Integer mid : mids) {
            bdb.insertDetail(mid, bid);
        }
        HashMap<Integer, Motorbike> list = cdb.getListCartByUid(user.getUserId());
        cdb.deleteAll(user.getUserId());
        Timestamp createDate = bdb.getNewestBookingId().getCreatedAt();
        request.setAttribute("transCode", transaction_code);
        request.setAttribute("createDate", createDate);
        request.setAttribute("list", list);
        request.setAttribute("days", days);
        request.setAttribute("discount", discount);
        request.setAttribute("rental", rental);
        request.setAttribute("deposit", deposit);
        request.setAttribute("booking", booking);
        request.setAttribute("createDate", createDate);

        EmailSender e = new EmailSender();
        e.sendInvoice(user.getEmail(), booking.getCode(), createDate, list, days, discount, rental, deposit, cost);

        session.setAttribute("quantity", 0);
        session.removeAttribute("email");
        session.removeAttribute("phone");
        session.removeAttribute("total_cost");
        session.removeAttribute("days");
        session.removeAttribute("booking");
        session.removeAttribute("pid");
        if (status.equals("00")) {
            request.setAttribute("status", "Đã thanh toán");
        } else {
            request.setAttribute("status", "Thanh toán không thành công");
        }

        request.getRequestDispatcher("contract.jsp").forward(request, response);
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

    public BigDecimal calculateRental(BigDecimal cost, int days, double discount) {
        BigDecimal daysBD = BigDecimal.valueOf(days);
        BigDecimal discountBD = BigDecimal.valueOf(discount);

        BigDecimal hundred = BigDecimal.valueOf(100);
        BigDecimal discountMultiplier = hundred.subtract(discountBD); // 100 - discount

        BigDecimal rental = cost
                .multiply(daysBD) // total_cost * days
                .multiply(discountMultiplier) // * (100 - discount)
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
