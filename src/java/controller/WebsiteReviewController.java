package controller;

import dal.WebsiteReviewDAO;
import model.WebsiteReview;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date; // Import Date for review date
import java.util.List;

public class WebsiteReviewController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        displayReviews(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        // Kiểm tra xem user_id có phải là Integer hay không
        Object userIdObj = session.getAttribute("user_id");
        Integer userId = null;

        if ("hide".equals(action) || "delete".equals(action)) {
            if (!"Admin".equals(role)) {
                request.setAttribute("error", "You do not have permission to perform this action.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            int reviewId = Integer.parseInt(request.getParameter("reviewId"));
            WebsiteReviewDAO websiteReviewDAO = new WebsiteReviewDAO();

            if ("hide".equals(action)) {
                websiteReviewDAO.hideReview(reviewId);
            } else if ("delete".equals(action)) {
                websiteReviewDAO.deleteReview(reviewId);
            }

            displayReviews(request, response);
            return;
        }
        // Kiểm tra nếu userIdObj không phải null
        if (userIdObj instanceof Integer) {
            userId = (Integer) userIdObj; // Nếu đúng là Integer, ép kiểu
        } else if (userIdObj instanceof String) {
            // Nếu userIdObj là String, chuyển đổi thành Integer
            try {
                userId = Integer.parseInt((String) userIdObj); // Chuyển đổi String thành Integer
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid user ID format.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
        }

        // Kiểm tra xem userId có tồn tại không
        if (userId == null) {
            request.setAttribute("error", "You must be logged in to submit a review.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        String fullName = (String) session.getAttribute("fullName"); // Lấy fullName từ session
        String comments = request.getParameter("comments");

        // Tạo đối tượng WebsiteReview và lưu vào database
        WebsiteReviewDAO websiteReviewDAO = new WebsiteReviewDAO();

        // Lấy ngày hiện tại để lưu vào review
        Date reviewDate = new Date(System.currentTimeMillis());
        WebsiteReview review = new WebsiteReview(0, 0, role, comments, reviewDate) ;// Sử dụng id = 0 cho reviewId mới

        websiteReviewDAO.addReview(review);

        // Hiển thị danh sách feedback sau khi thêm thành công
        displayReviews(request, response);
    }

    private void displayReviews(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách feedback từ database
        WebsiteReviewDAO websiteReviewDAO = new WebsiteReviewDAO();
        List<WebsiteReview> reviews = websiteReviewDAO.getAllReviews(); // Gọi phương thức mới
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("review.jsp").forward(request, response); // Đổi "review.jsp" thành trang JSP bạn muốn hiển thị
    }

    @Override
    public String getServletInfo() {
        return "Servlet for handling website reviews";
    }
}