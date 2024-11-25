/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BookingDAO;
import dal.EmailSender;
import dal.PaymentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.concurrent.TimeUnit;
import model.Booking;
import model.Motorbike;
import model.Payment;

/**
 *
 * @author Nitro
 */
public class ManageBookingList extends HttpServlet {

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
        String status = request.getParameter("status");
        String search = request.getParameter("txtSearch");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        BookingDAO bdb = new BookingDAO();
        PaymentDAO pdb = new PaymentDAO();
        ArrayList<Booking> bookings = bdb.getAllBookingBy(status, startDate, endDate, search);
        int page = 1;
        int pageSize = 5;
        int totalPage = (bookings.size() + 4) / pageSize;
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
        LinkedHashMap<Booking, Payment> list = new LinkedHashMap<>();
        for (Booking booking : bookings) {
            if (count >= start) {
                Payment p = pdb.getPaymentByBookingId(booking.getBookingId());
                list.put(booking, p);
            }
            ++count;
            if (count > end) {
                break;
            }
        }
        if (status == null) {
            status = "";
        }
        request.setAttribute("status", status);
        request.setAttribute("search", search);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPage", totalPage);
        request.getRequestDispatcher("managebooking.jsp").forward(request, response);
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
        String status = request.getParameter("status");
        int bid = Integer.parseInt(request.getParameter("id"));
        BookingDAO bdb = new BookingDAO();
        bdb.updateBookingStatus(bid, status);
        Booking b = bdb.getBookingById(bid);
        ArrayList<Motorbike> list = bdb.getMotorbikesById(bid);
        if ("renting".equals(status)) {
            String body = "";
            String subject = "Thông báo giao xe thành công";
            body += "<h2>Chúng tôi vui mừng thông báo rằng xe của bạn đã được bàn giao thành công.</h2>"
                    + "<p><strong>Thông tin xe:</strong></p>"
                    + "<table>"
                    + "<tr>"
                    + "<th>Mẫu xe</th>"
                    + "<th>Màu sắc</th>"
                    + "<th>Biển số xe</th>"
                    + "</tr>";
            for (Motorbike motorbike : list) {
                body += "<tr>"
                        + "<td>" + motorbike.getModel() + "</td>"
                        + "<td>" + motorbike.getColor() + "</td>"
                        + "<td>" + motorbike.getLicensePlate() + "</td>"
                        + "</tr>";
            }
            body += "</table>"
                    + "<p>Vui lòng kiểm tra tình trạng xe ngay lập tức. "
                    + "Nếu bạn phát hiện bất kỳ sự thay đổi nào so với tình trạng lúc đặt xe, "
                    + "xin vui lòng đi đến phần <strong>Lịch sử Thuê Xe</strong> trên trang web của chúng tôi "
                    + "và điền vào form kiểm tra tình trạng xe.</p>"
                    + "<p>Trân trọng,<br>[Đội Ngũ Hỗ Trợ Khách Hàng]</p>"
                    + "<p>Cảm ơn bạn đã chọn dịch vụ của chúng tôi!</p>";
            EmailSender e = new EmailSender();
            e.sendEmailAlert(b.getEmail(), subject, body);
        }
        if (status.equals("completed")) {
            long millisecondsDiff = b.getReturnTime().getTime() - b.getEndDate().getTime();
            long hoursDiff = TimeUnit.MILLISECONDS.toHours(millisecondsDiff);
            String addBody = "";
            if (hoursDiff > 0) {
                BigDecimal addFee = new BigDecimal(0);
                for (Motorbike motorbike : list) {
                    if (hoursDiff < 6) {
                        addFee = addFee.add(BigDecimal.valueOf(20000).multiply(BigDecimal.valueOf(hoursDiff)));
                    } else {
                        addFee = addFee.add(BigDecimal.valueOf(motorbike.getDailyRate()));
                    }
                }
                DecimalFormatSymbols symbols = new DecimalFormatSymbols();
                symbols.setGroupingSeparator('.');
                DecimalFormat df = new DecimalFormat("#,###", symbols);
                addBody += "<p><strong>Thông báo chi phí phát sinh:</strong></p>"
                        + "<p>Theo quy định của dịch vụ, do Quý khách trả xe muộn hơn thời gian quy định, chúng tôi xin thông báo về khoản phí phát sinh:</p>"
                        + "<p>Số tiền phát sinh: " + df.format(addFee) + " VND</p>"
                        + "<br>"
                        + "<p>Quý khách vui lòng hoàn tất khoản phí này trong thời hạn sớm nhất</p>"
                        + "<br>";
                PaymentDAO pdb = new PaymentDAO();
                pdb.insertAdditionFee(addFee, "Trả xe quá thời hạn", "notyet", bid);
            }
            String subject = "Xác nhận hoàn tất quy trình thuê xe";
            String body = "<p>Kính gửi " + b.getName() + ",</p>"
                    + "<br>"
                    + "<p>Cảm ơn Quý khách đã tin tưởng và sử dụng dịch vụ thuê xe của chúng tôi. "
                    + "Chúng tôi rất hân hạnh được phục vụ Quý khách và hy vọng rằng Quý khách đã có một trải nghiệm hài lòng.</p>"
                    + "<br>";
            body += addBody;
            body += "<p>Nếu cần hỗ trợ hoặc có bất kỳ thắc mắc nào, vui lòng liên hệ với chúng tôi:</p>"
                    + "<p>- Số điện thoại: 09417.76861</p>"
                    + "<p>- Email: motorbikerentalserviceportal@gmail.com</p>"
                    + "<p>- Website: Motorbike Rental Service Portal</p>"
                    + "<br>"
                    + "<p>Chúng tôi mong sớm được gặp lại Quý khách trong những lần thuê xe tiếp theo.</p>";
            EmailSender e = new EmailSender();
            e.sendEmailAlert(b.getEmail(), subject, body);
        }
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
