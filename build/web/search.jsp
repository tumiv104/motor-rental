<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Motorbike Rental - Advanced Search</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            :root {
                --primary-color: #ff4d4d;
                --secondary-color: #333;
                --light-gray: #f8f9fa;
            }

            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background-color: #f5f5f5;
            }

            .navbar {
                background-color: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 1rem 0;
            }

            .navbar-brand {
                font-size: 1.5rem;
                font-weight: bold;
                color: var(--primary-color) !important;
            }

            .nav-link {
                color: var(--secondary-color) !important;
                font-weight: 500;
                margin: 0 1rem;
                transition: color 0.3s;
            }

            .nav-link:hover {
                color: var(--primary-color) !important;
            }

            .search-container {
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                padding: 2rem;
                margin: 2rem 0;
            }

            .filter-form select {
                width: 100%;
                padding: 0.5rem;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-bottom: 1rem;
                background-color: white;
            }

            .filter-form label {
                font-weight: 500;
                color: var(--secondary-color);
                margin-bottom: 0.5rem;
            }

            .filter-btn {
                background-color: var(--primary-color);
                color: white;
                padding: 0.75rem 2rem;
                border: none;
                border-radius: 5px;
                font-weight: 500;
                transition: all 0.3s;
                width: 100%;
            }

            .filter-btn:hover {
                background-color: #ff3333;
                transform: translateY(-2px);
            }

            .bike-card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                padding: 1rem;
                margin-bottom: 2rem;
                transition: transform 0.3s;
            }

            .bike-card:hover {
                transform: translateY(-5px);
            }

            .bike-card img {
                border-radius: 8px;
                margin-bottom: 1rem;
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .bike-card h5 {
                color: var(--secondary-color);
                font-weight: 600;
            }

            .bike-card p {
                color: var(--primary-color);
                font-weight: 500;
                font-size: 1.1rem;
            }

            .btn-detail {
                background-color: var(--primary-color);
                color: white;
                padding: 0.5rem 1.5rem;
                border: none;
                border-radius: 5px;
                transition: all 0.3s;
            }

            .btn-detail:hover {
                background-color: #ff3333;
                transform: scale(1.05);
            }

            .pagination .page-link {
                color: var(--secondary-color);
            }

            .pagination .active .page-link {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .footer {
                background-color: var(--secondary-color);
                color: white;
                padding: 2rem 0;
                margin-top: 3rem;
            }

            .footer-content {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .social-links a {
                color: white;
                margin: 0 10px;
                font-size: 1.2rem;
                transition: color 0.3s;
            }

            .social-links a:hover {
                color: var(--primary-color);
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <i class="fas fa-motorcycle"></i> MotorRent
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="home"><i class="fas fa-home"></i> Trang chủ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listmoto"><i class="fas fa-list mr-1"></i>Danh sách xe máy</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"><i class="fas fa-gift mr-1"></i> Khuyến mãi</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"><i class="fas fa-phone"></i> Liên hệ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="profile"><i class="fas fa-user mr-1"></i> Hồ sơ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="createmotorbyuser"><i class="fas fa-motorcycle mr-2"></i> Cho thuê xe</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="websitereview"><i class="fas fa-star mr-1"></i>  Đánh giá</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="container">
            <div class="row">
                <!-- Filter Section -->
                <div class="col-md-3">
                    <div class="search-container">
                        <h4 class="text-center mb-4">Tìm kiếm nâng cao</h4>
                        <form action="search" method="POST" class="filter-form">
                            <div class="form-group">
                                <label for="brand"><i class="fas fa-tag"></i> Thương hiệu:</label>
                                <select name="brand" id="brand">
                                    <option value="">Tất cả</option>
                                    <c:forEach var="brands" items="${requestScope.brands}">
                                        <option value="${brands}" <c:if test="${param.brand == brands}">selected</c:if>>${brands}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="year"><i class="fas fa-calendar"></i> Năm:</label>
                                <select name="year" id="year">
                                    <option value="">Tất cả</option>
                                    <c:forEach var="years" items="${requestScope.years}">
                                        <option value="${years}" <c:if test="${param.year == years}">selected</c:if>>${years}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="daily_rate"><i class="fas fa-dollar-sign"></i> Giá thuê:</label>
                                <select name="daily_rate" id="daily_rate">
                                    <option value="">Tất cả</option>
                                    <c:forEach var="daily_rates" items="${requestScope.daily_rates}">
                                        <option value="${daily_rates}" <c:if test="${param.daily_rate == daily_rates}">selected</c:if>>${daily_rates}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="type"><i class="fas fa-motorcycle"></i> Loại xe:</label>
                                <select name="type" id="type">
                                    <option value="">Tất cả</option>
                                    <c:forEach var="types" items="${requestScope.types}">
                                        <option value="${types.typeId}" <c:if test="${param.type == types.typeId}">selected</c:if>>${types.typeName}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="color"><i class="fas fa-paint-brush"></i> Màu sắc:</label>
                                <select name="color" id="color">
                                    <option value="">Tất cả</option>
                                    <c:forEach var="colors" items="${requestScope.colors}">
                                        <option value="${colors}" <c:if test="${param.color == colors}">selected</c:if>>${colors}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="engine_size"><i class="fas fa-tachometer-alt"></i> Dung tích:</label>
                                <select name="engine_size" id="engine_size">
                                    <option value="">Tất cả</option>
                                    <c:forEach var="engine_sizes" items="${requestScope.engine_sizes}">
                                        <option value="${engine_sizes}" <c:if test="${param.engine_size == engine_sizes}">selected</c:if>>${engine_sizes}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="fuel_type"><i class="fas fa-gas-pump"></i> Loại nhiên liệu:</label>
                                <select name="fuel_type" id="fuel_type">
                                    <option value="">Tất cả</option>
                                    <c:forEach var="fuel_types" items="${requestScope.fuel_types}">
                                        <option value="${fuel_types}" <c:if test="${param.fuel_type == fuel_types}">selected</c:if>>${fuel_types}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <button type="submit" class="filter-btn">
                                <i class="fas fa-search"></i> Tìm kiếm
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Motorbike List -->
                <div class="col-md-9">
                    <c:if test="${requestScope.motorbikes ne null}">
                        <div class="row">
                            <c:forEach items="${requestScope.motorbikes}" var="m">
                                <div class="col-md-4">
                                    <div class="bike-card">
                                        <img src="${m.imageUrl}" alt="${m.brand} ${m.model}">
                                        <h5>${m.brand} ${m.model}</h5>
                                        <p><i class="fas fa-tag"></i> ${m.dailyRate}đ/ngày</p>
                                        <button class="btn btn-detail w-100" onclick="showDetails(${m.motorbikeId})">
                                            <i class="fas fa-info-circle"></i> Xem chi tiết
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}&brand=${brand}&year=${year}&daily_rate=${daily_rate}&type=${type}&color=${color}&engine_size=${engine_size}&fuel_type=${fuel_type}">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${requestScope.totalPage}" var="i">
                                    <c:choose>
                                        <c:when test="${currentPage == i}">
                                            <li class="page-item active">
                                                <span class="page-link">${i}</span>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${i}&brand=${brand}&year=${year}&daily_rate=${daily_rate}&type=${type}&color=${color}&engine_size=${engine_size}&fuel_type=${fuel_type}">${i}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}&brand=${brand}&year=${year}&daily_rate=${daily_rate}&type=${type}&color=${color}&engine_size=${engine_size}&fuel_type=${fuel_type}">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="footer-content">
                    <div>
                        <h5>MotorRent</h5>
                        <p>Dịch vụ cho thuê xe máy uy tín</p>
                    </div>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
            </div>
        </footer>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                            function showDetails(motorbikeId) {
                                                window.location.href = '${pageContext.request.contextPath}/motordetail?id=' + motorbikeId;
                                            }

                                            // Thêm hiệu ứng smooth scroll
                                            $(document).ready(function () {
                                                // Smooth scroll cho các liên kết
                                                $('a[href^="#"]').on('click', function (e) {
                                                    e.preventDefault();
                                                    var target = this.hash;
                                                    var $target = $(target);
                                                    $('html, body').animate({
                                                        'scrollTop': $target.offset().top
                                                    }, 1000, 'swing');
                                                });

                                                // Hiệu ứng hover cho card
                                                $('.bike-card').hover(
                                                        function () {
                                                            $(this).addClass('shadow-lg');
                                                        },
                                                        function () {
                                                            $(this).removeClass('shadow-lg');
                                                        }
                                                );

                                                // Thêm loading spinner khi submit form
                                                $('.filter-form').on('submit', function () {
                                                    $('.filter-btn').html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Đang tìm kiếm...');
                                                });

                                                // Hiệu ứng active cho navbar
                                                $('.nav-link').on('click', function () {
                                                    $('.nav-link').removeClass('active');
                                                    $(this).addClass('active');
                                                });
                                            });
        </script>
    </body>
</html>