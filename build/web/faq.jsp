<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Câu Hỏi Thường Gặp | Motorbike Rental</title>
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

            .faq-container {
                max-width: 800px;
                margin: 0 auto;
                background: var(--surface);
                border-radius: 16px;
                box-shadow: var(--shadow);
                padding: 3rem;
            }

            .faq-header {
                text-align: center;
                margin-bottom: 3rem;
            }

            .faq-header h1 {
                font-size: 2.5rem;
                color: var(--primary);
                margin-bottom: 1rem;
            }

            .faq-header p {
                color: var(--text-light);
                font-size: 1.1rem;
            }

            .faq-item {
                margin-bottom: 1.5rem;
                border-radius: 12px;
                overflow: hidden;
                background: white;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                transition: transform 0.3s ease;
            }

            .faq-item:hover {
                transform: translateX(10px);
            }

            .faq-question {
                padding: 1.5rem;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: space-between;
                font-size: 1.1rem;
                color: var(--text);
                font-weight: 500;
                background: linear-gradient(to right, rgba(79, 70, 229, 0.05), transparent);
            }

            .faq-question i {
                color: var(--primary);
                transition: transform 0.3s ease;
            }

            .faq-answer {
                padding: 0;
                max-height: 0;
                overflow: hidden;
                transition: all 0.3s ease;
                background-color: white;
            }

            .faq-answer p {
                padding: 1.5rem;
                margin: 0;
            }

            .faq-item.active .faq-question {
                color: var(--primary);
            }

            .faq-item.active .faq-question i {
                transform: rotate(180deg);
            }

            .faq-item.active .faq-answer {
                max-height: 200px;
                border-top: 1px solid var(--border);
            }

            .search-box {
                position: relative;
                margin-bottom: 2rem;
            }

            .search-box input {
                width: 100%;
                padding: 1rem 1.5rem;
                padding-left: 3rem;
                border: 2px solid var(--border);
                border-radius: 8px;
                font-size: 1rem;
                transition: border-color 0.3s ease;
                outline: none;
            }

            .search-box input:focus {
                border-color: var(--primary);
            }

            .search-box i {
                position: absolute;
                left: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--text-light);
            }

            @media (max-width: 768px) {
                .navbar {
                    padding: 1rem;
                }

                .navbar-nav {
                    display: none;
                }

                .faq-container {
                    padding: 1.5rem;
                }

                .faq-header h1 {
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
            <div class="faq-container">
                <div class="faq-header">
                    <h1>Câu Hỏi Thường Gặp</h1>
                    <p>Tìm hiểu thêm về dịch vụ thuê xe máy của chúng tôi</p>
                </div>

                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="faqSearch" placeholder="Tìm kiếm câu hỏi...">
                </div>

                <div class="faq-list">
                    <div class="faq-item">
                        <div class="faq-question">
                            Làm thế nào để thuê xe máy?
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="faq-answer">
                            <p>Bạn chỉ cần truy cập vào trang web của chúng tôi, chọn xe máy bạn muốn thuê, điền thông tin và thanh toán trực tuyến. Quy trình đơn giản và nhanh chóng chỉ trong vài phút.</p>
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            Có yêu cầu đặt cọc không?
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="faq-answer">
                            <p>Có, chúng tôi yêu cầu đặt cọc 1 triệu cho xe số, 2 triệu cho xe ga và 3 triệu cho xe tay côn để xác nhận đặt hàng. Tiền cọc sẽ được hoàn trả đầy đủ khi kết thúc thời gian thuê xe.</p>
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            Tôi có thể hủy đặt xe không?
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="faq-answer">
                            <p>Có, bạn có thể hủy đặt xe miễn phí trong vòng 24 giờ trước khi bắt đầu thuê xe. Sau thời gian này, chúng tôi sẽ giữ lại một phần phí đặt cọc.</p>
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            Có dịch vụ giao xe tận nơi không?
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="faq-answer">
                            <p>Có, chúng tôi cung cấp dịch vụ giao xe tận nơi với một khoản phí nhỏ. Phạm vi giao xe trong khu vực nội thành và có thể thỏa thuận cho các khu vực khác.</p>
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            Tôi có cần giấy phép lái xe không?
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="faq-answer">
                            <p>Có, bạn cần có giấy phép lái xe hợp lệ để thuê xe máy. Đây là yêu cầu bắt buộc theo quy định của pháp luật và để đảm bảo an toàn cho bạn.</p>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script>
            // Toggle FAQ answers
            document.querySelectorAll('.faq-question').forEach(question => {
                question.addEventListener('click', () => {
                    const item = question.parentElement;
                    item.classList.toggle('active');
                });
            });

            // Search functionality
            document.getElementById('faqSearch').addEventListener('input', function (e) {
                const searchText = e.target.value.toLowerCase();
                document.querySelectorAll('.faq-item').forEach(item => {
                    const question = item.querySelector('.faq-question').textContent.toLowerCase();
                    const answer = item.querySelector('.faq-answer').textContent.toLowerCase();

                    if (question.includes(searchText) || answer.includes(searchText)) {
                        item.style.display = 'block';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
        </script>
    </body>
</html>