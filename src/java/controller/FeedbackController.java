/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FeedbackDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feedback;
import java.sql.Date;
import java.io.PrintWriter;

/**
 *
 * @author ADMIN
 */
public class FeedbackController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Lấy thông tin từ yêu cầu AJAX
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");
            Date feedbackDate = new Date(System.currentTimeMillis());

            // Tạo đối tượng Feedback và thêm vào DB
            Feedback feedback = new Feedback();
            feedback.setBookingId(bookingId);
            feedback.setRating(rating);
            feedback.setComment(comment);
            feedback.setFeedbackDate(feedbackDate);

            FeedbackDAO feedbackDAO = new FeedbackDAO();
            boolean success = feedbackDAO.addNewFeedback(bookingId, rating, comment, feedbackDate);

            // Gửi phản hồi dưới dạng văn bản
            if (success) {
                out.print("Feedback submitted successfully");
            } else {
                out.print("An error occurred while submitting feedback.");
            }
        } catch (Exception e) {
            response.getWriter().print("An error occurred: " + e.getMessage());
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
