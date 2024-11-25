<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mail Confirmation</title>
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <style>
            body {
                background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('https://your-motorcycle-image-url.jpg');
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                background-repeat: no-repeat;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                display: flex;
                align-items: center;
            }

            .container {
                padding: 20px;
            }

            .card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border: none;
                border-radius: 15px;
                width: 100%;
                max-width: 500px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                transform: translateY(0);
                transition: all 0.3s ease;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
            }

            .card-header {
                background: linear-gradient(135deg, #2193b0, #6dd5ed);
                color: white;
                border: none;
                border-radius: 15px 15px 0 0;
                padding: 2rem 0;
                position: relative;
                overflow: hidden;
            }

            .card-header h3 {
                margin: 0;
                font-weight: 600;
                font-size: 1.8rem;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .card-header::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: rgba(255, 255, 255, 0.1);
                transform: rotate(45deg);
                pointer-events: none;
            }

            .card-body {
                padding: 2.5rem;
            }

            .form-control {
                border-radius: 10px;
                height: 50px;
                padding-left: 20px;
                border: 2px solid #e1e1e1;
                transition: all 0.3s ease;
                font-size: 1rem;
            }

            .form-control:focus {
                border-color: #2193b0;
                box-shadow: 0 0 0 0.2rem rgba(33, 147, 176, 0.25);
            }

            .input-group {
                margin-bottom: 1.5rem;
            }

            .btn-primary {
                background: linear-gradient(135deg, #2193b0, #6dd5ed);
                border: none;
                border-radius: 10px;
                padding: 12px 30px;
                font-size: 1.1rem;
                font-weight: 600;
                letter-spacing: 1px;
                text-transform: uppercase;
                transition: all 0.3s ease;
                height: 50px;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #1c7a94, #5bc0de);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(33, 147, 176, 0.4);
            }

            .error-message, .success-message {
                display: none; /* Ẩn mặc định */
                margin-top: 15px;
                font-size: 0.9rem;
                padding: 10px;
                border-radius: 5px;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .error-message.show, .success-message.show {
                display: block;
                opacity: 1;
            }

            .error-message {
                color: #dc3545;
                background-color: rgba(220, 53, 69, 0.1);
            }

            .success-message {
                color: #28a745;
                background-color: rgba(40, 167, 69, 0.1);
            }

            .card-footer {
                background-color: transparent;
                border-top: 1px solid rgba(0, 0, 0, 0.1);
                border-radius: 0 0 15px 15px;
                padding: 1.5rem;
            }

            .card-footer a {
                color: #2193b0;
                font-weight: 600;
                text-decoration: none;
                margin-left: 8px;
                transition: all 0.3s ease;
            }

            .card-footer a:hover {
                color: #1c7a94;
                text-decoration: none;
            }

            /* Animation for form elements */
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

            .form-group {
                animation: fadeIn 0.5s ease forwards;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .container {
                    padding: 10px;
                }

                .card {
                    margin: 10px;
                }

                .card-header h3 {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="d-flex justify-content-center">
                <div class="card">
                    <div class="card-header text-center">
                        <h3><i class="fas fa-envelope-open-text mr-2"></i>Xác nhận Email của bạn</h3>
                    </div>
                    <div class="card-body">
                        <form action="forgotpassword" method="POST">
                            <div class="input-group form-group">
                                <input type="email" class="form-control" placeholder="Vui lòng nhập Email của bạn" name="email" required>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary btn-block" name="btAction">
                                    <i class="fas fa-paper-plane mr-2"></i>Xác nhận
                                </button>
                            </div>
                        </form>
                        <div id="errorMessage" class="error-message ${not empty error ? 'show' : ''}">${error}</div>
                        <div id="successMessage" class="success-message ${not empty message ? 'show' : ''}">${message}</div>
                    </div>
                    <div class="card-footer text-center">
                        <div class="d-flex justify-content-center align-items-center">
                            <i class="fas fa-arrow-left mr-2"></i>Trở về đăng nhập<a href="${pageContext.request.contextPath}/login">Tại đây!</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Hàm xử lý hiển thị và ẩn thông báo
                function handleMessage(messageElement) {
                    if (messageElement && messageElement.textContent.trim() !== '') {
                        messageElement.classList.add('show');

                        // Tự động ẩn sau 3 giây
                        setTimeout(function () {
                            messageElement.classList.remove('show');
                            // Xóa nội dung sau khi ẩn
                            setTimeout(function () {
                                messageElement.textContent = '';
                            }, 300); // đợi animation kết thúc
                        }, 3000);
                    }
                }

                // Xử lý thông báo lỗi
                const errorMessage = document.getElementById('errorMessage');
                handleMessage(errorMessage);

                // Xử lý thông báo thành công
                const successMessage = document.getElementById('successMessage');
                handleMessage(successMessage);
            });
        </script>
    </body>
</html>