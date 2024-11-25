<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tạo Người Dùng Mới</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            :root {
                --sidebar-width: 250px;
                --navbar-height: 60px;
                --primary-color: #2563eb;
            }

            body {
                background: linear-gradient(120deg, #f0f2f5, #ffffff);
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding-top: var(--navbar-height);
            }

            /* Navbar Styles */
            .navbar {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                height: var(--navbar-height);
                background-color: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                z-index: 1000;
            }

            .navbar-brand {
                font-size: 1.5rem;
                font-weight: bold;
                color: var(--primary-color);
                text-decoration: none;
            }

            .navbar-nav .nav-link {
                color: #1a1a1a;
                text-decoration: none;
                font-weight: 500;
                padding: 8px 12px;
                border-radius: 6px;
                transition: all 0.3s ease;
            }

            .navbar-nav .nav-link:hover {
                background-color: #f0f2f5;
                color: var(--primary-color);
            }

            /* Sidebar Styles */
            .sidebar {
                position: fixed;
                top: var(--navbar-height);
                left: 0;
                width: var(--sidebar-width);
                height: calc(100vh - var(--navbar-height));
                background-color: white;
                box-shadow: 2px 0 4px rgba(0,0,0,0.1);
                padding: 20px 0;
                overflow-y: auto;
            }

            .sidebar h2 {
                padding: 0 20px;
                margin-bottom: 20px;
                color: var(--primary-color);
                font-size: 1.5rem;
            }

            .sidebar .nav-link {
                color: #1a1a1a;
                padding: 10px 20px;
                display: flex;
                align-items: center;
                transition: all 0.3s ease;
            }

            .sidebar .nav-link i {
                margin-right: 10px;
                width: 20px;
                text-align: center;
            }

            .sidebar .nav-link:hover {
                background-color: #f0f2f5;
                color: var(--primary-color);
            }

            /* Main Content Styles */
            .main-content {
                margin-left: var(--sidebar-width);
                padding: 20px;
            }

            .form-container {
                max-width: 600px;
                margin: 40px auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s;
            }

            .form-container:hover {
                transform: scale(1.02);
            }

            .form-group label {
                font-weight: bold;
                color: #495057;
            }

            .form-control {
                border-radius: 10px;
                padding: 12px;
                border: 1px solid #ced4da;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            .btn-primary {
                background-color: var(--primary-color);
                border: none;
                border-radius: 10px;
                padding: 12px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #1d4ed8;
                transform: translateY(-2px);
            }

            .back-btn {
                display: inline-flex;
                align-items: center;
                padding: 8px 16px;
                border-radius: 8px;
                background-color: #64748b;
                color: white;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .back-btn:hover {
                background-color: #475569;
                color: white;
                text-decoration: none;
            }

            .page-title {
                color: #1a1a1a;
                font-weight: 600;
                margin-bottom: 30px;
                font-size: 1.75rem;
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Đánh giá </a></li>
                    <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="login"><i class="fas fa-sign-in-alt mr-1"></i> Đăng nhập</a></li>
                    </c:if>
                </ul>
            </div>
        </nav>

        <!-- New Sidebar -->
    <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
        <div class="sidebar">
            <h2>Quản Lý Trang</h2>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="approvalmotorbike"><i class="fas fa-tachometer-alt"></i> Quản lý cho thuê xe máy</a></li>
                <li class="nav-item"><a class="nav-link" href="managebookinglist"><i class="fas fa-list-alt"></i> Quản lý đơn hàng</a></li>
                <li class="nav-item"><a class="nav-link" href="manageuser"><i class="fas fa-users-cog"></i> Quản lý người dùng</a></li>
                <li class="nav-item"><a class="nav-link" href="viewmotorbike"><i class="fas fa-motorcycle"></i> Quản lý xe máy</a></li>
                <li class="nav-item"><a class="nav-link" href="updatepending"><i class="fas fa-user-plus"></i> Quản lý nâng cấp tài khoản</a></li>
                <li class="nav-item"><a class="nav-link" href="promotion"><i class="fas fa-tags"></i> Quản lí mã giảm giá</a></li>
                <li class="nav-item"><a class="nav-link" href="statistic"><i class="fas fa-chart-bar"></i> Thống kê</a></li>
            </ul>
        </div>
    </c:if>

    <!-- Main Content -->
    <div class="main-content">
        <h2 class="page-title">
            <i class="fas fa-user-plus mr-2"></i>
            Tạo Người Dùng Mới
        </h2>

        <div class="form-container">
            <form action="createuser" method="post">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="fullName">Full Name:</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="phoneNumber">Phone Number:</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" class="form-control">
                </div>
                <div class="form-group">
                    <label for="dateOfBirth">Date of Birth:</label>
                    <input type="date" id="dateOfBirth" name="dateOfBirth" class="form-control" required>
                </div>


                <div class="form-group">
                    <label for="role" >Role:</label>
                    <select id="role" name="role" class="form-control" required>
                        <option value="" disabled selected >Chọn vai trò</option>
                        <option value="Manager">Manager</option>
                        <option value="Admin">Admin</option>
                    </select>
                </div>
        </div>
        <button type="submit" style="margin-left: 32.3%" class="btn btn-info mt-3">Create User</button>
        <br>
        <a href="home" class="back-btn">
            <i class="fas fa-arrow-left mr-2"></i>
            Trở về trang chủ
        </a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>