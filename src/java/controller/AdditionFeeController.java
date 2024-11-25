/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BookingDAO;
import dal.PaymentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import model.AdditionFee;
import model.Booking;
import model.Users;

/**
 *
 * @author Nitro
 */
public class AdditionFeeController extends HttpServlet {

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
        int bid = Integer.parseInt(request.getParameter("bid"));
        BookingDAO bdb = new BookingDAO();
        PaymentDAO pdb = new PaymentDAO();
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        Booking b = bdb.getBookingById(bid);
        ArrayList<AdditionFee> list = pdb.getAdditionFeeByBid(bid);
        StringBuilder s = new StringBuilder();
        s.append("<h2 style=\"text-align: center; color: #333;\">Thông tin Chi Phí Phát Sinh</h2>");
        s.append("<br>");
        s.append("<div style=\"text-align: center; font-size: 18px; font-weight: bold; color: #333; margin-bottom: 10px;\"> Mã đơn hàng: ");
        s.append(b.getCode());
        s.append("</div>");
        if (list.isEmpty()) {
            s.append("<div style=\"text-align: center; color: #666; font-size: 16px;\">Đơn hàng không có chi phí phát sinh.</div>");
        } else {
            s.append("<table style=\"width: 100%; border-collapse: collapse; margin-top: 10px;\">");
            s.append("<thead><tr>");
            s.append("<th style=\"border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2;\">Số Tiền Phát Sinh</th>");
            s.append("<th style=\"border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2;\">Lý Do Phát Sinh</th>");
            s.append("<th style=\"border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2;\">Trạng Thái Thanh Toán</th>");
            s.append("</tr></thead>");
            s.append("<tbody>");
            BigDecimal total_amount = new BigDecimal(0);
            DecimalFormatSymbols symbols = new DecimalFormatSymbols();
            symbols.setGroupingSeparator('.');
            DecimalFormat df = new DecimalFormat("#,###", symbols);
            for (AdditionFee additionFee : list) {
                s.append("<tr>");
                s.append("<td style=\"border: 1px solid #ddd; padding: 8px;\">").append(df.format(additionFee.getAmount())).append(" VND</td>");
                s.append("<td style=\"border: 1px solid #ddd; padding: 8px;\">").append(additionFee.getReason()).append("</td>");
                if (additionFee.getStatus().equals("notyet")) {
                    s.append("<td style=\"border: 1px solid #ddd; padding: 8px; color: red; font-weight: bold;\">Chưa thanh toán</td>");
                    total_amount = total_amount.add(additionFee.getAmount());
                } else if (additionFee.getStatus().equals("paid")) {
                    s.append("<td style=\"border: 1px solid #ddd; padding: 8px; color: green; font-weight: bold;\">Đã thanh toán</td>");
                }
                s.append("</tr>");
            }
            s.append("</tbody>");
            s.append("</table>");
            if (total_amount.compareTo(new BigDecimal(0)) > 0) {
                String vnp_TxnRef = "ADD" + bid;
                s.append("<div style=\"font-weight: bold; margin-top: 20px; text-align: right; color: #4a90e2;\">Tổng Tiền Cần Thanh Toán: ").append(df.format(total_amount)).append(" VND</div>");
                if (user != null && user.getRole().equals("Customer")) {
                    s.append("<form action=\"vnpay\" method=\"POST\">");
                    s.append("<input type=\"hidden\" name=\"amount\" value=\"").append(total_amount).append("\">");
                    s.append("<input type=\"hidden\" name=\"vnp_TxnRef\" value=\"").append(vnp_TxnRef).append("\">");
                    s.append("<div style=\"font-weight: bold; margin-top: 20px; text-align: right;\">"
                            + "<button type=\"submit\" style=\"background-color: #c0392b;\">Thanh Toán</button></div>");
                    s.append("</form>");
                }
            }
        }

        s.append("<br>");
        response.getWriter().print(s.toString());
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
        int bid = Integer.parseInt(request.getParameter("bid"));
        String reason = request.getParameter("reason");
        String amount = request.getParameter("amount");
        BigDecimal add_amount = new BigDecimal(amount);
        PaymentDAO pdb = new PaymentDAO();
        pdb.insertAdditionFee(add_amount, reason, "notyet", bid);
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
