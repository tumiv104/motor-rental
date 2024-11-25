<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f8f9fa;
            }
            .notification-container {
                display: flex;
                justify-content: center;
                margin-bottom: 15px;
            }
            .notification {
                width: 100%;
                max-width: 600px;
                background-color: #f8d7da; /* Nền màu hồng nhạt */
                color: #721c24; /* Màu chữ đỏ */
                border: 1px solid #f5c6cb;
                border-radius: 0.25rem;
                padding: 15px; /* Tăng độ rộng padding */
                text-align: center;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Thêm bóng để nổi bật */
                font-size: 1.1em; /* Tăng kích thước chữ */
            }
            .successMessage {
                width: 100%;
                max-width: 600px;
                background-color: #d4edda; /* Nền màu xanh nhạt */
                color: #155724; /* Màu chữ xanh đậm */
                border: 1px solid #c3e6cb;
                border-radius: 0.25rem;
                padding: 15px;
                text-align: center;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                font-size: 1.1em;
            }
        </style>
    </head>

    <body>

        <c:set var="cookie" value="${pageContext.request.cookies}" />

        <section class="py-3 py-md-5 py-xl-8">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="mb-5">
                            <h2 class="display-5 fw-bold text-center">Đăng nhập</h2>
                            <p class="text-center m-0">Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/signup">Đăng ký</a></p>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-12 col-lg-10 col-xl-8">
                        <div class="row gy-5 justify-content-center">
                            <div class="col-12 col-lg-5">
                                <form action="login" method="POST">
                                    <div class="row gy-3 overflow-hidden">
                                        <div class="col-12">
                                            <div class="input-group form-group">
                                                <div class="input-group-prepend">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                                <input type="text" class="form-control" placeholder="Tên đăng nhập" name="txtUsername" value="${cookie.cUser.value}" required>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="input-group form-group">
                                                <div class="input-group-prepend">
                                                    <i class="fas fa-key"></i>
                                                </div>
                                                <input type="password" class="form-control" placeholder="Mật khẩu" name="txtPassword" value="${cookie.cPass.value}" required>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="row justify-content-between">
                                                <div class="col-6">
                                                    <div class="form-check">
                                                        <input type="checkbox" name="remember" ${cookie.cRem != null ? 'checked' : ''}>
                                                        <label class="form-check-label text-secondary" for="remember_me">
                                                            Nhớ tài khoản
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="text-end">
                                                        <a href="${pageContext.request.contextPath}/forgotpassword" class="link-secondary text-decoration-none">Quên mật khẩu?</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="d-grid">
                                                <button class="btn btn-primary btn-lg" type="submit">Đăng nhập</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="col-12 col-lg-2 d-flex align-items-center justify-content-center gap-3 flex-lg-column">
                                <div class="bg-dark h-100 d-none d-lg-block" style="width: 1px; --bs-bg-opacity: .1;"></div>
                                <div class="bg-dark w-100 d-lg-none" style="height: 1px; --bs-bg-opacity: .1;"></div>
                                <div>or</div>
                                <div class="bg-dark h-100 d-none d-lg-block" style="width: 1px; --bs-bg-opacity: .1;"></div>
                                <div class="bg-dark w-100 d-lg-none" style="height: 1px; --bs-bg-opacity: .1;"></div>
                            </div>
                            <div class="col-12 col-lg-5 d-flex align-items-center">
                                <div class="d-flex gap-3 flex-column w-100">
                                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/clone/login&response_type=code&client_id=159004363444-blcgr3ealcvg50u1s3qecctk0mmldo36.apps.googleusercontent.com&approval_prompt=force" class="btn btn-lg btn-danger">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-google" viewBox="0 0 16 16">
                                        <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                                        </svg>
                                        <span class="ms-2 fs-6">Đăng nhập với Google</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Notification Messages -->
                <c:if test="${not empty notification}">
                    <div class="notification-container">
                        <div class="notification alert alert-danger">
                            <span>${notification}</span>
                        </div>
                    </div>
                    <%
                        session.removeAttribute("notification"); // Xóa thông báo sau khi hiển thị
                    %>
                </c:if>

                <c:if test="${not empty mess1}">
                    <div class="notification-container">
                        <div class="notification alert alert-danger">
                            <span>${mess1}</span>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="notification-container">
                        <div class="notification alert alert-danger">
                            <span>${error}</span>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty successMessage}">
                    <div class="notification-container">
                        <div class="successMessage alert alert-success">
                            <span>${successMessage}</span>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>

        <script>
            setTimeout(function () {
                var notificationContainers = document.querySelectorAll('.notification-container');
                notificationContainers.forEach(function (container) {
                    container.remove();
                });
            }, 3000); // 3000ms = 3s
        </script>                                       

        <script>
            // Tự động ẩn thông báo sau 3 giây
            setTimeout(function () {
                var notificationContainers = document.querySelectorAll('.notification-container');
                notificationContainers.forEach(function (container) {
                    container.remove();
                });
            }, 3000);
        </script>
    </body>
</html>
