<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Management</title>
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
                background-color: #f0f8ff; /* Light background color */
                font-family: 'Arial', sans-serif;
            }
            h2 {
                text-align: center;
                background-color: #4e73df; /* Header background color */
                color: white; /* Header text color */
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 30px;
            }
            .table {
                border: 1px solid #dee2e6;
            }
            .table th,
            .table td {
                border: 1px solid #dee2e6;
                vertical-align: middle; /* Center align cell content */
            }
            .ban-form {
                margin-top: 10px;
            }
            .alert {
                margin-top: 20px;
            }
            .btn {
                margin: 5px 0; /* Add margin to buttons */
            }
            .footer-links {
                text-align: center;
                margin-top: 30px;
            }
            .footer-links a {
                margin: 0 10px;
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
            <h2>Quản lý người dùng</h2>

            <c:if test="${not empty requestScope.message}">
                <div class="alert alert-success">${requestScope.message}</div>
            </c:if>
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-danger">${requestScope.error}</div>
            </c:if>

            <c:choose>
                <c:when test="${sessionScope.user.role == 'Admin'}">
                    <table class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Tên đăng nhập</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${userList}">
                                <tr>
                                    <td>${user.username}</td>
                                    <td>${user.email}</td>
                                    <td>${user.role}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.isActive}">
                                                <span class="text-success">Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-danger">Cấm</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${user.role != 'Admin'}">
                                            <c:choose>
                                                <c:when test="${user.isActive}">
                                                    <div class="ban-form">
                                                        <form action="manageuser" method="post" class="action-form">
                                                            <input type="hidden" name="userId" value="${user.userId}">
                                                            <input type="hidden" name="action" value="ban">
                                                            <div class="form-group">
                                                                <label for="banReason">Lí do:</label>
                                                                <input type="text" id="banReason" name="banReason" class="form-control" required>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="bannedUntil">Bị cấm cho đến ngày:</label>
                                                                <input type="date" id="bannedUntil" name="bannedUntil" class="form-control" required>
                                                            </div>
                                                            <input type="submit" value="Cấm" class="btn btn-warning">
                                                        </form>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div>
                                                        <strong>Lí do cấm:</strong> ${user.bannedReason} <br>
                                                        <strong>Bị cấm cho đến ngày:</strong> ${user.bannedUntil}
                                                    </div>
                                                    <form action="manageuser" method="post" class="action-form">
                                                        <input type="hidden" name="userId" value="${user.userId}">
                                                        <input type="hidden" name="action" value="unban">
                                                        <input type="submit" value="Hủy cấm" class="btn btn-success btn-sm">
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                            <form action="manageuser" method="post" class="action-form">
                                                <input type="hidden" name="userId" value="${user.userId}">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="submit" value="Xóa" class="btn btn-danger btn-sm" 
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?');">
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="alert alert-warning">Bạn không có đủ quyền để truy cập vào trang này.</p>
                </c:otherwise>
            </c:choose>

            <c:if test="${not empty requestScope.banReason}">
                <div class="alert alert-info">
                    Người dùng bị cấm vì: ${requestScope.banReason} cho đến khi ${requestScope.bannedUntil}.
                </div>
            </c:if>

            <div class="footer-links">
                <form action="createuser" method="POST" class="d-inline">
                    <input class="btn btn-info" type="submit" value="Tạo người dùng">
                </form>
                <a href="home" class="btn btn-info">Trang chủ</a>
            </div>
        </div>
    </body>
</html>
