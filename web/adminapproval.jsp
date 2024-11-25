<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <title>Admin Approval</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                padding-top: 56px;
            }

            /* Navbar Styles */
            .navbar {
                background-color: #5bc0de;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                height: 56px;
                z-index: 1030;
                padding: 0 20px;
                display: flex;
                align-items: center;
            }

            .navbar-brand {
                color: white;
                text-decoration: none;
                font-size: 1.25rem;
                margin-right: 20px;
            }

            .navbar-nav {
                display: flex;
                list-style: none;
                margin-left: auto;
            }

            .nav-item {
                margin: 0 10px;
            }

            .nav-link {
                color: white !important;
                text-decoration: none;
                transition: color 0.2s;
                padding: 8px 12px;
                display: inline-block;
            }

            .nav-link:hover {
                color: #f0ad4e !important;
            }

            /* Sidebar Styles */
            .sidebar {
                min-width: 250px;
                background-color: #f8f9fa;
                color: #343a40;
                height: 100vh;
                position: fixed;
                top: 56px;
                left: 0;
                padding: 15px;
                z-index: 1000;
            }

            .sidebar h2 {
                color: #5bc0de;
                margin-bottom: 20px;
                font-size: 1.5rem;
                padding-bottom: 10px;
                border-bottom: 2px solid #5bc0de;
            }

            .sidebar .nav {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .sidebar .nav-item {
                margin-bottom: 5px;
            }

            .sidebar .nav-link {
                display: block;
                padding: 10px 15px;
                color: #6c757d !important;
                text-decoration: none;
                transition: all 0.3s ease;
                border-radius: 5px;
            }

            .sidebar .nav-link:hover {
                background-color: #e9ecef;
                color: #5bc0de !important;
                transform: translateX(10px);
            }

            .sidebar .nav-link i {
                margin-right: 10px;
                width: 20px;
                text-align: center;
            }

            .sidebar .nav-link.active {
                background-color: #5bc0de;
                color: white !important;
            }

            /* Main Content Area */
            .main-content {
                margin-left: 350px;
                padding: 20px;
                padding-top: 76px; /* 56px (navbar) + 20px (spacing) */
            }

            .no-sidebar {
                margin-left: 20px;
            }

            /* Table Container */
            .table-container {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 20px;
                margin-top: 20px;
                overflow-x: auto;
            }

            /* Table Styles */
            table {
                width: 100%;
                border-collapse: collapse;
            }

            th {
                background-color: #4CAF50;
                color: white;
                padding: 15px;
                text-align: left;
                font-weight: 600;
            }

            td {
                padding: 12px 15px;
                border-bottom: 1px solid #ddd;
            }

            tr:hover {
                background-color: #f9f9f9;
            }

            /* Button Styles */
            .action-buttons {
                display: flex;
                gap: 10px;
            }

            .approve-btn, .reject-btn {
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                color: white;
                transition: all 0.3s;
            }

            .approve-btn {
                background-color: #4CAF50;
            }

            .approve-btn:hover {
                background-color: #45a049;
            }

            .reject-btn {
                background-color: #f44336;
            }

            .reject-btn:hover {
                background-color: #da190b;
            }

            /* Status Styles */
            .status-approved {
                color: #4CAF50;
                font-weight: bold;
            }

            .status-rejected {
                color: #f44336;
                font-weight: bold;
            }

            .status-pending {
                color: #ffa500;
                font-weight: bold;
            }

            /* Page Title */
            h1 {
                color: #2c3e50;
                margin-bottom: 20px;
                font-size: 2em;
            }

            /* Messages */
            .error, .success {
                padding: 12px 20px;
                border-radius: 4px;
                margin-bottom: 20px;
            }

            .error {
                background-color: #fee;
                color: #c33;
                border: 1px solid #fcc;
            }

            .success {
                background-color: #efe;
                color: #3c3;
                border: 1px solid #cfc;
            }

            /* Home Link */
            .home-link {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #5bc0de;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s;
            }

            .home-link:hover {
                background-color: #46b8da;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                }

                .sidebar.show {
                    transform: translateX(0);
                }

                .main-content {
                    margin-left: 0;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar">
            <a class="navbar-brand" href="home">
                <i class="fas fa-motorcycle"></i>
                Motorbike Rental
            </a>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="home"><i class="fas fa-home"></i> Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="listmoto"><i class="fas fa-list"></i> Danh sách xe máy</a></li>
                <li class="nav-item"><a class="nav-link" href="ai.jsp"><i class="fas fa-gift"></i> Khuyến mãi</a></li>
                <li class="nav-item"><a class="nav-link" href="manageuser"><i class="fas fa-phone"></i> Liên hệ</a></li>
                <li class="nav-item"><a class="nav-link" href="profile"><i class="fas fa-user"></i> Hồ sơ</a></li>
                <li class="nav-item"><a class="nav-link" href="createmotorbyuser"><i class="fas fa-motorcycle"></i> Cho thuê xe</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star"></i> Đánh giá</a></li>
                    <c:if test="${sessionScope.user == null}">
                    <li class="nav-item"><a class="nav-link" href="login"><i class="fas fa-sign-in-alt"></i> Đăng nhập</a></li>
                    </c:if>
            </ul>
        </nav>

        <!-- Sidebar for admin -->
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

        <!-- Main content -->
        <div class="main-content ${sessionScope.user.role != 'Admin' ? 'no-sidebar' : ''}">
            <h1>Danh sách xe chờ duyệt</h1>



            <div class="table-container">
                <c:if test="${not empty errorMessage}">
                    <div class="error">${errorMessage}</div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="success">${successMessage}</div>
                </c:if>

                <table border="1">
                    <thead>
                        <tr>
                            <th>Tên xe</th>
                            <th>Hãng xe</th>
                            <th>Năm sản xuất</th>
                            <th>Giá thuê/Ngày</th>
                            <th>Biển số xe</th>
                            <th>Loại xe</th>
                            <th>Màu sắc</th>
                            <th>Dung tích xi-lanh</th>
                            <th>Nhiên liệu</th>
                            <th>Số km đã đi</th>
                            <th>Chủ sở hữu</th>
                            <th>Trạng thái/Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="motorbike" items="${pendingMotorbikes}">
                            <tr>
                                <td>${motorbike.model}</td>
                                <td>${motorbike.brand}</td>
                                <td>${motorbike.year}</td>
                                <td>${motorbike.dailyRate}</td>
                                <td>${motorbike.licensePlate}</td>
                                <td>${motorbike.typeId.typeName}</td>
                                <td>${motorbike.color}</td>
                                <td>${motorbike.engineSize}</td>
                                <td>${motorbike.fuelType}</td>
                                <td>${motorbike.mileage}</td>
                                <td class="owner-info">${user.fullName}<br>
                                    <small>Email: ${user.email}</small>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${sessionScope.user.role == 'Admin'}">
                                            <div class="action-buttons">
                                                <form action="approvalmotorbike" method="POST" style="display: inline;">
                                                    <input type="hidden" name="motorbikeId" value="${motorbike.id}">
                                                    <input type="hidden" name="action" value="approve">
                                                    <button type="submit" class="approve-btn">Approve</button>
                                                </form>
                                                <form action="approvalmotorbike" method="POST" style="display: inline;">
                                                    <input type="hidden" name="motorbikeId" value="${motorbike.id}">
                                                    <input type="hidden" name="action" value="reject">
                                                    <button type="submit" class="reject-btn">Reject</button>
                                                </form>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${motorbike.status == 'APPROVED'}">
                                                    <span class="status-approved">Chấp nhận</span>
                                                </c:when>
                                                <c:when test="${motorbike.status == 'REJECTED'}">
                                                    <span class="status-rejected">Từ chối</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-pending">Đang chờ duyệt</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <a href="home" class="home-link">Trang chủ</a>
        </div>
    </body>
</html>