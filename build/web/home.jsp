<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Motorbike Rental</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="js/addtocart.js"></script>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f0f4f8;
                margin: 0;
                padding-left: 0 !important; /* Ensure no default padding */
            }
            .navbar {
                background-color: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                box-shadow: 0 2px 15px rgba(0,0,0,0.1);
                padding: 1rem 2rem;
                transition: all 0.3s ease;
                width: 100%;
                z-index: 1030;
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
                color: #5bc0de !important;
                transform: translateY(-2px);
            }
            .sidebar {
                min-width: 100px;
                background-color: #f8f9fa;
                color: #343a40;
                height: 100vh;
                position: fixed;
                top: 56px;
                left: -250px; /* Hide sidebar by default */
                padding: 15px;
                transition: transform 0.3s ease;
                z-index: 1020;
                box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            }
            .sidebar:hover {
                transform: translateX(250px);
            }
            .sidebar h2 {
                color: #5bc0de; /* Màu tiêu đề sidebar bằng với màu navbar */
                margin-bottom: 20px;
            }
            .sidebar .nav-link {
                color: #6c757d; /* Màu chữ xám đậm cho các liên kết */
            }
            .sidebar .nav-link:hover {
                color: #5bc0de; /* Màu xanh nhạt khi hover */
            }

            .content {
                margin-left: 0 !important; /* Remove default margin */
                padding: 20px;
                width: 100%;
                transition: margin-left 0.3s;
            }

            .banner {
                background-image: url('https://reviewvilla.vn/wp-content/uploads/2022/04/Thue-xe-may-nha-trang-14-scaled.jpg');
                background-size: cover;
                background-position: center center;
                height: 400px;
                color: white;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                text-align: center;
                border-radius: 8px;
                margin-top: 80px; /* Adjust based on your navbar height */
                margin-bottom: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
                position: relative;
                overflow: hidden;
            }

            .banner {
                /* existing styles... */
                z-index: 1; /* Ensure the banner has a lower z-index than the navbar */
            }

            /* Example for the navbar */
            .navbar {
                position: fixed; /* Assuming the navbar is fixed */
                top: 0;
                left: 0;
                right: 0;
                z-index: 10; /* Higher z-index to stay above the banner */
            }

            /* Optional: Adding an overlay for better text contrast */
            .banner::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black overlay */
                z-index: 1; /* Places overlay below text */
            }

            .banner h1, .banner h2, .banner p {
                position: relative; /* Ensures text appears above overlay */
                z-index: 2; /* Places text above overlay */
            }


            .footer {
                background-color: #343a40;
                color: white;
                padding: 20px;
                text-align: center;
                position: relative;
                bottom: 0;
                width: 100%;
            }
            .alert {
                border-radius: 8px;
            }
            .form-section {
                background-color: white;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                margin-top: 20px;
            }
            h3 {
                margin-bottom: 20px;
                color: #343a40;
            }
            .btn-danger {
                background-color: #dc3545;
                border: none;
            }
            .btn-danger:hover {
                background-color: #c82333;
            }
            .footer {
                background-color: #343a40;
                color: #ffffff;
                padding: 40px 0;
            }
            .footer h5 {
                color: #5bc0de;
                font-size: 1.2rem;
                margin-bottom: 15px;
            }
            .footer p, .footer a {
                color: #cccccc;
                font-size: 0.9rem;
            }
            .footer a:hover {
                color: #f0ad4e;
                text-decoration: none;
            }
            .social-links img {
                margin: 0 5px;
                transition: transform 0.2s;
            }
            .social-links img:hover {
                transform: scale(1.1);
            }

            .hot-motorbikes-section {
                padding: 20px;
                margin-top: 20px;
            }

            .card {
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
                position: relative;
                overflow: visible;
            }

            .card:hover {
                transform: translateY(-5px);
            }

            .card-body {
                padding: 1.25rem;
            }

            .card-title {
                color: #333;
                font-weight: bold;
            }

            .btn-primary {
                width: 100%;
                margin-top: 10px;
            }

            .hot-label {
                position: absolute;
                top: 10px;
                right: 10px;
                background-color: #ff0000;
                color: white;
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: bold;
                animation: pulse 1.5s infinite;
                z-index: 1;
                text-transform: uppercase;
                box-shadow: 0 0 5px rgba(255,0,0,0.5);
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

            @keyframes pulse {
                0% {
                    transform: scale(1);
                    opacity: 0.7;
                }
                50% {
                    transform: scale(1.1);
                    opacity: 1;
                }
                100% {
                    transform: scale(1);
                    opacity: 0.7;
                }
            }
            .bike-image-container {
                position: relative;
                overflow: hidden;
                border-radius: 12px 12px 0 0;
            }

            .bike-image {
                width: 100%;
                height: 220px;
                object-fit: cover;
                transition: transform 0.3s ease;
            }
            @keyframes rainbow-blink {
                0% {
                    color: #ff0000; /* Đỏ */
                    opacity: 1;
                }
                14% {
                    color: #ff7f00; /* Cam */
                    opacity: 1;
                }
                28% {
                    color: #ffff00; /* Vàng */
                    opacity: 1;
                }
                42% {
                    color: #00ff00; /* Lục */
                    opacity: 1;
                }
                57% {
                    color: #0000ff; /* Lam */
                    opacity: 1;
                }
                71% {
                    color: #4b0082; /* Chàm */
                    opacity: 1;
                }
                85% {
                    color: #8b00ff; /* Tím */
                    opacity: 1;
                }
                100% {
                    color: #ff0000; /* Đỏ */
                    opacity: 1;
                }
            }

            .rainbow-blinking-text {
                animation: rainbow-blink 2s infinite;
                font-weight: bold;
                text-shadow: 2px 2px 5px rgba(255, 0, 0, 0.7), 0 0 25px rgba(255, 0, 0, 0.7);
            }
        </style>
    </head>
    <body>

        <!-- Navbar Header -->
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
                    <li class="nav-item"><a class="nav-link" href="profile"><i class="fas fa-user mr-1"></i> Hồ sơ</a></li>
                    <li class="nav-item"><a class="nav-link" href="createmotorbyuser"><i class="fas fa-user mr-1"></i> Cho thuê xe</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Đánh giá</a></li>
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

        <!-- Sidebar -->
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
            <div class="sidebar">
                <h2>Quản Lý Trang</h2>
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="approvalmotorbike"><i class="fas fa-tachometer-alt"></i> Quản lý cho thuê xe máy</a></li>
                    <li class="nav-item"><a class="nav-link" href="managebookinglist"><i class="fas fa-list-alt"></i> Quản lý đơn hàng</a></li>
                    <li class="nav-item"><a class="nav-link" href="manageuser"><i class="fas fa-users-cog"></i> Quản lý người dùng</a></li>
                    <li class="nav-item"><a class="nav-link" href="viewmotorbike"><i class="fas fa-motorcycle"></i> Quản lý xe máy</a></li>
                    <li class="nav-item"><a class="nav-link" href="updatepending"><i class="fas fa-motorcycle"></i> Quản lý nâng cấp tài khoản</a></li>
                    <li class="nav-item"><a class="nav-link" href="promotion"><i class="fas fa-chart-bar"></i> Quản lí mã giảm giá</a></li>
                    <li class="nav-item"><a class="nav-link" href="statistic"><i class="fas fa-chart-bar"></i> Thống kê</a></li>
                </ul>
            </div>
        </c:if>

        <!-- Content -->
        <div class="content">
            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
            <div class="alert alert-danger">
                <%= error %>
            </div>
            <% } %>

            <div class="banner">
                <h1>CHO THUÊ XE MÁY</h1>
                <h2>HÀ NỘI</h2>
                <p>HOTLINE: 09417.76861</p>
            </div>


            <c:choose>
                <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                    <div class="alert alert-info text-center">Chào mừng Admin! Bạn có quyền quản lý toàn bộ hệ thống.</div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info text-center">Chào mừng đến với dịch vụ cho thuê xe máy của chúng tôi!</div>
                </c:otherwise>
            </c:choose>


        </div>
        <div class="hot-motorbikes-section">
            <h2 style="color: #ff0000" class="text-center mb-4 rainbow-blinking-text">Danh sách xe đang hot 🔥</h2>
            <div class="row">
                <c:forEach items="${hotMotorbikes}" var="motorbike">
                    <div class="col-md-4 mb-4">
                        <div class="card"><div class="hot-label">Hot 🔥</div>
                            <div class="card-body">
                                <div class="bike-image-container">
                                    <img src="${motorbike.imageUrl}" alt="alt" class="bike-image"/>
                                </div>
                                <h5 class="card-title">${motorbike.brand} ${motorbike.model}</h5>
                                <p class="card-text">
                                    Màu sắc: ${motorbike.color}<br>
                                    Giá thuê: ${motorbike.dailyRate}đ/ngày<br>
                                    Số lượt thuê: ${motorbike.bookingCount}
                                </p>
                                <a href="motordetail?id=${motorbike.motorbikeId}" style="background-color:  #ff0033;"  class="btn btn-primary">Xem chi tiết</a>
                                <button class="btn btn-primary" onclick="addToCart(${motorbike.motorbikeId})" style="background-color:  #ff0033;">Thêm vào giỏ</button>
                                <div id="${motorbike.motorbikeId}"></div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <footer class="footer">
            <div class="container">
                <div class="row text-center">
                    <div class="col-md-4 mb-3">
                        <h5>Liên hệ</h5>
                        <p>Hotline: <strong>09417.76861</strong></p>
                        <p>Email: <strong>motorbikerentalserviceportal@gmail.com</strong></p>
                        <div class="social-links mt-2">
                            <a href="https://www.facebook.com/p/motorbike-rental-service-portal-61567909220065/" target="_blank">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/2023_Facebook_icon.svg/667px-2023_Facebook_icon.svg.png" width="30" height="30" alt="Facebook">
                            </a>
                            <a href="https://twitter.com/" target="_blank">
                                <img src="https://e7.pngegg.com/pngimages/708/311/png-clipart-icon-logo-twitter-logo-twitter-logo-blue-social-media-thumbnail.png" width="30" height="30" alt="Twitter">
                            </a>
                            <a href="https://instagram.com/" target="_blank">
                                <img src="https://intruongthinh.vn/wp-content/uploads/2022/11/hinh-3.png" width="30" height="30" alt="Instagram">
                            </a>
                            <a href="https://youtube.com/" target="_blank">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/e/ef/Youtube_logo.png" width="30" height="30" alt="YouTube">
                            </a>
                            <a href="https://linkedin.com/" target="_blank">
                                <img src="https://png.pngtree.com/element_our/sm/20180630/sm_5b37de3263964.jpg" width="30" height="30" alt="LinkedIn">
                            </a>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <h5>Chính sách</h5>
                        <a href="policies.jsp" class="footer-link text-light">Chính sách & điều khoản</a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <h5>Về Motorbike Rental System</h5>
                        <a href="faq.jsp" class="footer-link text-light">Câu hỏi thường gặp</a>
                
                    </div>
                </div>
                <hr class="my-4" style="border-color: rgba(255, 255, 255, 0.1);">
                <p class="text-center mb-0">&copy; 2024 Motorbike Rental. All rights reserved.</p>
            </div>
        </footer>


        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
                                    function toggleChat() {
                                        var chatWindow = document.getElementById("chatWindow");
                                        chatWindow.style.display = chatWindow.style.display === "none" ? "block" : "none";
                                    }
                                    function sendMessage() {
                                        var messageInput = document.getElementById("userMessage");
                                        var chatMessages = document.getElementById("chatMessages");
                                        if (messageInput.value) {
                                            var newMessage = document.createElement("div");
                                            newMessage.textContent = "Bạn: " + messageInput.value;
                                            chatMessages.appendChild(newMessage);
                                            messageInput.value = "";
                                            chatMessages.scrollTop = chatMessages.scrollHeight;
                                        }
                                    }
        </script>
    </body>
</html>
