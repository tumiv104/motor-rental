<%-- 
    Document   : statistic
    Created on : Nov 1, 2024, 11:13:54 PM
    Author     : hungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard Thống Kê</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --success-color: #4cc9f0;
                --info-color: #4895ef;
                --warning-color: #f72585;
            }

            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', sans-serif;
            }
            .navbar {
                background-color: #5bc0de;
                z-index: 1;
            }
            .navbar .nav-link {
                color: white !important;
                transition: color 0.2s;
            }
            .navbar .nav-link:hover {
                color: #f0ad4e !important;
            }
            .navbar {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 10;
            }
            .navbar {
                position: fixed; /* Assuming the navbar is fixed */
                top: 0;
                left: 0;
                right: 0;
                z-index: 10; /* Higher z-index to stay above the banner */
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

            .sidebar h3 {
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
                margin-left: 250px;
                padding: 20px;
                padding-top: 76px; /* 56px (navbar) + 20px (spacing) */
            }

            .no-sidebar {
                margin-left: 20px;
            }

            .dashboard-container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 2rem;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                border-radius: 1rem;
                padding: 1.5rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
            }

            .stat-icon {
                width: 48px;
                height: 48px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 1rem;
            }

            .stat-label {
                color: #6c757d;
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
            }

            .stat-value {
                font-size: 1.8rem;
                font-weight: 600;
                color: #2d3748;
            }

            .revenue-card {
                background: white;
                border-radius: 1rem;
                padding: 1.5rem;
                margin-bottom: 2rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            }

            .revenue-title {
                font-size: 1.2rem;
                font-weight: 600;
                color: #2d3748;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
            }

            .revenue-title i {
                margin-right: 0.5rem;
            }

            .table {
                border-radius: 0.5rem;
                overflow: hidden;
            }

            .table thead th {
                background-color: #f8f9fa;
                border-bottom: none;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.8rem;
                letter-spacing: 0.5px;
            }

            .table td {
                vertical-align: middle;
                padding: 1rem;
            }

            .back-button {
                display: inline-flex;
                align-items: center;
                padding: 0.5rem 1rem;
                background-color: var(--primary-color);
                color: white;
                text-decoration: none;
                border-radius: 0.5rem;
                transition: all 0.3s ease;
            }

            .back-button:hover {
                background-color: var(--secondary-color);
                color: white;
            }

            .back-button i {
                margin-right: 0.5rem;
            }

            /* Animation */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .stat-card, .revenue-card {
                animation: fadeIn 0.5s ease-out forwards;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .dashboard-container {
                    padding: 1rem;
                }

                .stats-grid {
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                }

                .stat-value {
                    font-size: 1.5rem;
                }
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
        <div class="dashboard-container">
            <h1 class="text-center mb-4">Báo Cáo Thống Kê</h1>

            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon" style="background-color: #4361ee20;">
                        <i class="fas fa-calendar-check fa-lg" style="color: #4361ee;"></i>
                    </div>
                    <div class="stat-label">Tổng số lượng booking</div>
                    <div class="stat-value">${totalBookings}</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background-color: #f7258520;">
                        <i class="fas fa-money-bill-wave fa-lg" style="color: #f72585;"></i>
                    </div>
                    <div class="stat-label">Tổng doanh thu</div>
                    <div class="stat-value">
                        <c:forEach var="entry" items="${paymentData}" varStatus="status">
                            <div style="font-size: 1rem;">${entry.key}: <fmt:formatNumber value="${entry.value}" type="currency" currencySymbol="VNĐ" minFractionDigits="0" maxFractionDigits="0"/></div>
                        </c:forEach>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background-color: #4cc9f020;">
                        <i class="fas fa-star fa-lg" style="color: #4cc9f0;"></i>
                    </div>
                    <div class="stat-label">Điểm đánh giá trung bình</div>
                    <div class="stat-value">${avgRating} / 5</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background-color: #4895ef20;">
                        <i class="fas fa-receipt fa-lg" style="color: #4895ef;"></i>
                    </div>
                    <div class="stat-label">Tổng phí bổ sung</div>
                    <div class="stat-value"><fmt:formatNumber value="${totalFees}" type="currency" currencySymbol="VNĐ" minFractionDigits="0" maxFractionDigits="0"/></div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background-color: #3f37c920;">
                        <i class="fas fa-credit-card fa-lg" style="color: #3f37c9;"></i>
                    </div>
                    <div class="stat-label">Tổng số lượng payment</div>
                    <div class="stat-value">${totalPayments}</div>
                </div>
            </div>

            <!-- Revenue Statistics -->
            <div class="revenue-card">
                <div class="revenue-title">
                    <i class="fas fa-chart-line"></i>
                    Thống kê doanh thu theo ngày
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Ngày</th>
                                <th>Doanh thu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${revenueByDay}" var="entry">
                                <tr>
                                    <td>${entry.key}</td>
                                    <td><fmt:formatNumber value="${entry.value}" type="currency" currencySymbol="VNĐ" minFractionDigits="0" maxFractionDigits="0"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="revenue-card">
                <div class="revenue-title">
                    <i class="fas fa-calendar-week"></i>
                    Thống kê doanh thu theo tuần
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Tuần</th>
                                <th>Doanh thu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${revenueByWeek}" var="entry">
                                <tr>
                                    <td>${entry.key}</td>
                                    <td><fmt:formatNumber value="${entry.value}" type="currency" currencySymbol="VNĐ" minFractionDigits="0" maxFractionDigits="0"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="revenue-card">
                <div class="revenue-title">
                    <i class="fas fa-calendar-alt"></i>
                    Thống kê doanh thu theo tháng
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Tháng</th>
                                <th>Doanh thu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${revenueByMonth}" var="entry">
                                <tr>
                                    <td>${entry.key}</td>
                                    <td><fmt:formatNumber value="${entry.value}" type="currency" currencySymbol="VNĐ" minFractionDigits="0" maxFractionDigits="0"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="revenue-card">
                <div class="revenue-title">
                    <i class="fas fa-calendar"></i>
                    Thống kê doanh thu theo năm
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Năm</th>
                                <th>Doanh thu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${revenueByYear}" var="entry">
                                <tr>
                                    <td>${entry.key}</td>
                                    <td><fmt:formatNumber value="${entry.value}" type="currency" currencySymbol="VNĐ" minFractionDigits="0" maxFractionDigits="0"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="revenue-card">
                <div class="revenue-title">
                    <i class="fas fa-calendar"></i>
                    Thống kê các loại xe
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Loại xe</th>
                                <th>Số lượng</th>
                                <th>Giá thuê trung bình</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${statistic}" var="stat">
                                <tr>
                                    <td>${stat[0]}</td>
                                    <td>${stat[1]}</td>
                                    <td>
                                        <fmt:formatNumber value="${stat[2]}" type="currency" currencySymbol="₫"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <a href="home" class="back-button">
                <i class="fas fa-arrow-left"></i>
                Quay lại trang chủ
            </a>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
