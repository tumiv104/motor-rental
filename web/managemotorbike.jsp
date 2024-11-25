<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ page import="model.Motorbike" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản Lý Xe Máy</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
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
            body {
                background: linear-gradient(to right, #33ffff, #80e0f9);
                font-family: 'Arial', sans-serif;
            }
            h1 {
                text-align: center;
                background-color: #ffff00;
                margin: 20px auto;
                padding: 15px;
                border-radius: 10px;
                width: 60%;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                font-weight: bold;
                color: #333;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 15px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            }
            .alert {
                margin: 20px 0;
                border-radius: 10px;
            }
            table {
                width: 100%;
                margin-top: 20px;
                border: none;
            }
            th {
                background-color: #007bff;
                color: white;
                border-radius: 10px 10px 0 0;
            }
            th, td {
                border: 1px solid #dee2e6;
                text-align: center;
                padding: 10px;
            }
            th:first-child {
                border-top-left-radius: 10px;
            }
            th:last-child {
                border-top-right-radius: 10px;
            }
            tr:hover {
                background-color: #f2f2f2;
            }
            .btn {
                border-radius: 10px;
                transition: background-color 0.3s;
            }
            .btn-primary {
                background-color: #007bff;
            }
            .btn-success {
                background-color: #28a745;
            }
            .btn-danger {
                background-color: #dc3545;
            }
            .btn-info {
                background-color: #17a2b8;
            }
            .btn:hover {
                filter: brightness(90%);
            }
            .back-link {
                display: block;
                text-align: center;
                margin-top: 20px;
                font-size: 18px;
                color: #007bff;
                text-decoration: none;
            }
            .back-link:hover {
                text-decoration: underline;
            }
            .img-thumbnail {
                max-width: 100px;
                border-radius: 5px;
            }
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
                    <li class="nav-item"><a class="nav-link" href="createmotorbyuser"><i class="fas fa-motorcycle mr-2"></i> Cho thuê xe</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Đánh giá</a></li>
                        <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="login"><i class="fas fa-sign-in-alt mr-1"></i> Đăng nhập</a></li>
                        </c:if>
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
                    <li class="nav-item"><a class="nav-link" href="updatepending"><i class="fas fa-user-plus"></i> Quản lý nâng cấp tài khoản</a></li>
                    <li class="nav-item"><a class="nav-link" href="promotion"><i class="fas fa-tags"></i> Quản lí mã giảm giá</a></li>
                    <li class="nav-item"><a class="nav-link" href="statistic"><i class="fas fa-chart-bar"></i> Thống kê</a></li>
                </ul>
            </div>
        </c:if>
        <div class="container mt-5">
            <h1><i class="fas fa-motorcycle"></i> Danh Sách Xe Máy</h1>



            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Tên xe</th>
                        <th>Hãng xe</th>
                        <th>Năm sản xuất</th>
                        <th>Giá Ngày</th>
                        <th>Trạng thái</th>
                        <th>Biển số xe</th>
                        <th>Màu sắc</th>
                        <th>Dung tích xi-lanh</th>
                        <th>Nhiên liệu</th>
                        <th>Ảnh</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Motorbike> motorbikes = (List<Motorbike>) request.getAttribute("motorbikes");
                        if (motorbikes != null && !motorbikes.isEmpty()) {
                            for (Motorbike motorbike : motorbikes) {
                    %>
                    <tr>
                        <td><%= motorbike.getModel() %></td>
                        <td><%= motorbike.getBrand() %></td>
                        <td><%= motorbike.getYear() %></td>
                        <td><%= motorbike.getDailyRate() %></td>
                        <td><%= motorbike.getStatus() %></td>
                        <td><%= motorbike.getLicensePlate() %></td>
                        <td><%= motorbike.getColor() %></td>
                        <td><%= motorbike.getEngineSize() %></td>
                        <td><%= motorbike.getFuelType() %></td>
                        <td><img src="<%= motorbike.getImageUrl() %>" alt="Motorbike Image" class="img-thumbnail"></td>
                        <td>
                            <form action="editmotorbike" method="get" class="d-inline">
                                <input type="hidden" name="id" value="<%= motorbike.getMotorbikeId() %>">
                                <button type="submit" class="btn btn-primary">Chỉnh sửa</button>
                            </form>
                            <form action="deletemotorbike" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                                <input type="hidden" name="id" value="<%= motorbike.getMotorbikeId() %>">
                                <button type="submit" class="btn btn-danger">Xóa</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="11">Không có moto</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <form action="createmotorbike" method="POST" class="mt-3">
                <button type="submit" class="btn btn-success">Tạo xe máy</button>
            </form>
            <a href="home" class="btn btn-info mt-3">Trang chủ</a>
        </div>
    </body>
</html>
