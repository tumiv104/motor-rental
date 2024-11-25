<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            :root {
                --primary-color: #1b6631;
                --secondary-color: #3498db;
                --accent-color: #e74c3c;
                --background-color: #f5f7fa;
                --success-color: #2ecc71;
                --warning-color: #f1c40f;
            }
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
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .payment-form {
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

            .payment-form::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: linear-gradient(45deg, var(--secondary-color), var(--primary-color));
            }

            .payment-form:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            }
            h1, h3 {
                text-align: center;
                color: #333;
            }

            button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px;
                cursor: pointer;
                font-size: 16px;
                border-radius: 5px;
            }
            button:hover {
                background-color: #218838;
            }
            .input-field {
                margin: 20px 0;
            }
            .promotion_info {
                margin-top: 30px;
                border-top: 1px solid rgba(0, 0, 0, 0.1);
            }
            #promolist-button {
                margin-top: 30px;
                width: 40%;
            }
            .promotion {
                background-color: #f8f9fa;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 10px;
                margin: 10px 0;
                display: none;
                width: 75%;
            }
            .promo-button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                margin-top: 5px;
                border-radius: 3px;
                width: 20%
            }
            .promo-button:hover {
                background-color: #0056b3;
            }
            .payment-container {
                padding-top: 100px;
                padding-bottom: 50px;
                animation: fadeIn 0.5s ease;
            }
            .payment {
                margin-top: 5px;
                border-top: 1px solid rgba(0, 0, 0, 0.1);
            }
            .payment_method {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
                justify-content: flex-start;
            }
            .payment-method input[type="radio"] {
                margin-left: 10px;
            }
            .payment-button {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .payment-button:hover {
                background-color: #45a049;
            }
            .input-field {
                display: flex;
            }

            .input-field input[type="checkbox"] {
                margin-right: 5px;
            }

            .input-field label {
                margin: 0;
                width: 100%;
            }
            .terms-container {
                max-width: 800px;
                margin: auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .terms-container h3 {
                color: #333;
                text-align: center;
                font-size: 2em;
                margin-bottom: 20px;
            }
            .terms-container h4 {
                color: #333;
                margin-top: 20px;
                font-size: 1.5em;
            }
            .terms-container p {
                margin: 10px 0;
                font-size: 1em;
                line-height: 1.6;
            }
            .terms-container ul {
                list-style-type: disc;
                padding-left: 20px;
                margin: 10px 0;
            }
            .terms-container li {
                margin: 5px 0;
            }
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                overflow: auto;
            }
            .modal-content {
                background-color: #fff;
                margin: 5% auto;
                padding: 25px;
                border-radius: 10px;
                max-width: 700px;
                position: relative;
            }
            .close {
                position: absolute;
                top: 10px;
                right: 10px;
                font-size: 24px;
                cursor: pointer;
            }
            .close:hover {
                color: red;
            }
            .arrow-icon {
                font-size: 16px;
                margin-left: 10px;
            }
            /* Responsive */
            @media (max-width: 768px) {
                form {
                    padding: 20px;
                }
                .modal-content {
                    width: 90%;
                }
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
                    <li class="nav-item"><a class="nav-link" href="profile"><i class="fas fa-user mr-1"></i> Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Review</a></li>
                        <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="login"><i class="fas fa-sign-in-alt mr-1"></i> Đăng nhập</a></li>
                        </c:if>
                </ul>
            </div>
        </nav>
        <div class="payment-container">
            <form action="payment" method="POST" class="payment-form">
                <div>
                    <h1><i class="fas fa-calendar-alt mr-2"></i>Thông tin thanh toán</h1> <br>
                    <p><strong>Họ và tên : </strong>${sessionScope.booking.name}</p>
                    <p><strong>Email : </strong>${sessionScope.booking.email}</p>
                    <p><strong>Số điện thoại : </strong>${sessionScope.booking.phone_number}</p> 
                    <p><strong>Ngày nhận xe : </strong>${sessionScope.booking.startDate}</p> 
                    <p><strong>Ngày trả xe : </strong>${sessionScope.booking.endDate}</p> 
                    <p><strong>Tổng số ngày thuê : </strong>${sessionScope.days}</p> 
                    <p><strong>Địa chỉ nhận xe : </strong>${sessionScope.booking.pickupLocation}</p> 
                    <p><strong>Địa chỉ trả xe : </strong>${sessionScope.booking.dropoffLocation}</p> 
                    <p><strong>Tiền cọc : </strong><fmt:formatNumber value="${sessionScope.deposit}" maxFractionDigits="0"/> VND</p> 
                    <div id="total_cost"><strong>Tiền thuê : </strong><fmt:formatNumber value="${sessionScope.total_cost * sessionScope.days}" maxFractionDigits="0"/> VND</div>
                </div>
                <div class="promotion_info">
                    <button id="promolist-button" type="button">
                        Sử dụng mã giảm giá <span id="arrow" class="arrow-icon">▼</span>
                    </button> <br>
                    <c:forEach items="${requestScope.promotions}" var="p">
                        <div class="promotion">
                            ${p.description} <br>
                            Mã : ${p.promoCode} <br>
                            HSD : ${p.endDate}
                            <button class="promo-button" id="${p.promotionId}" type="button" value="${p.promotionId}">Áp dụng</button>
                        </div>
                    </c:forEach>
                </div>
                <input type="hidden" name="proid" id="promo_val" value="">
                <div class="payment">
                    <h3 style="text-align: left; margin-top: 20px">Chọn phương thức thanh toán</h3> <br>
                    <c:forEach items="${requestScope.methods}" var="m">
                        <div class="payment_method">
                            <c:if test="${m.code == 'def'}">
                                <input type="radio" name="payment_method" value="${m.code}" checked> 
                                <img src="${m.image_url}" alt="alt" width="50" height="50">
                                Thanh toán khi nhận xe <br>
                            </c:if>
                            <c:if test="${m.code != 'def'}">
                                <input type="radio" name="payment_method" value="${m.code}">
                                <img src="${m.image_url}" alt="alt" width="50" height="50">
                                Thanh toán qua ${m.method_name} <br>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
                <div class="input-field">
                    <input type="checkbox" id="acceptTerms" name="acceptTerms" required>
                    <label for="acceptTerms">Tôi đồng ý với <a href="javascript:void(0)" id="showTerms">điều khoản dịch vụ và chính sách thanh toán</a></label>
                </div>
                <div id="termsModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <div class="terms-container">
                            <h3>Điều Khoản Dịch Vụ Cho Thuê Xe Máy</h3>

                            <p>Chào mừng quý khách đến với dịch vụ cho thuê xe máy của chúng tôi. Xin vui lòng đọc kỹ các điều khoản và điều kiện sau đây trước khi sử dụng dịch vụ.</p>

                            <h4>1. Chính Sách Thuê Xe</h4>
                            <p>Khách hàng cần đáp ứng các yêu cầu sau để có thể thuê xe:</p>
                            <ul>
                                <li>Độ tuổi tối thiểu là 18 tuổi.</li>
                                <li>Khách hàng phải cung cấp giấy tờ tùy thân hợp lệ và giấy phép lái xe.</li>
                                <li>Thanh toán tiền đặt cọc theo quy định của chúng tôi.</li>
                            </ul>

                            <h4>2. Trách Nhiệm Của Người Thuê</h4>
                            <p>Khi thuê xe, khách hàng có trách nhiệm:</p>
                            <ul>
                                <li>Sử dụng xe đúng mục đích và tuân thủ luật giao thông.</li>
                                <li>Chăm sóc và bảo vệ xe tránh khỏi hư hại hoặc mất mát.</li>
                                <li>Trả xe đúng thời hạn và trong tình trạng ban đầu.</li>
                            </ul>

                            <h4>3. Quyền Lợi và Trách Nhiệm Của Dịch Vụ</h4>
                            <ul>
                                <li>Chúng tôi cung cấp xe an toàn và đã được kiểm tra định kỳ.</li>
                                <li>Cam kết hỗ trợ khách hàng trong trường hợp xe gặp sự cố kỹ thuật.</li>
                                <li>Quyền từ chối phục vụ khách hàng không đáp ứng đủ yêu cầu.</li>
                            </ul>

                            <h4>4. Chính Sách Hủy Đặt Xe</h4>
                            <p>Trong trường hợp khách hàng muốn hủy đặt xe, xin vui lòng thông báo trước ít nhất 24 giờ để tránh mất phí hủy. Các khoản phí hủy như sau:</p>
                            <ul>
                                <li>Hủy trước 24 giờ: không tính phí.</li>
                                <li>Hủy trong vòng 24 giờ: phí hủy 50% tổng chi phí thuê.</li>
                                <li>Không thông báo hủy: phí hủy 100% tổng chi phí thuê.</li>
                            </ul>

                            <h4>5. Điều Khoản Bồi Thường</h4>
                            <p>Khách hàng chịu trách nhiệm bồi thường chi phí sửa chữa nếu có hư hại phát sinh trong thời gian sử dụng. Chúng tôi sẽ kiểm tra và thông báo chi tiết các khoản phí nếu có.</p>

                            <h4>6. Chính Sách Bảo Mật</h4>
                            <p>Thông tin cá nhân của khách hàng sẽ được bảo mật tuyệt đối và chỉ sử dụng cho mục đích liên quan đến giao dịch thuê xe.</p>

                            <h4>7. Sửa Đổi Điều Khoản</h4>
                            <p>Chúng tôi có quyền sửa đổi các điều khoản dịch vụ này. Bất kỳ thay đổi nào sẽ được thông báo trên trang web, và khách hàng có trách nhiệm theo dõi các thay đổi này.</p>

                            <p>Cảm ơn quý khách đã tin tưởng sử dụng dịch vụ của chúng tôi!</p>
                        </div>
                    </div>
                </div>

                <input type="submit" value="Xác nhận thanh toán" class="payment-button">
            </form>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            // Modal handling for terms of service
            var modal = document.getElementById("termsModal");
            var btn = document.getElementById("showTerms");
            var span = document.getElementsByClassName("close")[0];
            btn.onclick = function () {
                modal.style.display = "block";
            };
            span.onclick = function () {
                modal.style.display = "none";
            };
            window.onclick = function (event) {
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };

            // Show/hide promotion list
            $(document).ready(function () {
                $("#promolist-button").click(function () {
                    $(".promotion").toggle();
                    if ($(".promotion").is(":visible")) {
                        $("#arrow").text("▲");
                    } else {
                        $("#arrow").text("▼");
                    }
                });

                // Apply promotion and recalculate total cost
                $(".promo-button").click(function () {
                    var promo_id = $(this).val();
                    $("#promo_val").val(promo_id);
                    var action;
                    if ($("#" + promo_id).text() === "Áp dụng") {
                        $(".promo-button").text("Áp dụng");
                        $("#" + promo_id).text("Bỏ chọn");
                        action = 1;
                    } else if ($("#" + promo_id).text() === "Bỏ chọn") {
                        $("#" + promo_id).text("Áp dụng");
                        action = 0;
                    }
                    $.ajax({
                        url: "/clone/promocalc",
                        type: "get",
                        data: {
                            promo_id: promo_id,
                            action: action
                        },
                        success: function (data) {
                            $('#total_cost').empty();
                            $('#total_cost').html(data);
                        },
                        error: function (xhr) {
                            console.error("Error while applying promo.");
                        }
                    });
                });
            });
        </script>
    </body>
</html>
