package dal;

import model.WebsiteReview;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

public class WebsiteReviewDAO extends DBContext {

    // Phương thức lấy tất cả đánh giá
    public List<WebsiteReview> getAllReviews() {
        List<WebsiteReview> reviews = new ArrayList<>();
        String sql = "SELECT * FROM WebsiteReview";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int reviewId = rs.getInt("review_id"); // Thay đổi tên cột nếu cần
                int userId = rs.getInt("user_id");
                String fullName = rs.getString("full_name");
                String comments = rs.getString("comments");
                Date reviewDate = rs.getDate("review_date");

                reviews.add(new WebsiteReview(reviewId, userId, fullName, comments, reviewDate));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Phương thức thêm đánh giá
    public void addReview(WebsiteReview review) {
        String sql = "INSERT INTO WebsiteReview (user_id, full_name, comments, review_date) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, review.getUserId());
            ps.setString(2, review.getFullName()); // Đảm bảo rằng full_name được lưu
            ps.setString(3, review.getComments());
            ps.setDate(4, review.getReviewDate());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void hideReview(int reviewId) {
        String sql = "UPDATE WebsiteReview SET hidden = 1 WHERE review_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteReview(int reviewId) {
        String sql = "DELETE FROM WebsiteReview WHERE review_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}