/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BookingDAO;
import dal.ListMotoDAO;
import dal.PaymentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import model.Booking;
import model.BookingCancel;
import model.Motorbike;
import model.MotorbikeChange;
import model.Payment;

/**
 *
 * @author Nitro
 */
public class GetBookingDetail extends HttpServlet {

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
        Booking b = bdb.getBookingById(bid);
        ArrayList<Motorbike> list = bdb.getMotorbikesById(bid);
        PaymentDAO pdb = new PaymentDAO();
        Payment p = pdb.getPaymentByBookingId(bid);
        StringBuilder s = new StringBuilder();
        s.append("<h2 style='font-family: Arial, sans-serif; color: #2c3e50; margin-bottom: 20px;'>Chi tiết đơn hàng</h2>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Mã đơn hàng: </strong> ").append(b.getCode()).append("</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Ngày tạo: </strong> ").append(b.getCreatedAt()).append("</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Khách hàng: </strong> ").append(b.getName()).append("</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Email: </strong> ").append(b.getEmail()).append("</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Số điện thoại: </strong> ").append(b.getPhone_number()).append("</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Ngày nhận xe: </strong> ").append(b.getStartDate()).append("</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Ngày trả xe: </strong> ").append(b.getEndDate()).append("</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Địa điểm nhận xe: </strong> ").append(b.getPickupLocation()).append("</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Địa điểm trả xe: </strong> ").append(b.getDropoffLocation()).append("</p>");

        s.append("<table style='width: 100%; border-collapse: collapse; margin-top: 20px;'>")
                .append("<tr style='background-color: #f2f2f2;'><th style='padding: 15px; text-align: left; border-bottom: 2px solid #ddd;'>Mẫu xe</th>")
                .append("<th style='padding: 15px; text-align: left; border-bottom: 2px solid #ddd;'>Giá thuê/ngày</th>")
                .append("<th style='padding: 15px; text-align: left; border-bottom: 2px solid #ddd;'></th></tr>");
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.'); 
        DecimalFormat df = new DecimalFormat("#,###", symbols); 
        for (Motorbike m : list) {
            BigDecimal price = BigDecimal.valueOf(m.getDailyRate());
            String priceFormat = df.format(price.setScale(0, RoundingMode.DOWN));
            s.append("<tr>")
                    .append("<td style='padding: 15px; text-align: left; border-bottom: 1px solid #ddd;'>").append(m.getModel()).append("</td>")
                    .append("<td style='padding: 15px; text-align: left; border-bottom: 1px solid #ddd;'>").append(priceFormat).append(" VNĐ</td>")
                    .append("<td style='padding: 15px; text-align: left; border-bottom: 1px solid #ddd;'><button style='background-color: #2980b9; color: white; border: none; padding: 10px 15px; cursor: pointer; border-radius: 5px;' "
                            + "onclick=\"window.location.href = 'motordetail?id=").append(m.getMotorbikeId()).append("'\">")
                    .append("Chi tiết</button></td>")
                    .append("</tr>");
        }
        s.append("</table>");

        s.append("<hr style='border: 1px solid #ccc; margin: 20px 0;'>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Giảm giá: -</strong> ").append(df.format(p.getDiscount_amount().setScale(0, RoundingMode.DOWN))).append(" VNĐ</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Tiền thuê: </strong> ").append(df.format(p.getRental_amount().setScale(0, RoundingMode.DOWN))).append(" VNĐ</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Tiền cọc: </strong> ").append(df.format(p.getDeposit_amount().setScale(0, RoundingMode.DOWN))).append(" VNĐ</p>");

        String deposit_status = "null";
        switch (p.getDeposit_status()) {
            case "notyet":
                deposit_status = "Chưa đặt cọc";
                break;
            case "deposited":
                deposit_status = "Đã cọc";
                break;
            case "refunded":
                deposit_status = "Đã hoàn trả";
                break;
        }

        s.append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Tình trạng cọc: </strong> ").append(deposit_status).append("</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Thành tiền: </strong> ").append(df.format(p.getTotal_amount().setScale(0, RoundingMode.DOWN))).append(" VNĐ</p>");

        String method = (p.getMethodId() == 2) ? "Thanh toán qua VNPay" : "Thanh toán khi nhận xe";
        s.append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Phương thức thanh toán: </strong> ").append(method).append("</p>");

        String payment_status = p.getPayment_status().equals("notyet") ? "Chưa thanh toán" : "Đã thanh toán";
        s.append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Trạng thái thanh toán: </strong> ").append(payment_status).append("</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Mã giao dịch: </strong> ").append(p.getTransactionId()).append("</p>")
                .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Ngày thanh toán: </strong> ").append(p.getDate()).append("</p>");

        String status = "";
        switch (b.getStatus()) {
            case "cancel":
                status = "Đã hủy";
                break;
            case "booked":
                status = "Đã đặt";
                break;
            case "renting":
                status = "Đang thuê";
                break;
            case "completed":
                status = "Đã hoàn tất";
                break;
        }

