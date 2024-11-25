<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Cho thuê xe máy tại Hà Nội - Dịch vụ thuê xe máy uy tín, giá rẻ">
        <title>Danh sách xe máy cho thuê tại Hà Nội</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="js/addtocart.js"></script>
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #e74c3c;
                --accent-color: #3498db;
                --background-color: #f8f9fa;
                --text-color: #2c3e50;
                --card-shadow: 0 2px 15px rgba(0,0,0,0.1);
                --hover-shadow: 0 5px 25px rgba(0,0,0,0.15);
            }

            body {
                font-family: 'Roboto', sans-serif;
                padding-top: 70px;
                background-color: var(--background-color);
                color: var(--text-color);
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

            /* Sidebar Styling */
            .sidebar {
                position: fixed;
                left: 0;
                top: 70px;
                bottom: 0;
                width: 280px;
                padding: 30px;
                background-color: white;
                border-right: 1px solid rgba(0,0,0,0.1);
                box-shadow: 2px 0 10px rgba(0,0,0,0.05);
                z-index: 1000;
                transition: all 0.3s ease;
            }

            .form-control {
                border-radius: 8px;
                border: 1px solid #dee2e6;
                padding: 12px;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.25);
                border-color: var(--accent-color);
            }

            .btn-outline-success {
                color: var(--accent-color);
                border-color: var(--accent-color);
                border-radius: 8px;
                padding: 10px 20px;
                transition: all 0.3s ease;
            }

            .btn-outline-success:hover {
                background-color: var(--accent-color);
                border-color: var(--accent-color);
                transform: translateY(-2px);
            }

            /* Main Content Styling */
            .container.bike-list {
                padding: 30px;
                margin-left: 280px;
                max-width: calc(100% - 280px);
            }

            .bike-list h3 {
                color: var(--primary-color);
                font-weight: 700;
                margin-bottom: 40px;
                font-size: 2rem;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .bike-card {
                background: white;
                border-radius: 12px;
                border: none;
                box-shadow: var(--card-shadow);
                margin: 15px;
                padding: 15px;
                transition: all 0.3s ease;
            }

            .bike-card:hover {
                transform: translateY(-10px);
                box-shadow: var(--hover-shadow);
            }

            .bike-image {
                border-radius: 8px;
                height: 200px;
                object-fit: cover;
                margin-bottom: 15px;
            }

            .bike-card h5 {
                color: var(--primary-color);
                font-weight: 600;
                margin: 15px 0;
            }

            .bike-card p {
                color: var(--secondary-color);
                font-weight: 500;
                font-size: 1.1rem;
            }

            .btn-detail {
                background-color: var(--secondary-color);
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-detail:hover {
                background-color: #c0392b;
                transform: translateY(-2px);
                color: white;
            }

            /* Cart Styling */
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
                top: -8px;
                right: -8px;
                background-color: var(--secondary-color);
                color: white;
                border-radius: 50%;
                padding: 5px 10px;
                font-size: 12px;
                font-weight: 600;
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            }
            .sidebar {
                position: fixed;
                left: 0;
                top: 70px;
                bottom: 0;
                width: 280px;
                background-color: white;
                border-right: 1px solid rgba(0,0,0,0.1);
                box-shadow: 2px 0 10px rgba(0,0,0,0.05);
                z-index: 1000;
                transition: all 0.3s ease;
                overflow-y: auto;
                padding: 30px;
            }

            .sidebar-content {
                display: flex;
                flex-direction: column;
                height: 100%;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                font-weight: 500;
                margin-bottom: 0.5rem;
            }

            .cart-container {
                margin-top: auto;
                text-align: center;
            }

            .cart-icon {
                width: 30px;
                height: 30px;
                fill: var(--text-color);
                transition: fill 0.3s ease;
            }

            .cart-icon:hover {
                fill: var(--secondary-color);
            }

            .cart-badge {
                position: absolute;
                top: -8px;
                right: -8px;
                background-color: var(--secondary-color);
                color: white;
                border-radius: 50%;
                padding: 3px 6px;
                font-size: 10px;
                font-weight: 600;
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            }

            @media (max-width: 992px) {
                .sidebar {
                    width: 240px;
                }
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    position: static;
                    box-shadow: none;
                    border-right: none;
                    border-bottom: 1px solid rgba(0,0,0,0.1);
                    padding: 20px;
                }
            }

            /* Pagination Styling */
            .pagination {
                margin-top: 40px;
            }

            .page-link {
                color: var(--primary-color);
                padding: 12px 18px;
                margin: 0 5px;
                border-radius: 8px;
                border: none;
                transition: all 0.3s ease;
            }

            .page-link:hover {
                background-color: var(--accent-color);
                color: white;
                transform: translateY(-2px);
            }

            .page-item.active .page-link {
                background-color: var(--accent-color);
                border-color: var(--accent-color);
            }

            /* Footer Styling */
            .footer {
                background-color: var(--primary-color);
                color: white;
                padding: 30px 0;
                margin-top: 50px;
                text-align: center;
                margin-left: 280px;
            }

            /* Responsive Design */
            @media (max-width: 992px) {
                .sidebar {
                    width: 240px;
                }
                .container.bike-list {
                    margin-left: 240px;
                    max-width: calc(100% - 240px);
                }
                .footer {
                    margin-left: 240px;
                }
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    position: static;
                    box-shadow: none;
                    border-right: none;
                    border-bottom: 1px solid rgba(0,0,0,0.1);
                }
                .container.bike-list {
                    margin-left: 0;
                    max-width: 100%;
                    padding: 15px;
                }
                .footer {
                    margin-left: 0;
                }
                .bike-card {
                    margin: 10px 0;
                }
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

            .bike-card {
                animation: fadeIn 0.6s ease-out;
            }
            .bike-card {
                background: white;
                border-radius: 12px;
                border: none;
                box-shadow: var(--card-shadow);
                margin: 15px;
                padding: 0;
                transition: all 0.3s ease;
                overflow: hidden;
            }

            .bike-card:hover {
                transform: translateY(-10px);
                box-shadow: var(--hover-shadow);
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

            .bike-card:hover .bike-image {
                transform: scale(1.1);
            }

            .bike-card-content {
                padding: 20px;
            }

            .bike-card h5 {
                color: var(--primary-color);
                font-weight: 600;
                margin-bottom: 10px;
            }

            .bike-card p {
                color: var(--secondary-color);
                font-weight: 500;
                font-size: 1.1rem;
                margin-bottom: 20px;
            }
            .nav-cart {
                position: relative;
                margin-left: 20px;
            }

            .nav-cart-icon {
                width: 24px;
                height: 24px;
                fill: var(--text-color);
                transition: fill 0.3s ease;
            }

            .nav-cart-icon:hover {
                fill: var(--secondary-color);
            }

            .nav-cart-badge {
                position: absolute;
                top: -8px;
                right: -8px;
                background-color: var(--secondary-color);
                color: white;
                border-radius: 50%;
                padding: 3px 6px;
                font-size: 10px;
                font-weight: 600;
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Đánh giá</a></li>
                        <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="login"><i class="fas fa-sign-in-alt mr-1"></i> Đăng nhập</a></li>
                        </c:if>
                    <li class="nav-cart">
                        <a href="cartDetail">
                            <img class="cart-icon" src="https://res.cloudinary.com/dgeq5yymz/image/upload/f_auto,q_auto/rj9gca4yqvjajh8uhk1a" alt="cart-icon"/>
                            <span class="cart-badge">${sessionScope.quantity}</span>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Sidebar -->
        <div class="sidebar">
            <!-- Filter -->
            <form action="${pageContext.request.contextPath}/listmoto" method="get">
                <select name="priceOrder" class="form-control mb-3" onchange="this.form.submit()">
                    <option value="" disabled selected>Sắp xếp theo giá</option>
                    <option value="asc" <c:if test="${priceOrder == 'asc'}">selected</c:if>>Từ thấp đến cao</option>
                    <option value="desc" <c:if test="${priceOrder == 'desc'}">selected</c:if>>Từ cao đến thấp</option>
                    </select>
                </form>

                <!-- Search -->
                <form action="${pageContext.request.contextPath}/listmoto" method="get">
                <div class="form-group">
                    <input class="form-control mb-2" type="search" placeholder="Tìm kiếm xe máy" name="search" value="${searchTerm}">
                    <button class="btn btn-outline-success btn-block mb-2" type="submit">Tìm kiếm</button>
                    <input class="btn btn-outline-success btn-block" type="button" value="Filter" onclick="window.location.href = 'search'">
                </div>
            </form>


        </div>

        <!-- Main Content -->
        <div class="container bike-list">
            <h3>DANH MỤC XE CHO THUÊ TẠI HÀ NỘI</h3>

            <div class="row justify-content-center">
                <c:forEach var="motorbike" items="${motorbikes}">
                    <div class="col-md-4 bike-card">
                        <div class="bike-image-container">
                            <img src="${motorbike.imageUrl}" alt="${motorbike.brand} ${motorbike.model}" class="bike-image">
                        </div>
                        <div class="bike-card-content">
                            <h5>${motorbike.brand} ${motorbike.model}</h5>
                            <p>Từ ${motorbike.dailyRate}đ/ngày</p>
                            <button class="btn btn-detail" onclick="showDetails(${motorbike.motorbikeId})">XEM CHI TIẾT</button>
                            <button class="btn btn-detail" onclick="addToCart(${motorbike.motorbikeId})">THÊM VÀO GIỎ</button>
                            <div id="${motorbike.motorbikeId}"></div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty motorbikes}">
                <h4 class="text-center">Không tìm thấy xe máy nào phù hợp với tìm kiếm của bạn.</h4>
            </c:if>

            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage - 1}&search=${searchTerm}&priceOrder=${priceOrder}">&laquo;</a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${currentPage == i}">
                                <li class="page-item active"><span class="page-link">${i}</span></li>
                                </c:when>
                                <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="?page=${i}&search=${searchTerm}&priceOrder=${priceOrder}">${i}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage + 1}&search=${searchTerm}&priceOrder=${priceOrder}">&raquo;</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <footer class="footer">
            <p>&copy; 2024 Motorbike Rental. All rights reserved.</p>
        </footer>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
                                function showDetails(motorbikeId) {
                                    window.location.href = '${pageContext.request.contextPath}/motordetail?id=' + motorbikeId;
                                }
        </script>

    </body>
</html>