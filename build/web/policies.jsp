<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chính sách & Điều khoản | Motorbike Rental</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary: #4f46e5;
                --primary-dark: #4338ca;
                --secondary: #64748b;
                --background: #f8fafc;
                --surface: #ffffff;
                --text: #1e293b;
                --text-light: #64748b;
                --border: #e2e8f0;
                --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                background-color: var(--background);
                color: var(--text);
                line-height: 1.6;
            }

            .navbar {
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                padding: 1rem 2rem;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: var(--shadow);
            }

            .navbar-brand {
                color: white;
                text-decoration: none;
                font-size: 1.25rem;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .navbar-nav {
                display: flex;
                gap: 2rem;
                align-items: center;
                list-style: none;
            }

            .nav-link {
                color: white;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                opacity: 0.9;
                transition: opacity 0.2s;
                font-weight: 500;
            }

            .nav-link:hover {
                opacity: 1;
            }

            .main-content {
                margin-top: 80px;
                padding: 2rem;
            }

            .policy-container {
                max-width: 1000px;
                margin: 0 auto;
                background: var(--surface);
                border-radius: 16px;
                box-shadow: var(--shadow);
                padding: 3rem;
            }

            .policy-header {
                text-align: center;
                margin-bottom: 3rem;
            }

            .policy-header h1 {
                font-size: 2.5rem;
                color: var(--primary);
                margin-bottom: 1rem;
            }

            .policy-header p {
                color: var(--text-light);
                font-size: 1.1rem;
            }

            .policy-section {
                margin-bottom: 2.5rem;
                padding: 1.5rem;
                border-radius: 12px;
                background: linear-gradient(to right, rgba(79, 70, 229, 0.05), transparent);
                transition: transform 0.3s ease;
            }

            .policy-section:hover {
                transform: translateX(10px);
            }

            .policy-section h2 {
                color: var(--primary);
                font-size: 1.5rem;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .policy-section p {
                color: var(--text);
                font-size: 1.1rem;
                line-height: 1.8;
            }

            .policy-icon {
                background: var(--primary);
                color: white;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
            }

            .contact-section {
                text-align: center;
                margin-top: 3rem;
                padding: 2rem;
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                border-radius: 12px;
                color: white;
            }

            .contact-section h3 {
                margin-bottom: 1rem;
                font-size: 1.5rem;
            }

            .contact-section p {
                font-size: 1.1rem;
                margin-bottom: 1.5rem;
            }

            .contact-button {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                background: white;
                color: var(--primary);
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 600;
                transition: transform 0.2s;
            }

            .contact-button:hover {
                transform: scale(1.05);
            }

            @media (max-width: 768px) {
                .navbar {
                    padding: 1rem;
                }

                .navbar-nav {
                    display: none;
                }

                .policy-container {
                    padding: 1.5rem;
                }

                .policy-section {
                    padding: 1rem;
                }

                .policy-header h1 {
                    font-size: 2rem;
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
        </nav>

        <main class="main-content">
            <div class="policy-container">
                <div class="policy-header">
                    <h1>Chính sách & Điều khoản</h1>
                    <p>Cam kết minh bạch và bảo vệ quyền lợi khách hàng</p>
                </div>

                <div class="policy-section">
                    <h2>
                        <div class="policy-icon"><i class="fas fa-id-card"></i></div>
                        Điều kiện thuê xe
                    </h2>
                    <p>Khách hàng phải từ 18 tuổi trở lên và có bằng lái xe hợp lệ để có thể thuê xe. Khách hàng cần cung cấp chứng minh nhân dân hoặc hộ chiếu, và giấy phép lái xe khi làm thủ tục thuê xe.</p>
                </div>

                <div class="policy-section">
                    <h2>
                        <div class="policy-icon"><i class="fas fa-shield-alt"></i></div>
                        Trách nhiệm của khách hàng
                    </h2>
                    <p>Khách hàng có trách nhiệm bảo quản xe và trang thiết bị đi kèm. Nếu xảy ra hư hỏng hoặc mất mát, khách hàng phải chịu trách nhiệm bồi thường. Trong quá trình sử dụng, khách hàng không được cho thuê lại xe cho bên thứ ba.</p>
                </div>

                <div class="policy-section">
                    <h2>
                        <div class="policy-icon"><i class="fas fa-money-bill-wave"></i></div>
                        Chính sách thanh toán và hủy booking
                    </h2>
                    <p>Khách hàng cần thanh toán đầy đủ chi phí thuê xe trước khi nhận xe. Trong trường hợp hủy booking, khách hàng cần thông báo trước 24 giờ để được hoàn trả 50% số tiền đã thanh toán. Nếu hủy trong vòng 24 giờ trước giờ thuê, phí sẽ không được hoàn trả.</p>
                </div>

                <div class="policy-section">
                    <h2>
                        <div class="policy-icon"><i class="fas fa-clock"></i></div>
                        Phí phụ thu và phí trễ hạn
                    </h2>
                    <p>Khách hàng sẽ chịu phí phụ thu nếu trả xe muộn so với thời gian đã thỏa thuận. Mức phí phụ thu sẽ tính theo giờ và được thông báo tại thời điểm thuê xe. Ngoài ra, các trường hợp vi phạm quy định hợp đồng có thể chịu các khoản phí bổ sung.</p>
                </div>

                <div class="contact-section">
                    <h3>Bạn còn thắc mắc?</h3>
                    <p>Đội ngũ hỗ trợ của chúng tôi luôn sẵn sàng giải đáp mọi câu hỏi của bạn</p>
                    <a href="mailto:support@motorbikerental.com" class="contact-button">
                        <i class="fas fa-envelope"></i>
                        Liên hệ hỗ trợ
                    </a>
                </div>
            </div>
        </main>
    </body>
</html>