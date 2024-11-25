<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
    Document   : managepromotion
    Created on : Nov 6, 2024, 11:42:05 AM
    Author     : Nitro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
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
            .sidebar {
                min-width: 250px;
                background-color: #f8f9fa;
                color: #343a40;
                height: 100vh;
                position: fixed;
                top: 56px;
                left: 0;
                padding: 15px;
                transition: transform 0.3s ease;
                z-index: 1000;
            }
            .sidebar h2 {
                color: #5bc0de;
                margin-bottom: 20px;
            }
            .sidebar .nav-link {
                color: #6c757d;
            }
            .sidebar .nav-link:hover {
                color: #5bc0de;
            }
            .promotion-layout {
                display: grid;
                gap: 20px;
                max-width: 1700px;
                margin: 30px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                margin-top: 100px;
                margin-left: 300px;
            }
            body {
                background-color: #f4f4f9;
                color: #333;
                line-height: 1.6;
                padding: 20px;
            }
            h2 {
                margin-bottom: 10px;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .action-container {
                display: flex;
                gap: 10px;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            .search-box input {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 200px;
            }
            .searchBtn, .action-container button {
                padding: 10px 20px;
                background-color: #007bff;
                border: none;
                color: #fff;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .searchBtn:hover, .action-container button:hover {
                background-color: #0056b3;
            }
            .table-container {
                overflow-x: auto;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }
            th, td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ddd;
            }
            th {
                background-color: #f2f2f2;
                color: #333;
                font-weight: bold;
            }
            .status-btn,.action-btn {
                padding: 8px 12px;
                background-color: #28a745;
                border: none;
                color: #fff;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .action-btn {
                background-color: #f4a623;
                margin-bottom: 5px
            }

            .status-btn:hover {
                background-color: #218838;
            }

            .status-btn.disable {
                background-color: #dc3545;
            }

            .status-btn.disable:hover {
                background-color: #c82333;
            }
            .pagination {
                display: flex;
                justify-content: center;
                padding: 10px;
            }
            .pagination a {
                margin: 0 5px;
                padding: 8px 12px;
                text-decoration: none;
                color: #007bff;
                border: 1px solid #007bff;
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }
            .pagination a:hover, .pagination a.active {
                background-color: #007bff;
                color: #fff;
            }
            #overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 999;
            }
            .addNew-container {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                width: 500px;
                max-width: 90%;
                max-height: 85vh;
                overflow-y: auto;
            }
            .addNew-container form div {
                margin-bottom: 10px;
            }
            .addNew-container label {
                font-weight: bold;
            }
            .addNew-container input[type="text"],
            .addNew-container input[type="number"],
            .addNew-container input[type="date"],
            .addNew-container textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .addNew-container button {
                margin-top: 10px;
                padding: 10px 15px;
                border: none;
                color: #fff;
                background-color: #007bff;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .addNew-container button:hover {
                background-color: #0056b3;
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
        <div class="promotion-layout">
            <h2>Danh sách Mã giảm giá</h2>
            <div class="action-container">
                <form style="display: flex; gap: 10px" action="promotion" method="get">
                    <div class="search-box">
                        <input type="text" name="txtSearch" value="${requestScope.search}" placeholder="Tìm kiếm...">
                    </div>
                    <div class="">
                        <input class="searchBtn" type="submit" name="name" value="Tìm kiếm">
                    </div>
                </form>
                <div>
                    <button onclick="showAddNewPopup()">Thêm</button>
                </div>
            </div>
            <div class="table-container">
                <table id="table" border="1">
                    <thead>
                        <tr>
                            <th style="display: none"></th>
                            <th>Tên giảm giá</th>
                            <th>Mã giảm giá</th>
                            <th>Mô tả</th>
                            <th>Tỉ lệ giảm(%)</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                            <th>Số lượng</th>
                            <th>Đã sử dụng</th>
                            <th>Đơn hàng tối thiểu</th>
                            <th>Trạng thái</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.promotions}" var="p" varStatus="loop">
                            <tr>
                                <td style="display: none">${p.promotionId}</td>
                                <td>${p.name}</td>
                                <td>${p.promoCode}</td>
                                <td>${p.description}</td>
                                <td>${p.discountRate}</td>
                                <td>${p.startDate}</td>
                                <td id="endDate${p.promotionId}">${p.endDate}</td>
                                <td id="maxUse${p.promotionId}">${p.maxUses}</td>
                                <td id="currentUse${p.promotionId}">${p.currentUses}</td>
                                <td  amount="${p.amount}"><fmt:formatNumber value="${p.amount}" maxFractionDigits="0"/> VND</td>
                                <td id="status${p.promotionId}">
                                    ${p.status}
                                </td>
                                <td>
                                    <button class="action-btn" onclick="showEditPoup(${loop.index} + 1)">Edit</button>

                                    <c:if test="${p.status eq 'disable'}">
                                        <button class="status-btn disable" id="disable-btn${p.promotionId}" value="${p.promotionId}" style="display: none">Disable</button>
                                        <button class="status-btn enable" id="enable-btn${p.promotionId}" value="${p.promotionId}" style="display: block">Enable</button>
                                    </c:if>
                                    <c:if test="${p.status eq 'enable'}">
                                        <button class="status-btn disable" id="disable-btn${p.promotionId}" value="${p.promotionId}" style="display: block">Disable</button>
                                        <button class="status-btn enable" id="enable-btn${p.promotionId}" value="${p.promotionId}" style="display: none">Enable</button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="pagination">
                <c:if test="${requestScope.currentPage > 1}">
                    <a href="?page=${requestScope.currentPage - 1}&status=${requestScope.status}&txtSearch=${requestScope.search}&startDate=${requestScope.startDate}&endDate=${requestScope.endDate}" aria-label="Previous">&laquo;</a>
                </c:if>

                <c:forEach begin="1" end="${requestScope.totalPage}" var="i">
                    <c:if test="${requestScope.currentPage == i}">
                        <a class="active">${i}</a>
                    </c:if>
                    <c:if test="${requestScope.currentPage != i}">
                        <a href="?page=${i}&status=${requestScope.status}&txtSearch=${requestScope.search}&startDate=${requestScope.startDate}&endDate=${requestScope.endDate}">${i}</a>
                    </c:if>
                </c:forEach>

                <c:if test="${requestScope.currentPage < requestScope.totalPage}">
                    <a href="?page=${requestScope.currentPage + 1}&status=${requestScope.status}&txtSearch=${requestScope.search}&startDate=${requestScope.startDate}&endDate=${requestScope.endDate}" aria-label="Next">&raquo;</a>
                </c:if>
            </div>
        </div>
        <div id="overlay"></div>
        <div class="addNew-container">
            <h2 id="title">Thêm Khuyến Mãi Mới</h2>
            <form id="addNew-form" action="promotion" method="get">
                <div>
                    <label for="name">Tên Khuyến Mãi:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div>
                    <label for="code">Mã Khuyến Mãi:</label>
                    <input type="text" id="code" name="code" required>
                </div>
                <div>
                    <label for="description">Mô Tả:</label>
                    <textarea id="description" name="description" rows="3"></textarea>
                </div>
                <div>
                    <label for="discount_rate">Tỷ Lệ Giảm Giá (%):</label>
                    <input type="number" id="discount_rate" name="discount_rate" min="0" max="100" required>
                </div>
                <div>
                    <label for="start_date">Ngày Bắt Đầu:</label>
                    <input type="date" id="start_date" name="start_date" required>
                </div>
                <div>
                    <label for="end_date">Ngày Kết Thúc:</label>
                    <input type="date" id="end_date" name="end_date" required>
                </div>
                <div>
                    <label for="max_use">Số Lần Sử Dụng Tối Đa:</label>
                    <input type="number" id="max_use" name="max_use" min="1" required>
                </div>
                <div>
                    <label for="min_amount">Số Tiền Tối Thiểu:</label>
                    <input type="number" id="min_amount" name="min_amount" min="0" required>
                </div>
                <input id="action" type="hidden" value="add" name="action">
                <input id="promotionId" type="hidden" value="" name="promotionId">
                <button id="addNew-btn" type="submit">Thêm Khuyến Mãi</button>

            </form>
            <button onclick="hideAddNewPopup()">Đóng</button>
        </div>
        <script>
            function showAddNewPopup() {
                $("#title").empty();
                $("#title").text("Thêm Khuyến Mãi Mới");
                $("#addNew-btn").empty();
                $("#addNew-btn").text("Thêm Khuyến Mãi");
                $("#name").val("");
                $("#code").val("");
                $("#description").val("");
                $("#discount_rate").val("");
                $("#start_date").val("");
                $("#end_date").val("");
                $("#max_use").val("");
                $("#min_amount").val("");
                $("#action").val("add");
                $("#promotionId").val("");
                $(".addNew-container").show();
                $("#overlay").show();
            }
            function hideAddNewPopup() {
                $(".addNew-container").hide();
                $("#overlay").hide();
            }
            function showEditPoup(index) {
                var id = document.getElementById("table").rows[index].cells.item(0).innerHTML;
                var name = document.getElementById("table").rows[index].cells.item(1).innerHTML;
                var code = document.getElementById("table").rows[index].cells.item(2).innerHTML;
                var description = document.getElementById("table").rows[index].cells.item(3).innerHTML;
                var discount = document.getElementById("table").rows[index].cells.item(4).innerHTML;
                var startDate = document.getElementById("table").rows[index].cells.item(5).innerHTML;
                var endDate = document.getElementById("table").rows[index].cells.item(6).innerHTML;
                var max_use = document.getElementById("table").rows[index].cells.item(7).innerHTML;
                var min_amount = document.getElementById("table").rows[index].cells.item(9).getAttribute("amount");
                $("#name").val(name);
                $("#code").val(code);
                $("#description").val(description);
                $("#discount_rate").val(discount);
                $("#start_date").val(startDate);
                $("#end_date").val(endDate);
                $("#max_use").val(max_use);
                $("#min_amount").val(min_amount);
                $("#title").empty();
                $("#title").text("Cập nhật khuyến mãi");
                $("#addNew-btn").empty();
                $("#addNew-btn").text("Cập nhật");
                $("#action").val("update");
                $("#promotionId").val(id);
                $(".addNew-container").show();
                $("#overlay").show();
            }
            $(document).ready(function () {
                $(".status-btn").on('click', function () {
                    var id = $(this).val();
                    var status;
                    if ($("#status" + id).text().trim() === "enable") {
                        $("#status" + id).empty();
                        $("#status" + id).text("disable");
                        $("#disable-btn" + id).hide();
                        $("#enable-btn" + id).show();
                        status = "disable";
                    } else if ($("#status" + id).text().trim() === "disable") {
                        var endDateTxt = $("#endDate" + id).text().trim();
                        var today = new Date();
                        var endDate = new Date(endDateTxt);
                        if (endDate < today) {
                            alert("Mã giảm giá này đã quá hạn");
                            return;
                        }
                        var maxUse = $("#maxUse" + id).text().trim();
                        var currentUse = $("#currentUse" + id).text().trim();
                        if (currentUse >= maxUse) {
                            alert("Mã giảm giá này đã dược sử dụng hết");
                            return;
                        }
                        $("#status" + id).empty();
                        $("#status" + id).text("enable");
                        $("#enable-btn" + id).hide();
                        $("#disable-btn" + id).show();
                        status = "enable";
                    }
                    $.ajax({
                        url: "/Motorbike_v2.0/promotion",
                        type: "post",
                        data: {
                            pid: id,
                            status: status
                        },
                        success: function () {
                        },
                        error: function () {
                        }
                    });
                });
            });
        </script>
    </body>
</html>
