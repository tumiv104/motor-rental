<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Profile</title>
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

            .edit-profile-content {
                background-color: white;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.05);
                padding: 40px;
                margin: 20px auto;
                transition: transform 0.3s ease;
            }

            .edit-profile-content:hover {
                transform: translateY(-5px);
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-control {
                border-radius: 8px;
                padding: 12px;
                border: 1px solid #e1e1e1;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                box-shadow: 0 0 0 2px var(--secondary-color);
                border-color: var(--secondary-color);
            }

            /* Button Styles */
            .btn {
                padding: 10px 25px;
                border-radius: 25px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-success {
                background-color: var(--secondary-color);
                border: none;
            }

            .btn-success:hover {
                background-color: #2980b9;
                transform: translateY(-2px);
            }

            .btn-secondary {
                background-color: #95a5a6;
                border: none;
            }

            .btn-secondary:hover {
                background-color: #7f8c8d;
                transform: translateY(-2px);
            }

            /* Profile Picture Preview */
            .profile-picture-preview {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                margin-top: 10px;
                border: 3px solid var(--secondary-color);
                box-shadow: 0 3px 10px rgba(0,0,0,0.1);
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
                text-align: center;
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

                .edit-profile-content {
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
            <div class="edit-profile-content">
                <h3 class="mb-4">Chỉnh sửa thông tin cá nhân</h3>

                <!-- Alert Messages -->
                <c:if test="${not empty requestScope.successMessage}">
                    <div class="alert alert-success">
                        <c:out value="${requestScope.successMessage}" />
                    </div>
                </c:if>

                <c:if test="${not empty requestScope.errorMessage}">
                    <div class="alert alert-danger">
                        <c:out value="${requestScope.errorMessage}" />
                    </div>
                </c:if>

                <!-- Edit Profile Form -->
                <form action="editprofile" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="username">Tên người dùng:</label>
                        <input type="text" id="username" name="username" class="form-control" value="${sessionScope.user.username}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" class="form-control" value="${sessionScope.user.email}" required>
                    </div>

                    <div class="form-group">
                        <label for="phoneNumber">Số điện thoại:</label>
                        <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" value="${sessionScope.user.phoneNumber}" required>
                    </div>

                    <div class="form-group">
                        <label for="address">Địa chỉ:</label>
                        <input type="text" id="address" name="address" class="form-control" value="${sessionScope.user.address}" required>
                    </div>

                    <div class="form-group">
                        <label for="dateOfBirth">Ngày sinh:</label>
                        <input type="date" id="dateOfBirth" name="dateOfBirth" class="form-control" value="${sessionScope.user.dateOfBirth}" required>
                    </div>

                    <div class="form-group">
                        <label for="profilePicture">Ảnh đại diện:</label>
                        <input type="file" id="profilePicture" name="profilePicture" class="form-control">
                        <c:if test="${sessionScope.user.profilePicture != null}">
                            <img src="uploads/${sessionScope.user.profilePicture}" alt="Profile Picture" class="profile-picture-preview">
                        </c:if>
                    </div>

                    <div class="mt-4">
                        <button type="submit" class="btn btn-success mr-2"><i class="fas fa-save mr-1"></i> Cập nhật</button>
                        <a href="profile" class="btn btn-secondary"><i class="fas fa-times mr-1"></i> Hủy</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2024 Motorbike Rental Service</p>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>