<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #3498db;
                --accent-color: #e74c3c;
                --background-color: #ecf0f1;
                --sidebar-width: 280px;
            }

            body {
                background: var(--background-color);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                margin: 0;
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
                background: var(--background-color);
            }

            /* Change Password Styles */
            .password-container {
                max-width: 800px;
                margin: 20px auto;
                padding: 30px;
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }

            .password-header {
                text-align: center;
                margin-bottom: 40px;
                color: var(--primary-color);
                position: relative;
                padding-bottom: 15px;
            }

            .password-header:after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 3px;
                background: var(--secondary-color);
                border-radius: 2px;
            }

            .password-icon {
                font-size: 3rem;
                color: var(--secondary-color);
                margin-bottom: 20px;
            }

            .form-section {
                background: #f8f9fa;
                padding: 30px;
                border-radius: 15px;
                margin-bottom: 30px;
            }

            .input-group {
                margin-bottom: 25px;
                position: relative;
            }

            .input-group-prepend {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                z-index: 10;
            }

            .input-group-text {
                background: transparent;
                border: none;
                color: var(--secondary-color);
            }

            .form-control {
                height: 50px;
                padding-left: 50px;
                border-radius: 25px;
                border: 2px solid #e9ecef;
                transition: all 0.3s ease;
                font-size: 1rem;
            }

            .form-control:focus {
                border-color: var(--secondary-color);
                box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
            }

            .password-requirements {
                background: #f1f8ff;
                padding: 20px;
                border-radius: 15px;
                margin-top: 30px;
            }

            .requirement-item {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
                color: #666;
                font-size: 0.9rem;
            }

            .requirement-item i {
                margin-right: 10px;
                color: var(--secondary-color);
            }

            .btn-change-password {
                background: linear-gradient(135deg, var(--secondary-color), #2980b9);
                color: white;
                border: none;
                padding: 12px 40px;
                border-radius: 25px;
                font-size: 1.1rem;
                font-weight: 600;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                width: 100%;
                margin-top: 20px;
            }

            .btn-change-password:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
                background: linear-gradient(135deg, #2980b9, var(--secondary-color));
            }

            .message {
                padding: 15px;
                border-radius: 10px;
                margin-top: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 500;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .message.show {
                opacity: 1;
            }

            .error-message {
                background: #feeaea;
                color: var(--accent-color);
            }

            .success-message {
                background: #eafef1;
                color: #28a745;
            }

            .message i {
                margin-right: 10px;
                font-size: 1.2rem;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .sidebar {
                    width: 0;
                    padding: 0;
                }

                .main-content {
                    margin-left: 0;
                }

                .password-container {
                    margin: 10px;
                    padding: 20px;
                }

                .form-section {
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
                    <li class="nav-item"><a class="nav-link" href="profile"><i class="fas fa-user mr-1"></i> Hồ sơ</a></li>
                    <li class="nav-item"><a class="nav-link" href="createmotorbyuser"><i class="fas fa-motorcycle mr-2"></i> Cho thuê xe</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Đánh giá</a></li>
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
                <i class="fas fa-motorcycle"></i>
                Lịch sử cho thuê xe
            </a>
            <a href="${pageContext.request.contextPath}/updatepending" class="sidebar-item">
                <i class="fas fa-user-circle"></i>
                Xem yêu cầu vai trò
            </a>
            <a href="logout" class="sidebar-item">
                <i class="fas fa-sign-out-alt"></i>
                Đăng xuất
            </a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="password-container">
                <div class="password-header">
                    <div class="password-icon">
                        <i class="fas fa-lock"></i>
                    </div>
                    <h2>Đổi Mật Khẩu</h2>
                </div>

                <form action="changepassword" method="POST">
                    <div class="form-section">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-key"></i>
                                </span>
                            </div>
                            <input type="password" class="form-control" placeholder="Mật khẩu hiện tại" name="currentPassword" required>
                        </div>

                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-lock"></i>
                                </span>
                            </div>
                            <input type="password" class="form-control" placeholder="Mật khẩu mới" name="newPassword" required>
                        </div>

                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-check-circle"></i>
                                </span>
                            </div>
                            <input type="password" class="form-control" placeholder="Xác nhận mật khẩu mới" name="confirmNewPassword" required>
                        </div>

                        <div class="password-requirements">
                            <h6 class="mb-3">Yêu cầu mật khẩu:</h6>
                            <div class="requirement-item">
                                <i class="fas fa-check-circle"></i>
                                Mật khẩu mới chứa ít nhất 8 ký tự
                            </div>

                            <div class="requirement-item">
                                <i class="fas fa-check-circle"></i>
                                Không được giống mật khẩu cũ
                            </div>
                        </div>

                        <button type="submit" class="btn btn-change-password">
                            <i class="fas fa-key mr-2"></i>
                            Đổi Mật Khẩu
                        </button>
                    </div>
                </form>
                <div class="error-message" id="error-message">${errorMessage}</div>
                <div class="success-message" id="success-message">${successMessage}</div>
            </div>
        </div>


        <script>
            // Automatically hide messages after 5 seconds
            setTimeout(function () {
                var errorMessage = document.getElementById('error-message');
                var successMessage = document.getElementById('success-message');
                if (errorMessage.innerHTML) {
                    errorMessage.style.display = 'none';
                }
                if (successMessage.innerHTML) {
                    successMessage.style.display = 'none';
                }
            }, 5000);
        </script>

    </body>
</html>