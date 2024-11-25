<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Yêu Cầu Nâng Cấp | Admin</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4f46e5;
                --primary-hover: #4338ca;
                --secondary-color: #1e293b;
                --success-color: #22c55e;
                --danger-color: #ef4444;
                --warning-color: #f59e0b;
                --info-color: #5bc0de;
                --light-bg: #f8fafc;
                --card-bg: #ffffff;
                --text-primary: #1e293b;
                --text-secondary: #64748b;
                --border-color: #e2e8f0;
                --shadow-sm: 0 1px 3px rgba(0,0,0,0.1);
                --shadow-md: 0 4px 6px -1px rgba(0,0,0,0.1);
                --transition: all 0.3s ease;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Inter', system-ui, -apple-system, sans-serif;
            }

            body {
                background-color: var(--light-bg);
                color: var(--text-primary);
                line-height: 1.6;
            }

            /* Dashboard Layout */
            .layout-container {
                display: flex;
                min-height: 100vh;
            }

            .navbar {
                background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-hover) 100%);
                padding: 1rem 2rem;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
                box-shadow: var(--shadow-md);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .navbar-brand {
                color: white;
                text-decoration: none;
                font-size: 1.25rem;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .navbar-nav {
                display: flex;
                list-style: none;
                margin: 0;
                padding: 0;
                gap: 1.5rem;
                align-items: center;
            }

            .nav-item {
                margin: 0;
            }

            .nav-link {
                color: white;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.5rem;
                transition: var(--transition);
            }

            .nav-link:hover {
                opacity: 0.8;
            }

            .nav-link i {
                font-size: 1rem;
            }


            /* Sidebar Styling */
            .sidebar {
                width: 280px;
                background-color: var(--card-bg);
                height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                padding-top: 80px;
                box-shadow: var(--shadow-md);
                overflow-y: auto;
                transition: var(--transition);
            }

            .sidebar-header {
                padding: 1.5rem;
                border-bottom: 1px solid var(--border-color);
            }

            .sidebar-header h2 {
                color: var(--primary-color);
                font-size: 1.25rem;
                font-weight: 600;
            }

            .sidebar-menu {
                padding: 1rem 0;
            }

            .menu-item {
                padding: 0.75rem 1.5rem;
                display: flex;
                align-items: center;
                color: var(--text-secondary);
                text-decoration: none;
                transition: var(--transition);
                border-left: 3px solid transparent;
            }

            .menu-item:hover {
                background-color: var(--light-bg);
                color: var(--primary-color);
                border-left-color: var(--primary-color);
            }

            .menu-item i {
                width: 20px;
                margin-right: 10px;
            }

            /* Main Content Area */
            .main-content {
                margin-left: 280px;
                padding: 100px 2rem 2rem;
                width: calc(100% - 280px);
            }

            /* Dashboard Cards */
            .dashboard-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .card {
                background: var(--card-bg);
                border-radius: 10px;
                padding: 1.5rem;
                box-shadow: var(--shadow-sm);
                transition: var(--transition);
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: var(--shadow-md);
            }

            .card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
            }

            .card-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: var(--text-primary);
            }

            .card-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: var(--primary-color);
                color: white;
            }

            /* Table Styling */
            .table-container {
                background: var(--card-bg);
                border-radius: 10px;
                box-shadow: var(--shadow-sm);
                overflow: hidden;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th {
                background-color: var(--light-bg);
                color: var(--text-primary);
                font-weight: 600;
                padding: 1rem;
                text-align: left;
            }

            td {
                padding: 1rem;
                border-bottom: 1px solid var(--border-color);
            }

            tr:hover {
                background-color: var(--light-bg);
            }

            /* Status Tags */
            .status-tag {
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .status-pending {
                background-color: #fef3c7;
                color: var(--warning-color);
            }

            .status-approved {
                background-color: #dcfce7;
                color: var(--success-color);
            }

            .status-rejected {
                background-color: #fee2e2;
                color: var(--danger-color);
            }

            /* Action Buttons */
            .btn {
                padding: 0.5rem 1rem;
                border-radius: 6px;
                font-weight: 500;
                cursor: pointer;
                transition: var(--transition);
                border: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-primary {
                background-color: var(--primary-color);
                color: white;
            }

            .btn-success {
                background-color: var(--success-color);
                color: white;
            }

            .btn-danger {
                background-color: var(--danger-color);
                color: white;
            }

            .btn:hover {
                transform: translateY(-2px);
                opacity: 0.9;
            }

            /* Modal Styling */
            .modal {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.5);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 1000;
            }

            .modal-content {
                background: var(--card-bg);
                border-radius: 10px;
                padding: 2rem;
                width: 90%;
                max-width: 500px;
                box-shadow: var(--shadow-md);
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
            }

            .modal-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--text-primary);
            }

            .close-modal {
                background: none;
                border: none;
                font-size: 1.5rem;
                cursor: pointer;
                color: var(--text-secondary);
            }

            /* Form Controls */
            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                display: block;
                margin-bottom: 0.5rem;
                color: var(--text-primary);
                font-weight: 500;
            }

            .form-control {
                width: 100%;
                padding: 0.75rem;
                border: 1px solid var(--border-color);
                border-radius: 6px;
                transition: var(--transition);
            }

            .form-control:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.1);
            }

            /* Responsive Design */
            @media (max-width: 1024px) {
                .sidebar {
                    width: 240px;
                }
                .main-content {
                    margin-left: 240px;
                    width: calc(100% - 240px);
                }
            }

            @media (max-width: 768px) {
                .navbar {
                    flex-direction: column;
                    padding: 1rem;
                }

                .navbar-nav {
                    flex-wrap: wrap;
                    justify-content: center;
                    gap: 1rem;
                    margin-top: 1rem;
                }

                .nav-link {
                    font-size: 0.9rem;
                }
                .sidebar {
                    transform: translateX(-100%);
                }
                .sidebar.active {
                    transform: translateX(0);
                }
                .main-content {
                    margin-left: 0;
                    width: 100%;
                    padding: 80px 1rem 1rem;
                }
                .dashboard-cards {
                    grid-template-columns: 1fr;
                }
                .table-container {
                    overflow-x: auto;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar">
            <a class="navbar-brand" href="home">
                <i class="fas fa-motorcycle"></i>
                Motorbike Rental
            </a>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="home">
                        <i class="fas fa-home"></i>Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="listmoto">
                        <i class="fas fa-list"></i>Danh sách xe
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ai.jsp">
                        <i class="fas fa-gift"></i>Khuyến mãi
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="manageuser">
                        <i class="fas fa-phone"></i>Liên hệ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="profile">
                        <i class="fas fa-user"></i>Hồ sơ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="createmotorbyuser">
                        <i class="fas fa-motorcycle"></i>Cho thuê xe
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/websitereview">
                        <i class="fas fa-star"></i>Đánh giá
                    </a>
                </li>
                <c:if test="${sessionScope.user == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="login">
                            <i class="fas fa-sign-in-alt"></i>Đăng nhập
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>

        <!-- Sidebar -->
        <div class="layout-container">
            <!-- Sidebar -->
            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h2>Quản Lý Trang</h2>
                    </div>
                    <nav class="sidebar-menu">
                        <a href="approvalmotorbike" class="menu-item">
                            <i class="fas fa-motorcycle"></i>
                            Quản lý cho thuê xe máy
                        </a>
                        <a href="managebookinglist" class="menu-item">
                            <i class="fas fa-list-alt"></i>
                            Quản lý đơn hàng
                        </a>
                        <a href="manageuser" class="menu-item">
                            <i class="fas fa-users"></i>
                            Quản lý người dùng
                        </a>
                        <a href="viewmotorbike" class="menu-item">
                            <i class="fas fa-motorcycle"></i>
                            Quản lý xe máy
                        </a>
                        <a href="updatepending" class="menu-item active">
                            <i class="fas fa-user-plus"></i>
                            Quản lý nâng cấp tài khoản
                        </a>
                        <a href="promotion" class="menu-item">
                            <i class="fas fa-tags"></i>
                            Quản lý mã giảm giá
                        </a>
                        <a href="statistic" class="menu-item">
                            <i class="fas fa-chart-bar"></i>
                            Thống kê
                        </a>
                    </nav>
                </aside>
            </c:if>
            <!-- Main Content -->
            <main class="main-content">
                <!-- Dashboard Cards -->
                <div class="dashboard-cards">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Yêu cầu đang chờ</h3>
                            <div class="card-icon">
                                <i class="fas fa-tasks"></i>
                            </div>
                        </div>
                        <div class="card-body">
                            <h2>${pendingCount}</h2>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Đã chấp nhận</h3>
                            <div class="card-icon">
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>
                        <div class="card-body">
                            <h2>${approvedCount}</h2>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Đã từ chối</h3>
                            <div class="card-icon">
                                <i class="fas fa-check"></i>
                            </div>
                        </div>
                        <div class="card-body">
                            <h2>${rejectedCount}</h2>
                        </div>
                    </div>
                </div>

                <!-- Table Section -->
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Người dùng</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Địa chỉ</th>
                                <th>Lý do</th>
                                <th>Ngày yêu cầu</th>
                                <th>Trạng thái/Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requests}" var="request">
                                <tr>
                                    <td>#${request.id}</td>
                                    <td>${request.fullName}</td>
                                    <td>${request.email}</td>
                                    <td>${request.phoneNumber}</td>
                                    <td>${request.address}</td>
                                    <td>${request.reason}</td>
                                    <td>${request.requestDate}</td>
                                    <td><span class="status status-pending">${request.status}</span>
                                    </td>
                                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                                        <td class="actions">
                                            <form action="updatepending" method="POST" style="display: inline;">
                                                <input type="hidden" name="requestId" value="${request.id}">
                                                <input type="hidden" name="userId" value="${request.userId}">
                                                <button type="submit" name="action" value="approve" class="btn btn-approve">
                                                    <i class="fas fa-check"></i> Chấp nhận
                                                </button>
                                                <button type="button" class="btn btn-reject" 
                                                        onclick="openRejectModal(${request.id}, ${request.userId})">
                                                    <i class="fas fa-times"></i> Từ chối
                                                </button>
                                            </form>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>


        <div id="rejectModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2>Lý do từ chối yêu cầu</h2>
                </div>
                <form id="rejectForm" action="updatepending" method="POST">
                    <input type="hidden" name="requestId" id="rejectRequestId">
                    <input type="hidden" name="userId" id="rejectUserId">
                    <input type="hidden" name="action" value="reject">

                    <div class="form-group">
                        <label for="rejectReason">Lý do từ chối:</label>
                        <textarea id="rejectReason" name="rejectReason" required></textarea>
                    </div>

                    <div class="modal-actions">
                        <button type="button" class="btn" onclick="closeRejectModal()">
                            Hủy
                        </button>
                        <button type="submit" class="btn btn-reject">
                            <i class="fas fa-times"></i> Xác nhận từ chối
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <a href="home">home</a>

        <script>
            function openRejectModal(requestId, userId) {
                console.log('RequestID:', requestId, 'UserID:', userId);
                document.getElementById('rejectModal').style.display = 'flex';
                document.getElementById('rejectRequestId').value = requestId;
                document.getElementById('rejectUserId').value = userId;
            }

            function closeRejectModal() {
                document.getElementById('rejectModal').style.display = 'none';
            }

            // Đóng modal khi click bên ngoài
            window.onclick = function (event) {
                if (event.target === document.getElementById('rejectModal')) {
                    closeRejectModal();
                }
            };
        </script>
    </body>
</html>
