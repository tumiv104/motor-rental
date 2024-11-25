<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.WebsiteReview" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Website Reviews</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="styles.css">
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #3498db;
                --accent-color: #e74c3c;
                --background-color: #ecf0f1;
                --sidebar-width: 280px;
            }

            body, html {
                height: 100%;
                margin: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--background-color);
            }

            /* Navbar Styles */
            .navbar {
                background-color: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                box-shadow: 0 2px 15px rgba(0,0,0,0.1);
                padding: 1rem 0;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
                color: var(--primary-color) !important;
                transition: transform 0.3s ease;
                margin-right: 2rem;
                text-decoration: none;
            }

            .navbar-nav {
                display: flex;
                align-items: center;
                list-style-type: none;
                margin: 0;
                padding: 0;
            }

            .nav-item {
                margin-right: 1.5rem;
            }

            .nav-link {
                color: var(--primary-color) !important;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                transition: all 0.3s ease;
                font-weight: 500;
                text-decoration: none;
            }

            .nav-link:hover {
                background-color: var(--secondary-color);
                color: white !important;
                transform: translateY(-2px);
            }

            .container {
                max-width: 1000px;
                width: 90%;
                padding: 2rem;
                background-color: white;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                margin: 100px auto 40px;
            }

            h1 {
                color: #1e3c72;
                text-align: center;
                font-size: 2.5rem;
                margin-bottom: 2rem;
                font-weight: 600;
            }

            h2 {
                color: #2a5298;
                font-size: 1.8rem;
                margin: 1.5rem 0;
                font-weight: 600;
            }

            /* Form styling */
            .review-form {
                background-color: #f8fafc;
                padding: 2rem;
                border-radius: 12px;
                margin-bottom: 3rem;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
                transition: transform 0.3s ease;
            }

            .review-form:hover {
                transform: translateY(-2px);
            }

            .review-form textarea {
                width: 100%;
                min-height: 120px;
                padding: 1rem;
                border: 2px solid #e1e5eb;
                border-radius: 8px;
                resize: vertical;
                font-size: 1rem;
                font-family: 'Poppins', sans-serif;
                transition: all 0.3s ease;
                box-sizing: border-box;
            }

            .review-form textarea:focus {
                outline: none;
                border-color: #2a5298;
                box-shadow: 0 0 0 3px rgba(42, 82, 152, 0.1);
            }

            .review-form input[type="submit"] {
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
                border: none;
                padding: 1rem 2rem;
                font-size: 1rem;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
                display: block;
                margin: 1.5rem auto 0;
                font-weight: 500;
            }

            .review-form input[type="submit"]:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(42, 82, 152, 0.2);
            }

            /* Reviews styling */
            .reviews-container {
                display: grid;
                gap: 1.5rem;
            }

            .review {
                padding: 1.5rem;
                background-color: white;
                border-radius: 12px;
                border: 1px solid #edf2f7;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.03);
                transition: all 0.3s ease;
            }

            .review:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            }

            .review h3 {
                margin: 0 0 0.5rem;
                color: #1e3c72;
                font-weight: 600;
            }

            .review p {
                font-size: 1rem;
                color: #4a5568;
                margin: 0.5rem 0;
            }

            .review-date {
                font-size: 0.9rem;
                color: #718096;
                display: block;
                margin-top: 0.5rem;
            }

            /* Admin button styling */
            .admin-buttons {
                display: flex;
                gap: 1rem;
                margin-top: 1rem;
            }

            .btn-hide, .btn-delete {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
                border: none;
                border-radius: 6px;
                color: white;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .btn-hide {
                background-color: #ed8936;
            }

            .btn-hide:hover {
                background-color: #dd6b20;
                transform: translateY(-1px);
            }

            .btn-delete {
                background-color: #e53e3e;
            }

            .btn-delete:hover {
                background-color: #c53030;
                transform: translateY(-1px);
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {


                .container {
                    width: 95%;
                    padding: 1.5rem;
                }

                h1 {
                    font-size: 2rem;
                }

                .review-form {
                    padding: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light fixed-top">
            <a class="navbar-brand" href="home">
                <i class="fas fa-motorcycle mr-2"></i>
                Motorbike Rental
            </a>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="home"><i class="fas fa-home mr-1"></i> Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="listmoto"><i class="fas fa-list mr-1"></i> Danh sách xe máy</a></li>
                    <li class="nav-item"><a class="nav-link" href="ai.jsp"><i class="fas fa-gift mr-1"></i> Khuyến mãi</a></li>
                    <li class="nav-item"><a class="nav-link" href="manageuser"><i class="fas fa-phone mr-1"></i> Liên hệ</a></li>
                    <li class="nav-item"><a class="nav-link" href="profile"><i class="fas fa-user mr-1"></i> Hồ sơ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Đánh giá</a></li>
                        <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="login"><i class="fas fa-sign-in-alt mr-1"></i> Đăng nhập</a></li>
                        </c:if>
                </ul>
            </div>
        </nav>
        <div class="container">
            <h1>Website Reviews</h1>

            <form action="websitereview" method="post" class="review-form">
                <h2>Submit Your Review</h2>
                <textarea id="comments" name="comments" placeholder="Share your experience with us..." required></textarea>
                <input type="submit" value="Submit Review">
            </form>

            <h2>All Reviews</h2>
            <% List<WebsiteReview> reviews = (List<WebsiteReview>) request.getAttribute("reviews"); %>
            <div class="reviews-conta iner">
                <% for (WebsiteReview review : reviews) { %>
                <div class="review">
                    <h3><%= review.getFullName() != null ? review.getFullName() : "Anonymous" %></h3>
                    <p><%= review.getComments() %></p>
                    <span class="review-date"><%= review.getReviewDate() %></span>

                    <c:if test="${sessionScope.role == 'Admin'}">
                        <div class="admin-buttons">
                            <form action="websitereview" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="hide">
                                <input type="hidden" name="reviewId" value="<%= review.getReviewId() %>">
                                <button type="submit" class="btn-hide" onclick="return confirm('Are you sure you want to hide this review?');">Hide</button>
                            </form>
                            <form action="websitereview" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="reviewId" value="<%= review.getReviewId() %>">
                                <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to delete this review?');">Delete</button>
                            </form>
                        </div>
                    </c:if>
                </div>
                <% } %>
            </div>
        </div>
    </body>
</html> 