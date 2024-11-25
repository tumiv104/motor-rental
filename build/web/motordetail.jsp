<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Motorbike Details</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="js/addtocart.js"></script>
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
                padding: 1rem 2rem;
                transition: all 0.3s ease;
            }

            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
                color: var(--primary-color) !important;
                transition: transform 0.3s ease;
            }

            .navbar-brand:hover {
                transform: scale(1.05);
            }

            .nav-link {
                color: var(--primary-color) !important;
                margin: 0 15px;
                padding: 8px 16px;
                border-radius: 20px;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .nav-link:hover {
                background-color: var(--secondary-color);
                color: white !important;
                transform: translateY(-2px);
            }
            body {
                background-color: #f5f5f5;
                font-family: Arial, sans-serif;
            }
            .container {
                max-width: 900px;
                margin-top: 50px;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            }
            .header {
                text-align: center;
                margin-bottom: 30px;
            }
            .motorbike-info {
                margin-top: 20px;
            }
            .motorbike-info img {
                max-width: 100%;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }
            .info-card {
                padding: 15px;
                margin-top: 15px;
                background-color: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.1);
            }
            .info-card h5 {
                font-weight: bold;
                color: #333;
            }
            .btn-primary {
                background-color: #ffc312;
                border-color: #ffc312;
                font-weight: bold;
            }
            .btn-primary:hover {
                background-color: #e0a800;
                border-color: #e0a800;
            }
            .feedback-container {
                background-color: #f9f9f9;
                border-radius: 8px;
                padding: 20px;
                margin: 30px auto;
                box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.1);
                max-width: 900px;
            }

            .feedback-container h4 {
                font-weight: bold;
                color: #333;
                margin-bottom: 20px;
                text-align: center;
            }

            .feedback-item {
                background-color: #fff;
                border-radius: 6px;
                box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);
                padding: 12px 15px;
                margin-bottom: 10px;
            }

            .feedback-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .feedback-stars {
                color: gold;
                font-size: 1.2em;
                margin-right: 10px;
            }

            .feedback-date {
                font-size: 0.85em;
                color: #888;
            }

            .feedback-comment {
                font-style: italic;
                color: #555;
                margin-top: 5px;
            }

            .no-feedback {
                text-align: center;
                color: #888;
                font-style: italic;
            }
            .cart-container {
                margin-top: 30px;
                text-align: center;
            }

            .cart-icon {
                width: 40px;
                transition: transform 0.3s ease;
            }

            .cart-icon:hover {
                transform: scale(1.1);
            }

            .cart-badge {
                position: absolute;
                top: 10px;
                right: 20px;
                background-color: #e74c3c;
                color: white;
                border-radius: 50%;
                padding: 5px 10px;
                font-size: 12px;
                font-weight: 600;
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            }

        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light fixed-top">
            <a class="navbar-brand" href="home">
                <i class="fas fa-motorcycle mr-2"></i>
                Motorbike Rental
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="home"><i class="fas fa-home mr-1"></i> Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="listmoto"><i class="fas fa-list mr-1"></i> Danh sách xe máy</a></li>
                    <li class="nav-item"><a class="nav-link" href="ai.jsp"><i class="fas fa-gift mr-1"></i> Khuyến mãi</a></li>
                    <li class="nav-item"><a class="nav-link" href="manageuser"><i class="fas fa-phone mr-1"></i> Liên hệ</a></li>
                    <li class="nav-item"><a class="nav-link" href="profile"><i class="fas fa-user mr-1"></i> Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Review</a></li>
                        <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="login"><i class="fas fa-sign-in-alt mr-1"></i> Đăng nhập</a></li>
                        </c:if>
                    <li class="nav-cart">
                        <a href="cartDetail">
                            <img class="cart-icon" src="https://res.cloudinary.com/dgeq5yymz/image/upload/f_auto,q_auto/rj9gca4yqvjajh8uhk1a" alt="cart-icon"/>
                            <span id="cart" class="cart-badge">${sessionScope.quantity}</span>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        <div class="container">
            <div class="header">
                <h1>Chi Tiết Xe Máy</h1>
            </div>
            <c:if test="${not empty motorbike}">
                <div class="motorbike-info row">
                    <div class="col-md-6">
                        <img src="${motorbike.imageUrl}" alt="${motorbike.brand} ${motorbike.model}">
                    </div>
                    <div class="col-md-6">
                        <h2>${motorbike.brand} ${motorbike.model}</h2>
                        <p><strong>Mã xe:</strong> ${motorbike.motorbikeId}</p>
                        <p><strong>Model:</strong> ${motorbike.model}</p>
                        <p><strong>Hãng:</strong> ${motorbike.brand}</p>
                        <p><strong>Năm sản xuất:</strong> ${motorbike.year}</p>
                        <button class="btn btn-detail" onclick="addToCart(${motorbike.motorbikeId})" style="background-color:  #ff0033;">Thêm vào giỏ</button>
                        <div id="${motorbike.motorbikeId}"></div>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-md-4">
                        <div class="info-card">
                            <h5>Giá thuê</h5>
                            <p>${motorbike.dailyRate}đ/ngày</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="info-card">
                            <h5>Trạng thái</h5>
                            <p>${motorbike.status}</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="info-card">
                            <h5>Biển số</h5>
                            <p>${motorbike.licensePlate}</p>
                        </div>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-md-4">
                        <div class="info-card">
                            <h5>Số km đã đi</h5>
                            <p>${motorbike.mileage} km</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="info-card">
                            <h5>Màu sắc</h5>
                            <p>${motorbike.color}</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="info-card">
                            <h5>Dung tích động cơ</h5>
                            <p>${motorbike.engineSize}</p>
                        </div>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-md-4">
                        <div class="info-card">
                            <h5>Loại nhiên liệu</h5>
                            <p>${motorbike.fuelType}</p>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-5">
                    <a href="${pageContext.request.contextPath}/listmoto" class="btn btn-primary">Quay lại</a>
                </div>
            </c:if>
        </div>

        <div class="feedback-container">
            <h4>User Feedback</h4>
            <c:choose>
                <c:when test="${not empty feedbackList}">
                    <c:forEach var="feedback" items="${feedbackList}">
                        <div class="feedback-item">
                            <div class="feedback-header">
                                <div class="d-flex align-items-center">
                                    <span class="feedback-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                                </div>
                                <p class="feedback-date">${feedback.getFeedbackDate()}</p>
                            </div>
                            <p class="feedback-comment">${feedback.getComment()}</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="no-feedback">No feedback available.</p>
                </c:otherwise>
            </c:choose>
        </div>

    </body>
</html>
