<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking History</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #3498db;
                --accent-color: #e74c3c;
                --background-color: #ecf0f1;
                --sidebar-width: 280px;
            }

            body, html {
                height: 100%;
                margin: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--background-color);
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

            /* Sidebar Styles */
            .sidebar {
                height: calc(100vh - 72px);
                width: var(--sidebar-width);
                position: fixed;
                top: 72px;
                left: 0;
                background: linear-gradient(135deg, var(--primary-color), #34495e);
                padding-top: 30px;
                color: white;
                box-shadow: 4px 0 15px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                z-index: 1000;
            }

            .sidebar-item {
                padding: 15px 30px;
                display: flex;
                align-items: center;
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                transition: all 0.3s ease;
                border-left: 4px solid transparent;
                margin: 8px 0;
            }

            .sidebar-item:hover {
                background-color: rgba(255, 255, 255, 0.1);
                color: white;
                border-left-color: var(--secondary-color);
                transform: translateX(10px);
                text-decoration: none;
            }

            .sidebar-item i {
                margin-right: 15px;
                width: 20px;
                font-size: 1.2em;
            }
            .tabs {
                display: flex;
                border-bottom: 2px solid #eee;
                margin: 20px;
                justify-content: center;
                margin-top: 60px;
            }
            .tab {
                padding: 10px 20px;
                cursor: pointer;
                font-weight: bold;
                color: #333;
            }
            .tab.active {
                color: red;
                border-bottom: 3px solid red;
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #f9fafc;
                color: #333;
                margin: 0;
                padding: 20px;
            }
            .booking-container {
                max-width: 600px;
                margin: 0 auto;
            }
            .booking-card {
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-bottom: 15px;
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                gap: 8px;
            }
            .booking-header {
                font-size: 1.2em;
                color: #555;
                font-weight: bold;
            }
            .booking-details p {
                margin: 0;
                line-height: 1.6;
            }
            .action-buttons {
                display: flex;
                flex-direction: column;
                gap: 8px;
                align-items: flex-end;
            }
            .status {
                font-weight: bold;
            }
            .status.cancel {
                color: #e74c3c;
            }
            .status.booked {
                color: #4a90e2;
            }
            .status.renting {
                color: #f5a623;
            }
            .status.completed {
                color: #27ae60;
            }
            button {
                padding: 10px 20px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                font-size: 0.9em;
                transition: background-color 0.3s ease;
                color: white;
            }
            .btn-cancel {
                background-color: #e74c3c;
            }
            .btn-cancel:hover {
                background-color: #c0392b;
            }
            .btn-detail {
                background-color: #3498db;
            }
            .btn-detail:hover {
                background-color: #2980b9;
            }
            .btn-check {
                background-color: #27ae60;
            }
            .btn-check:hover {
                background-color: #229954;
            }
            .showAdditionFee {
                background-color: #ff9800;
                color: white;
            }
            .showAdditionFee:hover {
                background-color: #e67e22;
            }
            #overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 500;
            }
            .popup {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: #ffffff;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                width: 600px;
                max-width: 90%;
                max-height: 65vh;
                overflow-y: auto;
            }
            .popup h3 {
                margin-top: 0;
                font-size: 1.25em;
                color: #333;
            }
            .popup textarea {
                width: 100%;
                resize: vertical;
                border-radius: 5px;
                padding: 10px;
                border: 1px solid #ccc;
                font-size: 0.9em;
                margin-top: 8px;
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

            .btn-feedback {
                background-color: #28a745; /* Màu xanh lá */
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 14px;
                transition: background-color 0.3s ease;
                margin-right: 8px;
            }

            .btn-feedback:hover {
                background-color: #218838; /* Màu xanh lá đậm khi hover */
            }


            /* Feedback form container */
            .feedback-container {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
                padding: 25px;
                width: 400px;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            /* Feedback form header */
            .feedback-container h3 {
                margin: 0 0 20px 0;
                color: #333;
                font-size: 1.5em;
                border-bottom: 2px solid #eee;
                padding-bottom: 10px;
            }

            /* Rating section */
            .rating-section {
                margin-bottom: 20px;
            }

            .rating-section label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
            }

            #rating {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                width: 100%;
                margin-bottom: 15px;
            }

            /* Comment section */
            .comment-section {
                margin-bottom: 20px;
            }

            .comment-section label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
            }

            #comment {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                resize: vertical;
                min-height: 100px;
                margin-bottom: 15px;
                font-family: inherit;
            }

            /* Button container */
            .feedback-buttons {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }

            /* Close button */
            .btn-close {
                background-color: #6c757d;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 14px;
                transition: background-color 0.3s ease;
            }

            .btn-close:hover {
                background-color: #5a6268;
            }

            /* Star rating */
            .star-rating {
                display: flex;
                gap: 5px;
                margin-bottom: 15px;
            }

            .star {
                color: #ddd;
                font-size: 24px;
                cursor: pointer;
                transition: color 0.2s ease;
            }

            .star.active {
                color: #ffd700;
            }

            /* Overlay background */
            .feedback-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 999;
            }

            /* Form validation */
            .input-error {
                border-color: #dc3545 !important;
            }

            .error-message {
                color: #dc3545;
                font-size: 12px;
                margin-top: 4px;
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Đánh giá</a></li>
                        <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="login"><i class="fas fa-sign-in-alt mr-1"></i> Đăng nhập</a></li>
                        </c:if>
                </ul>
            </div>
        </nav>

        <!-- Sidebar -->
        <div class="sidebar">
            <a href="${pageContext.request.contextPath}/editprofile" class="sidebar-item">
                <i class="fas fa-user-edit"></i>
                Chỉnh sửa thông tin
            </a>
            <a href="${pageContext.request.contextPath}/changepassword" class="sidebar-item">
                <i class="fas fa-key"></i>
                Đổi mật khẩu
            </a>
            <a href="${pageContext.request.contextPath}/mybookinglist" class="sidebar-item">
                <i class="fas fa-history"></i>
                Lịch sử thuê xe
            </a>
            <a href="${pageContext.request.contextPath}/approvalmotorbike" class="sidebar-item">
                <i class="fas fa-motorcycle"></i>
                Lịch sử cho thuê xe
            </a>
            <a href="${pageContext.request.contextPath}/updatepending" class="sidebar-item">
                <i class="fas fa-user-circle"></i>
                Xem yêu cầu vai trò
            </a>
            <a href="logout" class="sidebar-item">
                <i class="fas fa-sign-out-alt"></i>
                Đăng xuất
            </a>
        </div>
        <div class="tabs">
            <div class="tab ${requestScope.status == '' ? 'active' : ''}" onclick="filterBooking('')">TẤT CẢ</div>
            <div class="tab ${requestScope.status == 'booked' ? 'active' : ''}" onclick="filterBooking('booked')">ĐÃ ĐẶT</div>
            <div class="tab ${requestScope.status == 'renting' ? 'active' : ''}" onclick="filterBooking('renting')">ĐANG THUÊ</div>
            <div class="tab ${requestScope.status == 'completed' ? 'active' : ''}" onclick="filterBooking('completed')">HOÀN THÀNH</div>
            <div class="tab ${requestScope.status == 'cancel' ? 'active' : ''}" onclick="filterBooking('cancel')">ĐÃ HUỶ</div>
        </div>
        <div class="booking-container">
            <c:forEach items="${requestScope.bookings}" var="b" varStatus="status">
                <div class="booking-card">

                    <div class="booking-details">
                        <p><strong>Mã đơn hàng:</strong> ${b.code}</p>
                        <p><strong>Ngày tạo:</strong> ${b.createdAt}</p>
                        <p><strong>Tổng tiền:</strong><fmt:formatNumber value="${b.totalCost}" maxFractionDigits="0"/> VND</p>
                        <p><strong>Trạng thái:</strong> 
                            <c:choose>
                                <c:when test="${b.status == 'booked'}">
                                    <span class="status booked" id="status${b.bookingId}">Đã đặt</span>
                                </c:when>
                                <c:when test="${b.status == 'renting'}">
                                    <span class="status renting" id="status${b.bookingId}">Đang thuê</span>
                                </c:when>
                                <c:when test="${b.status == 'completed'}">
                                    <span class="status completed" id="status${b.bookingId}">Đã hoàn tất</span>
                                </c:when>
                                <c:when test="${b.status == 'cancel'}">
                                    <span class="status cancel" id="status${b.bookingId}">Đã hủy</span>
                                </c:when>
                            </c:choose>
                            <span class="status ${b.status == 'cancel' ? 'cancelled' : ''}" id="status${b.bookingId}"></span>
                        </p>
                    </div>
                    <div class="action-buttons">
                        <c:if test="${b.status eq 'booked'}">
                            <button class="btn-cancel" onclick="showCancelPopup(${b.bookingId})">Hủy</button>
                        </c:if>
                        <c:if test="${b.status eq 'completed'}">
                            <button class="btn-feedback" onclick="showFeedbackForm(${b.bookingId})">Feedback</button>
                        </c:if>
                        <button class="btn-detail" onclick="showDetail(${b.bookingId})">Chi tiết</button>
                        <button class="btn-check" style="display:none;" value="${b.receiveTime.time}" onclick="window.location.href = 'checkmotorbikechange?bid=${b.bookingId}'">Check Vehicle</button>
                        <button class="showAdditionFee" value="${b.bookingId}">Phí phát sinh</button>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="pagination">
            <c:if test="${requestScope.currentPage > 1}">
                <a href="?page=${requestScope.currentPage - 1}&status=${requestScope.status}" aria-label="Previous">&laquo;</a>
            </c:if>

            <c:forEach begin="1" end="${requestScope.totalPage}" var="i">
                <c:if test="${requestScope.currentPage == i}">
                    <a class="active">${i}</a>
                </c:if>
                <c:if test="${requestScope.currentPage != i}">
                    <a href="?page=${i}&status=${requestScope.status}">${i}</a>
                </c:if>
            </c:forEach>

            <c:if test="${requestScope.currentPage < requestScope.totalPage}">
                <a href="?page=${requestScope.currentPage + 1}&status=${requestScope.status}" aria-label="Next">&raquo;</a>
            </c:if>
        </div>

        <div id="overlay"></div>

        <div id="cancelPopup" class="popup">
            <h3>Xác nhận hủy </h3>
            <label for="cancelReason">Lí do hủy:</label>
            <textarea id="cancelReason" rows="4"></textarea>
            <button id="confirmCancelBtn" class="btn-cancel">Xác nhận</button>
            <button id="closePopupBtn" class="btn-detail">Đóng</button>
        </div>

        <div id="detailPopup" class="popup">
            <div id="detailContent"></div>
            <button id="closeDetailPopupBtn" class="btn-detail">Đóng</button>
        </div>

        <div id="addFeeDetailPopup" class="popup">
            <div id="addFeeContent"></div>   
            <button id="closeAddFeeDetailPopupBtn" class="btn-detail">Đóng</button>
        </div>


        <div class="feedback-container" id="feedbackForm" style="display: none; z-index: 1000;">
            <h3>Đánh giá dịch vụ</h3>

            <div class="rating-section">
                <label for="rating">Đánh giá của bạn:</label>
                <div class="star-rating" id="starRating">
                    <span class="star" data-rating="1">★</span>
                    <span class="star" data-rating="2">★</span>
                    <span class="star" data-rating="3">★</span>
                    <span class="star" data-rating="4">★</span>
                    <span class="star" data-rating="5">★</span>
                </div>
                <input type="hidden" id="rating" value="0">
            </div>

            <div class="comment-section">
                <label for="comment">Nhận xét của bạn:</label>
                <textarea id="comment" placeholder="Chia sẻ trải nghiệm của bạn..."></textarea>
                <div class="error-message" id="commentError" style="display: none;">
                    Vui lòng nhập nhận xét của bạn
                </div>
            </div>

            <div class="feedback-buttons">
                <button class="btn-feedback">Gửi đánh giá</button>
                <button class="btn-detail">Đóng</button>
            </div>

        </div>
        <div id="overlay"></div>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
                            let bookingIdToCancel = null;

                            function filterBooking(status) {
                                window.location.href = 'mybookinglist?status=' + status;
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

                            $(document).ready(function () {
                                $('#closePopupBtn').click(function () {
                                    closePopup();
                                });

                                $('#closeDetailPopupBtn').click(function () {
                                    closeDetailPopup();
                                });

                                $('#closeAddFeeDetailPopupBtn').click(function () {
                                    $('#addFeeDetailPopup').hide();
                                    $('#overlay').hide();
                                });

                                $('#confirmCancelBtn').click(function () {
                                    const reason = $('#cancelReason').val().trim();
                                    if (reason === "") {
                                        alert("Hãy nhập lí do hủy");
                                        return;
                                    }
                                    $("#status" + bookingIdToCancel).empty();
                                    $("#status" + bookingIdToCancel).css('color', '#e74c3c');
                                    $("#status" + bookingIdToCancel).text("Đã hủy");
                                    $("#cancelBtn" + bookingIdToCancel).empty();
                                    $.ajax({
                                        url: "/clone/bookingcancel",
                                        type: "get",
                                        data: {bid: bookingIdToCancel, reason: reason},
                                        success: function () {
                                        },
                                        error: function () {
                                        }
                                    });
                                    closePopup();
                                });

                                var currentTime = new Date().getTime();
                                var oneHourInMillis = 60 * 60 * 1000;
                                $('.btn-check').each(function () {
                                    var receiveTime = parseInt($(this).val());
                                    if (currentTime - receiveTime <= oneHourInMillis) {
                                        $(this).show();
                                    }
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
                                $(".btn-feedback").on('click', function () {
                                    const comment = $('#comment').val().trim();
                                    const rating = $('#rating').val();




                                });

                            });

                            function showDetail(id) {
                                $.ajax({
                                    url: "/clone/getbookingdetail",
                                    type: "get",
                                    data: {bid: id},
                                    success: function (data) {
                                        $("#detailContent").html(data);
                                        $('#detailPopup').show();
                                        $('#overlay').show();
                                    },
                                    error: function () {
                                    }
                                });
                            }
                            let bookingIdForFeedback = null;
                            function showFeedbackForm(bookingId) {
                                bookingIdForFeedback = bookingId;
                                $("#feedbackForm").show();
                                $('#overlay').show();
                                // Reset form
                                $('#rating').val('0');
                                $('#comment').val('');
                            }

                            function hideFeedbackForm() {
                                $("#feedbackForm").hide();
                                $('#overlay').hide();
                                // Reset form state
                                bookingIdForFeedback = null;
                                $('#rating').val('0');
                                $('#comment').val('');
                            }
                            document.querySelectorAll('.star').forEach(star => {
                                star.addEventListener('mouseover', function () {
                                    const rating = this.dataset.rating;
                                    highlightStars(rating);
                                });

                                star.addEventListener('mouseout', function () {
                                    const currentRating = document.getElementById('rating').value;
                                    highlightStars(currentRating);
                                });

                                star.addEventListener('click', function () {
                                    const rating = this.dataset.rating;
                                    document.getElementById('rating').value = rating;
                                    highlightStars(rating);
                                });
                            });

                            function highlightStars(rating) {
                                document.querySelectorAll('.star').forEach(star => {
                                    star.classList.toggle('active', star.dataset.rating <= rating);
                                });
                            }
                            function submitFeedback() {
                                const rating = document.getElementById('rating').value;
                                const comment = document.getElementById('comment').value.trim();
                                const commentError = document.getElementById('commentError');

                                // Validation
                                if (!comment) {
                                    commentError.style.display = 'block';
                                    return;
                                }

                                if (rating === '0') {
                                    alert('Vui lòng chọn số sao đánh giá');
                                    return;
                                }

                                // Submit feedback via AJAX
                                $.ajax({
                                    url: "/MotorbikeRential/feedback",
                                    type: "post",
                                    data: {
                                        bookingId: bookingIdForFeedback,
                                        comment: comment,
                                        rating: rating
                                    },
                                    success: function (response) {
                                        alert('Cảm ơn bạn đã đánh giá!');
                                        hideFeedbackForm();
                                    },
                                    error: function (xhr) {
                                        alert('Có lỗi xảy ra. Vui lòng thử lại sau.');
                                    }
                                });
                            }
                            $(document).ready(function () {
                                // Handler for closing feedback form
                                $('.btn-detail').click(function () {
                                    hideFeedbackForm();
                                });

                                // Handle feedback submission
                                $('.btn-feedback').click(function () {
                                    const comment = $('#comment').val().trim();
                                    const rating = $('#rating').val();

                                    if (!comment) {
                                        alert('Vui lòng nhập nhận xét của bạn');
                                        return;
                                    }

                                    if (rating === '0') {
                                        alert('Vui lòng chọn số sao đánh giá');
                                        return;
                                    }

                                    $.ajax({
                                        url: "/clone/feedback",
                                        type: "post",
                                        data: {
                                            bookingId: bookingIdForFeedback,
                                            comment: comment,
                                            rating: rating
                                        },
                                        success: function (data) {
                                            alert('Cảm ơn bạn đã đánh giá!');
                                            hideFeedbackForm();
                                        },
                                        error: function (xhr) {
                                            alert('Có lỗi xảy ra. Vui lòng thử lại sau.');
                                        }
                                    });
                                });
                            });
                            $(document).mouseup(function (e) {
                                var container = $("#feedbackForm");
                                // If the target of the click isn't the container nor a descendant of the container
                                if (!container.is(e.target) && container.has(e.target).length === 0) {
                                    hideFeedbackForm();
                                }
                            });







        </script>
    </body>
</html>
