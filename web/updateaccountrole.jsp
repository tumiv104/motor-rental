<%-- 
    Document   : UpdateAccountRole
    Created on : Nov 9, 2024, 4:19:28 AM
    Author     : hungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nâng Cấp Tài Khoản Rental | Motorbike Rental</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #2563eb;
                --secondary-color: #1e40af;
                --error-color: #dc2626;
                --success-color: #16a34a;
                --text-color: #1f2937;
                --light-gray: #f3f4f6;
                --border-color: #e5e7eb;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', system-ui, sans-serif;
            }

            body {
                background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
                color: var(--text-color);
                line-height: 1.6;
                min-height: 100vh;
            }

            .container {
                max-width: 1000px;
                margin: 40px auto;
                padding: 0 20px;
            }

            .upgrade-box {
                background: white;
                border-radius: 16px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                overflow: hidden;
                display: flex;
            }

            .info-section {
                flex: 1;
                padding: 40px;
                background: var(--primary-color);
                color: white;
            }

            .info-section h2 {
                font-size: 2.5rem;
                margin-bottom: 20px;
                font-weight: 700;
            }

            .info-section p {
                margin-bottom: 20px;
                font-size: 1.1rem;
                opacity: 0.9;
            }

            .benefits {
                margin-top: 40px;
            }

            .benefit-item {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                background: rgba(255, 255, 255, 0.1);
                padding: 15px;
                border-radius: 8px;
                transition: transform 0.3s ease;
            }

            .benefit-item:hover {
                transform: translateX(10px);
            }

            .benefit-item i {
                margin-right: 15px;
                font-size: 1.5rem;
            }

            .form-section {
                flex: 1.2;
                padding: 40px;
            }

            .form-header {
                margin-bottom: 30px;
                text-align: center;
            }

            .form-header h3 {
                font-size: 1.8rem;
                color: var(--text-color);
                margin-bottom: 10px;
            }

            .current-info {
                background: var(--light-gray);
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 30px;
            }

            .current-info p {
                margin-bottom: 10px;
            }

            .current-info strong {
                color: var(--primary-color);
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: var(--text-color);
            }

            .form-group textarea {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid var(--border-color);
                border-radius: 8px;
                font-size: 1rem;
                resize: vertical;
                min-height: 120px;
                transition: all 0.3s ease;
            }

            .form-group textarea:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            .submit-btn {
                width: 100%;
                padding: 14px;
                background: var(--primary-color);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

            .submit-btn:hover {
                background: var(--secondary-color);
            }

            .error-message {
                color: var(--error-color);
                font-size: 0.9rem;
                margin-top: 5px;
                padding: 10px;
                background-color: #fef2f2;
                border-radius: 4px;
            }

            .success-message {
                color: var(--success-color);
                font-size: 0.9rem;
                margin-top: 5px;
                padding: 10px;
                background-color: #f0fdf4;
                border-radius: 4px;
            }

            @media (max-width: 768px) {
                .upgrade-box {
                    flex-direction: column;
                }

                .info-section,
                .form-section {
                    padding: 30px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="upgrade-box">
                <div class="info-section">
                    <h2>Nâng Cấp Tài Khoản Rental</h2>
                    <p>Mở rộng cơ hội kinh doanh của bạn bằng cách trở thành đối tác cho thuê xe.</p>

                    <div class="benefits">
                        <div class="benefit-item">
                            <i class="fas fa-money-bill-wave"></i>
                            <span>Thu nhập thêm từ xe của bạn</span>
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-shield-alt"></i>
                            <span>Bảo hiểm đầy đủ cho mọi chuyến đi</span>
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-clock"></i>
                            <span>Quản lý linh hoạt thời gian cho thuê</span>
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-chart-line"></i>
                            <span>Tiếp cận nhiều khách hàng tiềm năng</span>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <div class="form-header">
                        <h3>Đăng Ký Nâng Cấp</h3>
                        <p>Hoàn tất thông tin để gửi yêu cầu nâng cấp tài khoản</p>
                    </div>

                    <div class="current-info">
                        <p><strong>Tài khoản hiện tại:</strong> ${sessionScope.user.email}</p>
                        <p><strong>Họ và tên:</strong> ${sessionScope.user.fullName}</p> 
                        <p><strong>Loại tài khoản:</strong> ${sessionScope.user.userType}</p> 
                    </div>
                    <form action="updateaccount" method="post" id="upgradeForm" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="phone_number">Số điện thoại liên hệ</label>
                            <input type="tel" id="phone_number" name="phone_number" 
                                   value="${sessionScope.user.phoneNumber}" 
                                   class="form-control"
                                   pattern="[0-9]{10}"
                                   title="Vui lòng nhập số điện thoại 10 chữ số"
                                   required>
                            <div id="phone-error" class="error-message"></div>
                        </div>

                        <div class="form-group">
                            <label for="address">Địa chỉ cho thuê xe</label>
                            <input type="text" id="address" name="address" 
                                   value="${sessionScope.user.address}"
                                   class="form-control"
                                   required>
                            <div id="address-error" class="error-message"></div>
                        </div>

                        <div class="form-group">
                            <label for="reason">Lý do muốn trở thành đối tác cho thuê xe</label>
                            <textarea id="reason" name="reason" required
                                      class="form-control"
                                      placeholder="Chia sẻ với chúng tôi lý do bạn muốn trở thành đối tác cho thuê xe..."></textarea>
                            <div id="reason-error" class="error-message"></div>
                        </div>

                        <div id="form-error" class="alert alert-danger" style="display: none;"></div>
                        <div id="form-success" class="alert alert-success" style="display: none;"></div>

                        <button type="submit" class="submit-btn">
                            <i class="fas fa-paper-plane"></i>
                            Gửi Yêu Cầu Nâng Cấp
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <script>
            function validateForm() {
                let isValid = true;
                // Reset error messages
                document.getElementById('phone-error').innerHTML = '';
                document.getElementById('address-error').innerHTML = '';
                document.getElementById('reason-error').innerHTML = '';
                document.getElementById('form-error').style.display = 'none';

                // Get form values
                const phone = document.getElementById('phone_number').value.trim();
                const address = document.getElementById('address').value.trim();
                const reason = document.getElementById('reason').value.trim();

                // Validate phone number
                if (!phone) {
                    document.getElementById('phone-error').innerHTML = 'Vui lòng nhập số điện thoại';
                    isValid = false;
                } else if (!/^[0-9]{10}$/.test(phone)) {
                    document.getElementById('phone-error').innerHTML = 'Số điện thoại phải có 10 chữ số';
                    isValid = false;
                }

                // Validate address
                if (!address) {
                    document.getElementById('address-error').innerHTML = 'Vui lòng nhập địa chỉ';
                    isValid = false;
                }

                // Validate reason
                if (!reason) {
                    document.getElementById('reason-error').innerHTML = 'Vui lòng nhập lý do';
                    isValid = false;
                } else if (reason.length < 10) {
                    document.getElementById('reason-error').innerHTML = 'Lý do phải có ít nhất 10 ký tự';
                    isValid = false;
                }

                if (!isValid) {
                    document.getElementById('form-error').innerHTML = 'Vui lòng kiểm tra lại thông tin nhập vào';
                    document.getElementById('form-error').style.display = 'block';
                }

                return isValid;
            }

// Add event listeners for real-time validation
            document.getElementById('phone_number').addEventListener('input', function () {
                const phone = this.value.trim();
                const errorElement = document.getElementById('phone-error');
                if (!/^[0-9]{10}$/.test(phone)) {
                    errorElement.innerHTML = 'Số điện thoại phải có 10 chữ số';
                } else {
                    errorElement.innerHTML = '';
                }
            });

            document.getElementById('address').addEventListener('input', function () {
                const address = this.value.trim();
                const errorElement = document.getElementById('address-error');
                if (!address) {
                    errorElement.innerHTML = 'Vui lòng nhập địa chỉ';
                } else {
                    errorElement.innerHTML = '';
                }
            });

            document.getElementById('reason').addEventListener('input', function () {
                const reason = this.value.trim();
                const errorElement = document.getElementById('reason-error');
                if (reason.length < 10) {
                    errorElement.innerHTML = 'Lý do phải có ít nhất 10 ký tự';
                } else {
                    errorElement.innerHTML = '';
                }
            });
        </script>
    </body>
</html>
