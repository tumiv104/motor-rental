<%-- 
    Document   : managebooking
    Created on : Oct 24, 2024, 10:32:10 AM
    Author     : Nitro
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f3f7;
                color: #333;
                display: flex;
                flex-direction: column;
            }
            .main-layout {
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
            .tabs {
                display: flex;
                border-bottom: 2px solid #eee;
                margin: 20px;
                justify-content: center;
                margin-top: 60px;
                margin-right: 0px;
            }
            .tab {
                padding: 10px 15px;
                cursor: pointer;
                font-weight: bold;
                color: #333;
            }
            .tab.active {
                color: red;
                border-bottom: 3px solid red;
            }
            .search-layout {
                display: flex;
                align-items: flex-end;
                gap: 10px;
                padding: 10px;
                margin-left: 200px;
            }
            .search-layout input[type="text"] {
                padding: 10px 15px;
                border-radius: 30px;
                border: 1px solid #ddd;
                background-color: #f4f4f4;
                outline: none;
                width: 200px;
                font-size: 16px;
            }
            .date-range {
                display: flex;
                align-items: center;
                gap: 5px;
                padding: 10px 15px;
                border-radius: 30px;
                background-color: #f4f4f4;
                color: #555;
                border: 1px solid #ddd;
                font-size: 16px;
                height: 45px;
            }
            .date-range input[type="date"] {
                border: none;
                outline: none;
                background: transparent;
                font-size: 16px;
                color: #555;
            }
            .searchBtn {
                padding: 10px 15px;
                font-size: 0.9em;
                border: none;
                border-radius: 20px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin: 5px;
                font-weight: bold;
                color: white;
                background-color: #4a90e2;
            }
            .table-container {
                overflow-x: auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 10px;
            }
            .table-container h2 {
                color: #4a90e2;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                margin: 0 auto;
                border-collapse: collapse;
                border: none;
            }
            th, td {
                padding: 6px 8px;
                text-align: center;
            }
            th {
                background-color: #f7f7f7;
                color: #555;
                font-weight: bold;
            }
            td {
                font-size: 0.9em;
                color: #555;
            }
            .status, .payment_status, .deposit_status {
                width: 150px;
                padding: 8px 12px;
                border: none;
                border-radius: 20px;
                font-size: 0.9em;
                font-weight: bold;
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                text-align: center;
                cursor: pointer;
                background-image: url("data:image/svg+xml,%3Csvg width='10' height='5' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M0 0l5 5 5-5z' fill='%234a90e2'/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 10px;
            }
            .status_booked,
            .deposit_status option[value="deposited"], .deposit_status_deposited {
                color: #4a90e2;
                background-color: #e6f1fd;
            }
            .status option[value="renting"], .status_renting,
            .payment_status_notyet,
            .deposit_status_notyet {
                color: #f5a623;
                background-color: #fff5e1;
                background-image: url("data:image/svg+xml,%3Csvg width='10' height='5' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M0 0l5 5 5-5z' fill='%23f5a623'/%3E%3C/svg%3E");
            }
            .status option[value="completed"], .status_completed,
            .payment_status option[value="paid"], .payment_status_paid,
            .deposit_status option[value="refunded"], .deposit_status_refunded {
                color: #27ae60;
                background-color: #e1f7e6;
                background-image: url("data:image/svg+xml,%3Csvg width='10' height='5' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M0 0l5 5 5-5z' fill='%2327ae60'/%3E%3C/svg%3E");
            }
            .status_cancel {
                background-color: #e74c3c;
                display: inline-flex;
                align-items: center;
                padding: 8px 16px;
                border-radius: 20px;
                font-weight: bold;
                font-size: 14px;
                color: #ffffff;
                cursor: default;
            }
            .status:focus {
                outline: none;
            }
            button {
                padding: 10px 15px;
                font-size: 0.9em;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin: 5px;
            }
            .btn-cancel {
                background-color: #e74c3c;
                color: #fff;
            }
            .btn-cancel:hover {
                background-color: #c0392b;
            }
            .btn-detail {
                background-color: #3498db;
                color: #fff;
            }
            .btn-detail:hover {
                background-color: #2980b9;
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
            .popup {
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
                width: 600px;
                max-width: 90%;
                max-height: 65vh;
                overflow-y: auto;
            }
            .popup h3 {
                font-size: 1.2em;
                color: #4a90e2;
                margin-bottom: 20px;
                text-align: center;
            }
            .popup textarea {
                width: 100%;
                resize: none;
                border-radius: 5px;
                padding: 10px;
                border: 1px solid #ddd;
                font-size: 1em;
                margin-top: 10px;
            }
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.8);
                justify-content: center;
                align-items: center;
            }
            .modal img {
                max-width: 90%;
                max-height: 90%;
                border-radius: 10px;
            }
            .close {
                position: absolute;
                top: 20px;
                right: 30px;
                color: white;
                font-size: 30px;
                cursor: pointer;
            }
            @media (max-width: 768px) {
                .main-layout {
                    grid-template-columns: 1fr;
                }

                table, th, td {
                    font-size: 0.8em;
                }

                .popup {
                    width: 90%;
                }

                .navbar ul {
                    flex-direction: column;
                }
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
            .pagination a:hover {
                background-color: #007bff;
                color: white;
            }
            .pagination a.active {
                background-color: #007bff;
                color: white;
                border: 1px solid #007bff;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light fixed-top">
            <a class="navbar-brand" href="home">Motorbike Rental</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="listmoto">Danh sách xe máy</a></li>
                    <li class="nav-item"><a class="nav-link" href="ai.jsp">Khuyến mãi</a></li>
                    <li class="nav-item"><a class="nav-link" href="manageuser">Liên hệ</a></li>
                    <li class="nav-item"><a class="nav-link" href="profile">Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview">Review Website</a></li>
                        <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="login">Đăng nhập</a></li>
                        </c:if>
                </ul>
            </div>
        </nav>
        <div class="sidebar">
            <h2>Quản Lý</h2>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="admindashboard"><i class="fas fa-tachometer-alt"></i> Admin Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="managebookinglist"><i class="fas fa-list-alt"></i> Quản lý đơn hàng</a></li>
                <li class="nav-item"><a class="nav-link" href="manageuser"><i class="fas fa-users-cog"></i> Quản lý người dùng</a></li>
                <li class="nav-item"><a class="nav-link" href="viewmotorbike"><i class="fas fa-motorcycle"></i> Quản lý xe máy</a></li>
                <li class="nav-item"><a class="nav-link" href="updatepending"><i class="fas fa-motorcycle"></i> Quản lý nâng cấp tài khoản</a></li>
                <li class="nav-item"><a class="nav-link" href="promotion"><i class="fas fa-chart-bar"></i> Quản lí mã giảm giá</a></li>
                <li class="nav-item"><a class="nav-link" href="statistics"><i class="fas fa-chart-bar"></i> Thống kê</a></li>
                
            </ul>
        </div>
        <div id="overlay"></div>

        <div id="cancelPopup" class="popup">
            <h3>Xác nhận hủy </h3>
            <label>Lí do hủy:</label>
            <textarea id="cancelReason" rows="4"></textarea>
            <button id="confirmCancelBtn" class="btn-cancel">Xác nhận</button>
            <button id="closePopupBtn" class="btn-detail">Đóng</button>
        </div>

        <div id="addFeePopup" class="popup">
            <h3>Thêm chi phí phát sinh </h3>
            <label>Lí do phát sinh:</label>
            <textarea id="additionFeeReason" rows="4"></textarea>
            <label>Số tiền phát sinh:</label>
            <input type="text" id="addition_amount"/>
            <button id="confirmAddFeeBtn" class="btn-cancel">Xác nhận</button>
            <button id="closeAddFeePopupBtn" class="btn-detail">Đóng</button>
        </div>

        <div id="detailPopup" class="popup">
            <div id="detailContent"></div>
            <button id="closeDetailPopupBtn" class="btn-detail">Đóng</button>
        </div>

        <div id="addFeeDetailPopup" class="popup">
            <div id="addFeeContent"></div>
            <button id="closeAddFeeDetailPopupBtn" class="btn-detail">Đóng</button>
            <button class="btn-cancel" id="addFeeBtn">Thêm</button>
        </div>

        <div id="changePopup" class="popup">
            <div id="changeContent"></div>
            <button id="closeChangePopupBtn" class="btn-detail">Đóng</button>
        </div>

        <div class="modal" id="modal">
            <span class="close" onclick="closeModal()">&times;</span>
            <img id="modalImage" src="" alt="Large Product Image">
        </div>


        <div class="main-layout">

            <!-- Phần bảng đơn hàng -->
            <div class="table-container">
                <h2>Danh sách Đơn hàng</h2>
                <div class="tabs">
                    <div class="tab ${requestScope.status == '' ? 'active' : ''}" onclick="filterBooking('')">TẤT CẢ</div>
                    <div class="tab ${requestScope.status == 'booked' ? 'active' : ''}" onclick="filterBooking('booked')">ĐÃ ĐẶT</div>
                    <div class="tab ${requestScope.status == 'renting' ? 'active' : ''}" onclick="filterBooking('renting')">ĐANG THUÊ</div>
                    <div class="tab ${requestScope.status == 'completed' ? 'active' : ''}" onclick="filterBooking('completed')">HOÀN THÀNH</div>
                    <div class="tab ${requestScope.status == 'cancel' ? 'active' : ''}" onclick="filterBooking('cancel')">ĐÃ HUỶ</div>
                    <div class="search-layout">
                        <form style="display: flex; gap: 10px" action="managebookinglist" method="get">
                            <input type="hidden" name="status" value="${requestScope.status}">
                            <div class="search-box">
                                <input type="text" name="txtSearch" value="${requestScope.search}" placeholder="Tìm kiếm...">
                            </div>
                            <div class="date-range">
                                <input type="date" name="startDate" value="${requestScope.startDate}"> - <input type="date" name="endDate" value="${requestScope.endDate}">
                            </div>
                            <div class="">
                                <input class="searchBtn" type="submit" name="name" value="Tìm kiếm">
                            </div>
                        </form>
                    </div>
                </div>

                <table border="1">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Mã đơn hàng</th>
                            <th>Khách hàng</th>
                            <th>Ngày tạo</th>
                            <th>Trạng thái</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái thanh toán</th>
                            <th>Tiền cọc</th>
                            <th>Tình trạng cọc</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.list}" var="b" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${b.key.code}</td> 
                                <td>${b.key.name}</td> 
                                <td><fmt:formatDate value="${b.key.createdAt}" pattern="dd/MM/yyyy"/></td>
                                <td id="booking_status${b.key.bookingId}">
                                    <c:if test="${b.key.status ne 'cancel'}">
                                        <select class="status" name="status" id="${b.key.bookingId}">
                                            <c:if test="${b.key.status ne 'renting' && b.key.status ne 'completed'}">
                                                <option value="booked" <c:if test="${b.key.status == 'booked'}">selected</c:if>>Đã đặt</option>
                                            </c:if>
                                            <c:if test="${b.key.status ne 'completed'}">
                                                <option value="renting" <c:if test="${b.key.status == 'renting'}">selected</c:if>>Đang thuê</option>
                                            </c:if>
                                            <c:if test="${b.key.status ne 'booked'}">
                                                <option value="completed">Đã hoàn thành</option>
                                            </c:if>
                                        </select>
                                    </c:if>
                                    <c:if test="${b.key.status eq 'cancel'}"><div class="status_cancel">Đã hủy</div></c:if>
                                    </td>
                                    <td><fmt:formatNumber value="${b.key.totalCost}" maxFractionDigits="0"/> VND</td>
                                <td>
                                    <select class="payment_status" name="payment_status" id="payment${b.value.paymentId}">
                                        <c:if test="${b.value.payment_status ne 'paid'}">
                                            <option value="notyet" <c:if test="${b.value.payment_status == 'notyet'}">selected</c:if>>Chưa thanh toán</option>
                                        </c:if>
                                        <option value="paid" <c:if test="${b.value.payment_status == 'paid'}">selected</c:if>>Đã thanh toán</option>
                                        </select>
                                    </td>
                                    <td><fmt:formatNumber value="${b.value.deposit_amount}" maxFractionDigits="0"/> VND</td>
                                <td>
                                    <select class="deposit_status" name="deposit_status" id="deposit${b.value.paymentId}">
                                        <c:if test="${b.value.deposit_status ne 'deposited' && b.value.deposit_status ne 'refunded'}">
                                            <option value="notyet" <c:if test="${b.value.deposit_status == 'notyet'}">selected</c:if>>Chưa cọc</option>
                                        </c:if>
                                        <c:if test="${b.value.deposit_status ne 'refunded'}">
                                            <option value="deposited" <c:if test="${b.value.deposit_status == 'deposited'}">selected</c:if>>Đã cọc</option>
                                        </c:if>
                                        <c:if test="${b.value.deposit_status ne 'notyet'}">
                                            <option value="refunded" <c:if test="${b.value.deposit_status == 'refunded'}">selected</c:if>>Đã hoàn trả</option>
                                        </c:if>
                                    </select>
                                </td>
                                <td style="text-align: left;">
                                    <button class="showdetail" value="${b.key.bookingId}">Chi tiết</button>
                                    <button class="checkMotoBtn" id="checkMotoBtn${b.key.bookingId}" value="${b.key.returnTime.time}" style="display:none;" onclick="window.location.href = 'checkmotorbikechange?bid=${b.key.bookingId}'">Kiểm Tra Xe</button>
                                    <button class="showAdditionFee" value="${b.key.bookingId}">Phí phát sinh</button>
                                    <c:if test="${b.key.status eq 'booked'}">
                                        <button id="cancel${b.key.bookingId}" onclick="showCancelPopup(${b.key.bookingId})">Hủy</button>
                                    </c:if>
                                    <c:if test="${b.key.status ne 'booked'}">
                                        <button class="showChangeDetail" value="${b.key.bookingId}">Thay đổi của xe</button>
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
        <script>
            let bookingIdToCancel = null;
            let bookingIdToAddFee = null;

            function filterBooking(status) {
                window.location.href = 'managebookinglist?status=' + status;
            }

            function showCancelPopup(bookingId) {
                bookingIdToCancel = bookingId;
                $('#cancelPopup').show();
                $('#overlay').show();
            }

            function closePopup() {
                $('#cancelPopup').hide();
                $('#overlay').hide();
                $('#cancelReason').val("");
            }

            function closeDetailPopup() {
                $('#detailPopup').hide();
                $('#overlay').hide();
            }

            function closeChangePopup() {
                $('#changePopup').hide();
                $('#overlay').hide();
            }

            function closeAddFeeDetailPopup() {
                $('#addFeeDetailPopup').hide();
                $('#overlay').hide();
            }

            function openModal(src) {
                document.getElementById('modalImage').src = src;
                document.getElementById('modal').style.display = 'flex';
            }

            function closeModal() {
                document.getElementById('modal').style.display = 'none';
            }

            $(document).ready(function () {
                $('.status').each(function () {
                    if ($(this).val() === "booked") {
                        $(this).addClass("status_booked");
                    }
                    if ($(this).val() === "renting") {
                        $(this).addClass("status_renting");
                    }
                    if ($(this).val() === "completed") {
                        $(this).addClass("status_completed");
                    }
                });

                $('.payment_status').each(function () {
                    if ($(this).val() === "notyet") {
                        $(this).addClass("payment_status_notyet");
                    }
                    if ($(this).val() === "paid") {
                        $(this).addClass("payment_status_paid");
                    }
                });

                $('.deposit_status').each(function () {
                    if ($(this).val() === "notyet") {
                        $(this).addClass("deposit_status_notyet");
                    }
                    if ($(this).val() === "deposited") {
                        $(this).addClass("deposit_status_deposited");
                    }
                    if ($(this).val() === "refunded") {
                        $(this).addClass("deposit_status_refunded");
                    }
                });

                $('#closePopupBtn').click(function () {
                    closePopup();
                });

                $('#closeDetailPopupBtn').click(function () {
                    closeDetailPopup();
                });

                $('#closeChangePopupBtn').click(function () {
                    closeChangePopup();
                });

                $('#closeAddFeeDetailPopupBtn').click(function () {
                    closeAddFeeDetailPopup();
                });

                $('#addFeeBtn').click(function () {
                    $("#addFeePopup").show();
                    $("#addFeeDetailPopup").hide();
                });

                $('#closeAddFeePopupBtn').click(function () {
                    $("#addFeePopup").hide();
                    $('#overlay').hide();
                });

                // Confirm cancellation
                $('#confirmCancelBtn').click(function () {
                    const reason = $('#cancelReason').val().trim();
                    if (reason === "") {
                        alert("Vui lòng nhập lý do hủy.");
                        return;
                    }
                    $("#booking_status" + bookingIdToCancel).empty();
                    $("#booking_status" + bookingIdToCancel).html("<div class=\"status_cancel\">Đã hủy</div>");
                    $("#cancel" + bookingIdToCancel).remove();
                    $.ajax({
                        url: "/clone/bookingcancel",
                        type: "get",
                        data: {
                            bid: bookingIdToCancel,
                            reason: reason
                        },
                        success: function (data) {
                        },
                        error: function (xhr) {
                            //Do Something to handle error
                        }
                    });
                    closePopup();
                });

                var currentTime = new Date().getTime();
                var oneHourInMillis = 60 * 60 * 1000;

                $('.checkMotoBtn').each(function () {
                    var returnTime = parseInt($(this).val());
                    var timeDifference = currentTime - returnTime;
                    if (timeDifference <= oneHourInMillis) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
                $(".showdetail").on('click', function () {
                    var id = $(this).val();
                    $.ajax({
                        url: "/clone/getbookingdetail",
                        type: "get",
                        data: {
                            bid: id
                        },
                        success: function (data) {
                            $("#detailContent").html(data);
                            $('#detailPopup').show();
                            $('#overlay').show();
                        },
                        error: function (xhr) {
                            //Do Something to handle error
                        }
                    });
                });

                $(".showChangeDetail").on('click', function () {
                    var id = $(this).val();
                    $.ajax({
                        url: "/clone/getbookingdetail",
                        type: "post",
                        data: {
                            bid: id
                        },
                        success: function (data) {
                            $("#changeContent").html(data);
                            $('#changePopup').show();
                            $('#overlay').show();
                        },
                        error: function (xhr) {
                            //Do Something to handle error
                        }
                    });
                });

                $(".showAdditionFee").on('click', function () {
                    var id = $(this).val();
                    bookingIdToAddFee = id;
                    $.ajax({
                        url: "/clone/additionfee",
                        type: "get",
                        data: {
                            bid: id
                        },
                        success: function (data) {
                            $("#addFeeContent").html(data);
                            $('#addFeeDetailPopup').show();
                            $('#overlay').show();
                        },
                        error: function (xhr) {
                            //Do Something to handle error
                        }
                    });
                });

                $('#confirmAddFeeBtn').click(function () {
                    const reason = $('#additionFeeReason').val().trim();
                    const amount = $('#addition_amount').val().trim();
                    if (reason === "") {
                        alert("Vui lòng nhập lý do phát sinh.");
                        return;
                    }
                    if (amount === "" || isNaN(amount)) {
                        alert("Vui lòng nhập phí phát sinh và đảm bảo là số");
                        return;
                    }
                    $.ajax({
                        url: "/clone/additionfee",
                        type: "post",
                        data: {
                            bid: bookingIdToAddFee,
                            reason: reason,
                            amount: amount
                        },
                        success: function (data) {
                        },
                        error: function (xhr) {
                            //Do Something to handle error
                        }
                    });
                    $("#addFeePopup").hide();
                    $('#overlay').hide();
                });

                $(".status").change(function () {
                    var statusChange = $(this).val();
                    var statusId = $(this).attr("id");
                    var s = "";
                    if (statusChange === "renting") {
                        s += "Xác nhận xe đã được bàn giao thành công ?";
                    }
                    if (statusChange === "completed") {
                        s += "Xác nhận quá trình thuê xe đã hoàn tất ?";
                    }
                    Swal.fire({
                        title: "Cập nhật trạng thái",
                        text: s,
                        icon: 'info',
                        showCancelButton: true,
                        confirmButtonText: 'Xác nhận',
                        cancelButtonText: 'Hủy'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            Swal.fire('Successful!', 'Cập nhật trạng thái thành công', 'success');
                            if (statusChange === "renting") {
                                $(this).find('option[value="booked"]').remove();
                                $(this).append($('<option>').val("completed").text("Đã hoàn thành"));
                                $(this).removeClass("status_booked");
                                $(this).addClass("status_renting");
                                $("#cancel" + statusId).remove();
                            }
                            if (statusChange === "completed") {
                                $(this).removeClass("status_renting");
                                $(this).addClass("status_completed");
                                $("#checkMotoBtn" + statusId).show();
                            }
                            $.ajax({
                                url: "/clone/managebookinglist",
                                type: "post",
                                data: {
                                    status: statusChange,
                                    id: statusId
                                },
                                success: function (data) {

                                },
                                error: function (xhr) {

                                }
                            });
                        } else if (result.isDismissed) {
                            if (statusChange === "renting") {
                                $(this).val("booked");
                            }
                            if (statusChange === "completed") {
                                $(this).val("renting");
                            }
                        }
                    });
                });

                $(".payment_status").change(function () {
                    var statusChange = $(this).val();
                    var statusId = $(this).attr("id");
                    var s = "Xác nhận khách hàng đã thanh toán ?";
                    Swal.fire({
                        title: "Cập nhật trạng thái thanh toán",
                        text: s,
                        icon: 'info',
                        showCancelButton: true,
                        confirmButtonText: 'Xác nhận',
                        cancelButtonText: 'Hủy'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            Swal.fire('Successful!', 'Cập nhật trạng thái thành công', 'success');
                            $(this).find('option[value="notyet"]').remove();
                            $(this).removeClass("payment_status_notyet");
                            $(this).addClass("payment_status_paid");
                            $.ajax({
                                url: "/clone/changebookingstatus",
                                type: "get",
                                data: {
                                    status: statusChange,
                                    id: statusId
                                },
                                success: function (data) {

                                },
                                error: function (xhr) {

                                }
                            });
                        } else if (result.isDismissed) {
                            $(this).val("notyet");
                        }
                    });
                });

                $(".deposit_status").change(function () {
                    var statusChange = $(this).val();
                    var statusId = $(this).attr("id");
                    var s = "";
                    if (statusChange === "deposited") {
                        s += "Xác nhận tiền cọc đã được thanh toán ?";
                    }
                    if (statusChange === "refunded") {
                        s += "Xác nhận đã hoàn trả tiền cọc cho khách hàng ?";
                    }
                    Swal.fire({
                        title: "Cập nhật trạng thái tiền cọc",
                        text: s,
                        icon: 'info',
                        showCancelButton: true,
                        confirmButtonText: 'Xác nhận',
                        cancelButtonText: 'Hủy'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            Swal.fire('Successful!', 'Cập nhật trạng thái thành công', 'success');
                            if (statusChange === "deposited") {
                                $(this).find('option[value="notyet"]').remove();
                                $(this).append($('<option>').val("refunded").text("Đã hoàn trả"));
                                $(this).removeClass("deposit_status_notyet");
                                $(this).addClass("deposit_status_deposited");
                            }
                            if (statusChange === "refunded") {
                                $(this).find('option[value="deposited"]').remove();
                                $(this).removeClass("deposit_status_deposited");
                                $(this).addClass("deposit_status_refunded");
                            }
                            $.ajax({
                                url: "/clone/changebookingstatus",
                                type: "post",
                                data: {
                                    status: statusChange,
                                    id: statusId
                                },
                                success: function (data) {

                                },
                                error: function (xhr) {

                                }
                            });
                        } else if (result.isDismissed) {
                            if (statusChange === "deposited") {
                                $(this).val("notyet");
                            }
                            if (statusChange === "refunded") {
                                $(this).val("deposited");
                            }
                        }
                    });
                });
            });
        </script>
    </body>
</html>