        s.append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Trạng thái đơn hàng: </strong> ").append(status).append("</p>");

        if (b.getStatus().equals("cancel")) {
            BookingCancel bc = bdb.getBookingCancel(bid);
            String canceler = bc.getRole().equals("Customer") ? "Người thuê hủy" : "Hệ thống hủy";
            s.append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Người hủy: </strong> ").append(canceler).append("</p>")
                    .append("<p style='font-family: Arial, sans-serif; font-size: 16px; margin: 10px 0;'><strong style='color: #34495e;'>Lí do hủy: </strong> ").append(bc.getReason()).append("</p>");
        }

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
        BookingDAO bdb = new BookingDAO();
        ListMotoDAO mdb = new ListMotoDAO();
        Booking b = bdb.getBookingById(bid);
        ArrayList<MotorbikeChange> changes = mdb.getMotorbikeChange(bid);
        if (changes.isEmpty()) {
            response.getWriter().print("<h2 style='color: red; font-family: Arial, sans-serif; text-align: center;'>Chưa có báo cáo thay đổi nào</h2>");
            return;
        }
        StringBuilder s = new StringBuilder();
        s.append("<div style='font-family: Arial, sans-serif; margin: 20px; line-height: 1.6;'>")
                .append("<h2 style='color: #FF4500; text-align: center; margin-bottom: 10px; text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);'>Chi tiết thay đổi</h2>")
                .append("<h3 style='color: #007BFF; text-align: center;'>Mã đơn hàng: <span style='color: #333;'>").append(b.getCode()).append("</span></h3>");

        s.append("<div style='margin-bottom: 20px; border: 1px solid #ccc; border-radius: 10px; padding: 15px; background-color: #e6f7ff;'>")
                .append("<h3 style='color: #007BFF;'>Thay đổi khi nhận xe:</h3>");
        boolean check1 = false;
        for (MotorbikeChange change : changes) {
            if (change.getRole().equals("customer")) {
                Motorbike m = mdb.getMotorbikeById(change.getMotorbikeId());
                s.append("<div style='border: 2px solid #007BFF; border-radius: 5px; padding: 10px; margin-bottom: 10px; background-color: #f0f8ff;'>")
                        .append("<h4 style='color: #333;'>Xe: ").append(m.getModel()).append(" - ").append(m.getLicensePlate()).append("</h4>")
                        .append("<p><strong>Mô tả thay đổi:</strong> ").append(change.getDescription()).append("</p>")
                        .append("<p><strong>Hình ảnh cụ thể:</strong></p>")
                        .append("<div style='display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px;'>");
                for (String img : change.getImages()) {
                    s.append("<img src='").append(img).append("' alt='Hình ảnh thay đổi' style='width: 100px; height: 100px; border-radius: 5px; object-fit: cover; border: 1px solid #007BFF; transition: transform 0.3s; cursor: pointer;' onclick=\"openModal(this.src)\">");
                }
                s.append("</div></div>");
                check1 = true;
            }
        }
        if (!check1) {
            s.append("<div style='text-align: center; color: #666; font-size: 16px;'>Không có thay đổi</div>");
        }
        s.append("</div>");

        s.append("<div style='margin-bottom: 20px; border: 1px solid #ccc; border-radius: 10px; padding: 15px; background-color: #e6f7ff;'>")
                .append("<h3 style='color: #007BFF;'>Thay đổi khi trả xe:</h3>");
        boolean check2 = false;
        for (MotorbikeChange change : changes) {
            if (!change.getRole().equals("customer")) {
                Motorbike m = mdb.getMotorbikeById(change.getMotorbikeId());
                s.append("<div style='border: 2px solid #007BFF; border-radius: 5px; padding: 10px; margin-bottom: 10px; background-color: #f0f8ff;'>")
                        .append("<h4 style='color: #333;'>Xe: ").append(m.getModel()).append(" - ").append(m.getLicensePlate()).append("</h4>")
                        .append("<p><strong>Mô tả thay đổi:</strong> ").append(change.getDescription()).append("</p>")
                        .append("<p><strong>Hình ảnh cụ thể:</strong></p>")
                        .append("<div style='display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px;'>");
                for (String img : change.getImages()) {
                    s.append("<img src='").append(img).append("' alt='Hình ảnh thay đổi' style='width: 100px; height: 100px; border-radius: 5px; object-fit: cover; border: 1px solid #007BFF; transition: transform 0.3s; cursor: pointer;' onclick=\"openModal(this.src)\">");
                }
                s.append("</div></div>");
                check2 = true;
            }
        }
        if (!check2) {
            s.append("<div style='text-align: center; color: #666; font-size: 16px;'>Không có thay đổi</div>");
        }
        s.append("</div></div>");
        response.getWriter().print(s.toString());
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
