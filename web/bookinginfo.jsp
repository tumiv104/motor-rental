<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Info</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="js/address.js"></script>
        <script src="js/checkavailable.js"></script>
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #3498db;
                --accent-color: #e74c3c;
                --background-color: #f5f7fa;
                --success-color: #2ecc71;
                --warning-color: #f1c40f;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                margin: 0;
                padding: 0;
                min-height: 100vh;
            }

            /* Navbar Styles */
            .navbar {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                box-shadow: 0 2px 15px rgba(0,0,0,0.1);
                padding: 1rem 2rem;
                transition: all 0.3s ease;
            }

            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
                background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                transition: transform 0.3s ease;
            }

            .nav-link {
                color: var(--primary-color) !important;
                margin: 0 15px;
                padding: 8px 16px;
                border-radius: 20px;
                transition: all 0.3s ease;
                font-weight: 500;
                position: relative;
                overflow: hidden;
            }

            .nav-link::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                height: 2px;
                background: linear-gradient(45deg, var(--secondary-color), var(--primary-color));
                transform: scaleX(0);
                transition: transform 0.3s ease;
            }

            .nav-link:hover::after {
                transform: scaleX(1);
            }

            .nav-link:hover {
                background: linear-gradient(45deg, var(--secondary-color), var(--primary-color));
                color: white !important;
                transform: translateY(-2px);
            }

            /* Form Styles */
            .booking-container {
                padding-top: 100px;
                padding-bottom: 50px;
                animation: fadeIn 0.5s ease;
            }

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

            .booking-form {
                background: white;
                padding: 40px;
                margin: 0 auto;
                max-width: 800px;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .booking-form::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: linear-gradient(45deg, var(--secondary-color), var(--primary-color));
            }

            .booking-form:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            }

            .booking-form h1 {
                text-align: center;
                color: var(--primary-color);
                margin-bottom: 40px;
                font-weight: 700;
                position: relative;
                padding-bottom: 15px;
            }

            .booking-form h1::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 3px;
                background: linear-gradient(45deg, var(--secondary-color), var(--primary-color));
                border-radius: 3px;
            }

            .form-group {
                margin-bottom: 25px;
                position: relative;
            }

            .custom-label {
                font-weight: 600;
                color: var(--primary-color);
                margin-bottom: 10px;
                display: block;
                transition: all 0.3s ease;
                font-size: 0.95rem;
            }

            .form-group:hover .custom-label {
                color: var(--secondary-color);
                transform: translateX(5px);
            }

            input, select {
                width: 100%;
                padding: 12px 15px;
                margin: 8px 0;
                border: 2px solid #eee;
                border-radius: 12px;
                font-size: 14px;
                transition: all 0.3s ease;
                background-color: #f8f9fa;
            }

            input:focus, select:focus {
                border-color: var(--secondary-color);
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
                outline: none;
                background-color: white;
            }

            input[type="submit"] {
                background: linear-gradient(45deg, var(--secondary-color), var(--primary-color));
                color: white;
                border: none;
                padding: 15px 30px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                position: relative;
                overflow: hidden;
            }

            input[type="submit"]:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
            }

            input[type="submit"]:active {
                transform: translateY(0);
            }

            .error {
                color: var(--accent-color);
                font-size: 13px;
                margin-top: 5px;
                display: block;
                animation: shake 0.5s ease;
            }

            @keyframes shake {
                0%, 100% {
                    transform: translateX(0);
                }
                25% {
                    transform: translateX(-5px);
                }
                75% {
                    transform: translateX(5px);
                }
            }

            .success {
                color: var(--success-color);
                font-size: 13px;
                margin-top: 5px;
                display: block;
                animation: slideIn 0.5s ease;
            }

            .address-section {
                display: none;
                background: linear-gradient(to right, #f8f9fa, #ffffff);
                padding: 20px;
                border-radius: 12px;
                margin-top: 15px;
                border: 1px solid #eee;
                transition: all 0.3s ease;
            }

            .address-section.visible {
                display: block;
                animation: slideDown 0.3s ease;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Form Section Dividers */
            .section-divider {
                margin: 40px 0;
                border: none;
                height: 1px;
                background: linear-gradient(to right, transparent, #ddd, transparent);
            }

            /* Icon Styles */
            .form-group i {
                color: var(--secondary-color);
                margin-right: 8px;
                transition: all 0.3s ease;
            }

            .form-group:hover i {
                transform: scale(1.2);
            }

            /* Custom Select Styling */
            select {
                appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%232c3e50' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 15px center;
                background-size: 15px;
                padding-right: 45px;
            }

            /* Loading State */
            .loading {
                position: relative;
                pointer-events: none;
            }

            .loading::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255, 255, 255, 0.8);
                display: flex;
                justify-content: center;
                align-items: center;
                border-radius: 12px;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .booking-form {
                    margin: 20px;
                    padding: 30px 20px;
                }

                .nav-link {
                    margin: 5px;
                    padding: 8px;
                }

                .booking-form h1 {
                    font-size: 1.5rem;
                }

                input, select {
                    padding: 10px;
                }
            }

            /* Tooltip Styles */
            [data-tooltip] {
                position: relative;
            }

            [data-tooltip]:hover::before {
                content: attr(data-tooltip);
                position: absolute;
                bottom: 100%;
                left: 50%;
                transform: translateX(-50%);
                padding: 8px 12px;
                background: rgba(44, 62, 80, 0.9);
                color: white;
                font-size: 12px;
                border-radius: 6px;
                white-space: nowrap;
                animation: fadeIn 0.3s ease;
                z-index: 1000;
            }

            /* Form Field Groups */
            .field-group {
                background: #f8f9fa;
                padding: 25px;
                border-radius: 15px;
                margin-bottom: 30px;
                border: 1px solid #eee;
                transition: all 0.3s ease;
            }

            .field-group:hover {
                background: white;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                transform: translateX(5px);
            }

            /* Progress Indicator */
            .progress-indicator {
                display: flex;
                justify-content: space-between;
                margin-bottom: 40px;
                position: relative;
            }

            .progress-step {
                flex: 1;
                text-align: center;
                position: relative;
            }

            .progress-step::before {
                content: '';
                width: 30px;
                height: 30px;
                background: #eee;
                border-radius: 50%;
                display: block;
                margin: 0 auto 10px;
                transition: all 0.3s ease;
            }

            .progress-step.active::before {
                background: var(--secondary-color);
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
            }

            .progress-step::after {
                content: '';
                position: absolute;
                top: 15px;
                left: 50%;
                width: 100%;
                height: 2px;
                background: #eee;
                z-index: -1;
            }

            .progress-step:last-child::after {
                display: none;
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
                    <li class="nav-item"><a class="nav-link" href="profile"><i class="fas fa-user mr-1"></i> Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Review</a></li>
                        <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="login"><i class="fas fa-sign-in-alt mr-1"></i> Đăng nhập</a></li>
                        </c:if>
                </ul>
            </div>
        </nav>

        <div class="booking-container">
            <form action="bookinfo" method="POST" id="bookingform" class="booking-form">
                <h1><i class="fas fa-calendar-alt mr-2"></i>Thông tin đặt xe</h1>

                <div class="form-group">
                    <label class="custom-label"><i class="fas fa-calendar-plus mr-2"></i>Ngày nhận xe:</label>
                    <input type="datetime-local" id="startDate" name="startDate" required>
                </div>

                <div class="form-group">
                    <label class="custom-label"><i class="fas fa-calendar-minus mr-2"></i>Ngày trả xe:</label>
                    <input type="datetime-local" id="endDate" name="endDate" required>
                </div>

                <div id="alert1"></div>

                <div class="form-group">
                    <label class="custom-label"><i class="fas fa-map-marker-alt mr-2"></i>Địa chỉ nhận xe:</label>
                    <select id="visibility1" name="pickup" class="form-control">
                        <option value="hide">Tại cửa hàng</option>
                        <option value="show">Địa chỉ cụ thể</option>
                    </select>
                    <div id="address1" class="address-section">
                        <select id="province" name="province" class="form-control">
                            <option value="">Tỉnh/Thành</option>
                            <c:forEach items="${requestScope.provinces}" var="p">
                                <option value="${p.id}">${p.name}</option>
                            </c:forEach>
                        </select>
                        <select id="district" name="district" class="form-control mt-2">
                            <option value="">Quận/Huyện</option>
                        </select>
                        <select id="ward" name="ward" class="form-control mt-2">
                            <option value="">Xã/Phường</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="custom-label"><i class="fas fa-map-marker mr-2"></i>Địa chỉ trả xe:</label>
                    <select id="visibility2" name="dropoff" class="form-control">
                        <option value="hide">Tại cửa hàng</option>
                        <option value="show">Địa chỉ cụ thể</option>
                    </select>
                    <div id="address2" class="address-section">
                        <select id="province2" name="province2" class="form-control">
                            <option value="">Tỉnh/Thành</option>
                            <c:forEach items="${requestScope.provinces}" var="p">
                                <option value="${p.id}">${p.name}</option>
                            </c:forEach>
                        </select>
                        <select id="district2" name="district2" class="form-control mt-2">
                            <option value="">Quận/Huyện</option>
                        </select>
                        <select id="ward2" name="ward2" class="form-control mt-2">
                            <option value="">Xã/Phường</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="custom-label"><i class="fas fa-user mr-2"></i>Thông tin cá nhân:</label>
                    <input type="text" id="name" name="name" value="${sessionScope.user.fullName}" placeholder="Họ và tên" required onchange="validateName()">
                    <div id="name_error" class="error"></div>

                    <input type="text" id="email" name="email" value="${sessionScope.user.email}" placeholder="Email" required onchange="validateEmail()">
                    <div id="email_error" class="error"></div>

                    <input type="text" id="phone" name="phone_number" value="${sessionScope.user.phoneNumber}" placeholder="Số điện thoại" required onchange="validatePhone()">
                    <div id="phone_error" class="error"></div>
                </div>

                <div class="form-group">
                    <label class="custom-label"><i class="fas fa-home mr-2"></i>Địa chỉ thường trú:</label>
                    <div id="address3">
                        <select id="province3" name="province3" class="form-control">
                            <option value="">Tỉnh/Thành</option>
                            <c:forEach items="${requestScope.provinces}" var="p">
                                <option value="${p.id}">${p.name}</option>
                            </c:forEach>
                        </select>
                        <select id="district3" name="district3" class="form-control mt-2">
                            <option value="">Quận/Huyện</option>
                        </select>
                        <select id="ward3" name="ward3" class="form-control mt-2">
                            <option value="">Xã/Phường</option>
                        </select>
                    </div>
                    <div id="address_error" class="error"></div>
                </div>

                <div class="form-group">
                    <input type="text" id="idNumber" name="idNumber" placeholder="Số CMND/CCCD hoặc hộ chiếu" required onchange="validateID()">
                    <div id="id_error" class="error"></div>

                    <input type="text" id="licenseNumber" name="licenseNumber" placeholder="Số Giấy Phép Lái Xe" required onchange="validateLicense()">
                    <div id="license_error" class="error"></div>
                </div>

                <span style="color: var(--accent-color)">${requestScope.mess}</span>
                <input type="submit" value="Thanh toán ngay" class="mt-3">
            </form>
        </div>

        <script>
            function validateName() {
                const namePattern = /^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểẾỄỆỉịọỏốồổỗộớờởỡợụủứừửữựỳỵỷỹ\s]+$/u;
                const name = $('#name').val().trim();
                $('#name_error').empty();
                if (name === "" || !namePattern.test(name)) {
                    $('#name_error').text("Họ và tên không hợp lệ !");
                    $('#name').focus();
                    return false;
                }
                return true;
            }

            function validateEmail() {
                const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                $('#email_error').empty();
                if (!emailPattern.test($('#email').val())) {
                    $('#email_error').text("Email không hợp lệ !");
                    $('#email').focus();
                    return false;
                }
                return true;
            }

            function validatePhone() {
                const phonePattern = /^\d{10}$/;
                $('#phone_error').empty();
                if (!phonePattern.test($('#phone').val())) {
                    $('#phone_error').text("Số điện thoại không hợp lệ !");
                    $('#phone').focus();
                    return false;
                }
                return true;
            }

            function validateProvince() {
                $('#address_error').empty();
                if ($('#province3').val() === "") {
                    $('#address_error').text("Vui lòng chọn địa chỉ");
                    $('#province3').focus();
                    return false;
                }
                return true;
            }

            function validateDistrict() {
                $('#address_error').empty();
                if ($('#district3').val() === "") {
                    $('#address_error').text("Vui lòng chọn địa chỉ");
                    $('#district3').focus();
                    return false;
                }
                return true;
            }

            function validateWard() {
                $('#address_error').empty();
                if ($('#ward3').val() === "") {
                    $('#address_error').text("Vui lòng chọn địa chỉ");
                    $('#ward3').focus();
                    return false;
                }
                return true;
            }

            function validateID() {
                const idPattern = /^[0-9]{9}$|^[0-9]{12}$/;
                const passportPattern = /^[A-Z][0-9A-Z]{7}$/;
                $('#id_error').empty();
                if (!idPattern.test($("#idNumber").val()) && !passportPattern.test($("#idNumber").val())) {
                    $('#id_error').text("Số CMND/CCCD hoặc hộ chiếu không hợp lệ !");
                    $("#idNumber").focus();
                    return false;
                }
                return true;
            }

            function validateLicense() {
                const licensePattern = /^[0-9]{12}$/;
                $('#license_error').empty();
                if (!licensePattern.test($("#licenseNumber").val())) {
                    $('#license_error').text("Số Giấy Phép Lái Xe không hợp lệ !");
                    $("#licenseNumber").focus();
                    return false;
                }
                return true;
            }

            document.getElementById("bookingform").onsubmit = function (event) {
                let valid = true;

                if (!validateID())
                    valid = false;
                if (!validateName())
                    valid = false;
                if (!validateEmail())
                    valid = false;
                if (!validatePhone())
                    valid = false;
                if (!validateLicense())
                    valid = false;
                if (!validateProvince())
                    valid = false;
                if (!validateDistrict())
                    valid = false;
                if (!validateWard())
                    valid = false;

                if (!valid) {
                    event.preventDefault();
                }
            };


            // Lấy ngày hiện tại
            const now = new Date();
            const formatDateTime = (date) => {
                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const day = String(date.getDate()).padStart(2, '0');
                const hours = String(date.getHours()).padStart(2, '0');
                const minutes = String(date.getMinutes()).padStart(2, '0');
                return year + "-" + month + "-" + day + "T" + hours + ":" + minutes;
            };
            // Gán giá trị min cho input
            document.getElementById("startDate").min = formatDateTime(now);
            document.getElementById("endDate").min = formatDateTime(now);
            // Thêm 5 năm vào ngày hiện tại
            const maxDate = new Date();
            maxDate.setFullYear(now.getFullYear() + 5);
            // Thiết lập giá trị max cho input
            document.getElementById("startDate").max = formatDateTime(maxDate);
            document.getElementById("endDate").max = formatDateTime(maxDate);
            // Lắng nghe sự kiện thay đổi trên input 'startDate'
            document.getElementById("startDate").addEventListener('change', function () {
                const startDate = new Date(this.value);
                // Thiết lập giá trị min cho input endDate
                document.getElementById("endDate").min = formatDateTime(startDate);
            });
        </script>
    </body>
</html>
