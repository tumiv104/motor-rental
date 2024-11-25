package model;

import java.sql.Date;

/**
 *
 * @author ADMIN
 */
public class WebsiteReview {

    private int reviewId;
    private int userId;
    private String fullName;
    private String comments;
    private Date reviewDate;

    public WebsiteReview() {
    }

    // Constructor đầy đủ với tất cả các tham số
    public WebsiteReview(int reviewId, int userId, String fullName, String comments, Date reviewDate) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.fullName = fullName;
        this.comments = comments;
        this.reviewDate = reviewDate;
    }

    // Constructor mới cho trường hợp chỉ cần userId, fullName và comments
    public WebsiteReview(int userId, String fullName, String comments) {
        this.userId = userId;
        this.fullName = fullName;
        this.comments = comments;
        this.reviewDate = new Date(System.currentTimeMillis()); // Gán ngày hiện tại
    }

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }
}
