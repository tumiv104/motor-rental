<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Profile</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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

            /* Sidebar Styles */
            .sidebar {
                height: calc(100vh - 72px);
                width: var(--sidebar-width);
                position: fixed;
                top: 72px;
                left: 0;
                background: linear-gradient(135deg, var(--primary-color), #34495e);
                padding-top: 30px;
                color: white;
                box-shadow: 4px 0 15px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                z-index: 1000;
            }

            .sidebar-item {
                padding: 15px 30px;
                display: flex;
                align-items: center;
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                transition: all 0.3s ease;
                border-left: 4px solid transparent;
                margin: 8px 0;
            }

            .sidebar-item:hover {
                background-color: rgba(255, 255, 255, 0.1);
                color: white;
                border-left-color: var(--secondary-color);
                transform: translateX(10px);
                text-decoration: none;
            }

            .sidebar-item i {
                margin-right: 15px;
                width: 20px;
                font-size: 1.2em;
            }

            /* Main Content Styles */
            .main-content {
                margin-left: var(--sidebar-width);
                padding: 30px;
                margin-top: 72px;
                min-height: calc(100vh - 72px);
                transition: all 0.3s ease;
            }

            .profile-content {
                background-color: white;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.05);
                padding: 40px;
                width: 100%;
                max-width: 1000px;
                margin: 0 auto;
                transition: transform 0.3s ease;
            }

            .profile-content:hover {
                transform: translateY(-5px);
            }

            .profile-picture {
                width: 250px;
                height: 250px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 30px;
                border: 5px solid white;
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
                transition: transform 0.3s ease;
            }

            .profile-picture:hover {
                transform: scale(1.05);
            }

            .profile-info {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .info-section {
                width: 100%;
                margin-bottom: 30px;
                padding: 20px;
                border-radius: 10px;
                background-color: #f8f9fa;
                transition: all 0.3s ease;
            }

            .info-section:hover {
                background-color: #fff;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .info-section p {
                font-size: 1.1rem;
                margin-bottom: 15px;
                padding: 10px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .info-section p:hover {
                background-color: #f8f9fa;
                transform: translateX(10px);
            }

            .info-section strong {
                color: var(--primary-color);
                font-weight: 600;
            }

            /* Alert Styles */
            .alert {
                border-radius: 10px;
                padding: 1rem;
                margin-bottom: 20px;
                border: none;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                animation: slideIn 0.5s ease;
            }

            @keyframes slideIn {
                from {
                    transform: translateY(-20px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            /* Footer Styles */
            .footer {
                background: linear-gradient(135deg, var(--primary-color), #34495e);
                color: white;
                padding: 40px 0;
                margin-left: var(--sidebar-width);
            }

            .social-links {
                display: flex;
                justify-content: center;
                gap: 15px;
            }

            .social-links a {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: rgba(255, 255, 255, 0.1);
                transition: all 0.3s ease;
            }

            .social-links a:hover {
                transform: translateY(-5px);
                background-color: var(--secondary-color);
            }

            .social-links img {
                width: 20px;
                height: 20px;
            }

            .footer-link {
                display: block;
                margin: 10px 0;
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                transition: all 0.3s ease;
                padding: 5px 0;
            }

            .footer-link:hover {
                color: white;
                transform: translateX(10px);
                text-decoration: none;
            }

            /* Section Headers */
            h3, h5 {
                color: var(--primary-color);
                font-weight: 600;
                margin-bottom: 25px;
                position: relative;
                padding-bottom: 10px;
            }

            h3::after, h5::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 50px;
                height: 3px;
                background: var(--secondary-color);
                border-radius: 2px;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .sidebar {
                    width: 0;
                    padding: 0;
                }

                .main-content, .footer {
                    margin-left: 0;
                }

                .profile-content {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
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
                    <li class="nav-item"><a class="nav-link" href="approvalmotorbike"><i class="fas fa-user mr-1"></i> Cho thuê xe máy</a></li>
                    <li class="nav-item"><a class="nav-link" href="profile"><i class="fas fa-user mr-1"></i> Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Review</a></li>
                        <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="login"><i class="fas fa-sign-in-alt mr-1"></i> Đăng nhập</a></li>
                        </c:if>
                </ul>
            </div>
        </nav>

        <!-- Sidebar -->
        <div class="sidebar">
            <a href="${pageContext.request.contextPath}/editprofile" class="sidebar-item">
                <i class="fas fa-user-edit"></i>
                Chỉnh sửa thông tin
            </a>
            <a href="${pageContext.request.contextPath}/changepassword" class="sidebar-item">
                <i class="fas fa-key"></i>
                Đổi mật khẩu
            </a>
            <a href="${pageContext.request.contextPath}/mybookinglist" class="sidebar-item">
                <i class="fas fa-history"></i>
                Lịch sử thuê xe
            </a>
            <a href="${pageContext.request.contextPath}/approvalmotorbike" class="sidebar-item">
                <i class="fas fa-history"></i>
                Lịch sử cho thuê xe
            </a>
            <a href="${pageContext.request.contextPath}/updatepending" class="sidebar-item">
                <i class="fas fa-history"></i>
                Xem yêu cầu vai trò
            </a>
            <a href="logout" class="sidebar-item">
                <i class="fas fa-sign-out-alt"></i>
                Đăng xuất
            </a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="profile-content">
                <h3><i class="fas fa-user-circle mr-2"></i>Thông tin cá nhân</h3>

                <!-- Success/Error Messages -->
                <c:if test="${not empty requestScope.successMessage}">
                    <div class="alert alert-success" id="success-message">
                        <i class="fas fa-check-circle mr-2"></i>
                        <c:out value="${requestScope.successMessage}" />
                    </div>
                </c:if>

                <c:if test="${not empty requestScope.errorMessage}">
                    <div class="alert alert-danger" id="error-message">
                        <i class="fas fa-exclamation-circle mr-2"></i>
                        <c:out value="${requestScope.errorMessage}" />
                    </div>
                </c:if>

                <!-- Profile Info -->
                <div class="profile-info">
                    <!-- Avatar Section -->
                    <div class="avatar-section text-center mb-4">
                        <c:if test="${sessionScope.user.profilePicture != null}">
                            <img src="uploads/${sessionScope.user.profilePicture}" alt="Profile Picture" class="profile-picture">
                        </c:if>
                        <c:if test="${sessionScope.user.profilePicture == null}">
                            <img src="${pageContext.request.contextPath}/images/default-profile-picture/2.jpg" alt="Default Profile Picture" class="profile-picture">
                        </c:if>
                    </div>

                    <!-- Info Section -->
                    <div class="info-section">
                        <p><strong><i class="fas fa-user mr-2"></i>Tên người dùng:</strong> <c:out value="${sessionScope.user.username}" /></p>
                        <p><strong><i class="fas fa-envelope mr-2"></i>Email:</strong> <c:out value="${sessionScope.user.email}" /></p>
                        <p><strong><i class="fas fa-phone mr-2"></i>Số điện thoại:</strong> <c:out value="${sessionScope.user.phoneNumber}" /></p>
                        <p><strong><i class="fas fa-map-marker-alt mr-2"></i>Địa chỉ:</strong> <c:out value="${sessionScope.user.address}" /></p>
                        <p><strong><i class="fas fa-birthday-cake mr-2"></i>Ngày sinh:</strong> <c:out value="${sessionScope.user.dateOfBirth}" /></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
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
                        <a href="policies.jsp" class="footer-link">Chính sách & điều khoản</a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <h5>Về Motorbike Rental System</h5>
                        <a href="faq.jsp" class="footer-link">Câu hỏi thường gặp</a>
                        <a href="motorbikes" class="footer-link">Danh sách xe máy</a>
                    </div>
                </div>
                <hr class="my-4" style="border-color: rgba(255, 255, 255, 0.1);">
                <p class="text-center mb-0">&copy; 2024 Motorbike Rental. All rights reserved.</p>
            </div>
        </footer>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            setTimeout(function () {
                var successMessage = document.getElementById('success-message');
                var errorMessage = document.getElementById('error-message');
                if (successMessage) {
                    successMessage.style.display = 'none';
                }
                if (errorMessage) {
                    errorMessage.style.display = 'none';
                }
            }, 3000);
        </script>
    </body>
</html>