<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hợp đồng cho thuê xe máy</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 210mm;
                margin: 0 auto;
                background: white;
                padding: 40px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }
            .header {
                text-align: center;
                margin-bottom: 30px;
            }
            h1 {
                color: #1a365d;
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 10px;
            }
            h2 {
                color: #2c5282;
                font-size: 20px;
                margin: 20px 0;
            }
            h3 {
                color: #2d3748;
                font-size: 18px;
                margin: 15px 0;
                padding-bottom: 5px;
                border-bottom: 2px solid #e2e8f0;
            }
            .content {
                line-height: 1.6;
            }
            .content p {
                margin-bottom: 12px;
                color: #4a5568;
            }
            .content ul {
                margin-left: 20px;
                margin-bottom: 15px;
            }
            .content ul li {
                margin-bottom: 8px;
                color: #4a5568;
            }
            .signatures {
                margin-top: 40px;
                display: flex;
                justify-content: space-between;
                padding-top: 20px;
                border-top: 1px solid #e2e8f0;
            }
            .signatures div {
                width: 45%;
                text-align: center;
            }
            .button-container {
                display: flex;
                gap: 10px;
                justify-content: center;
                margin-top: 20px;
            }
            .button {
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .download-btn {
                background-color: #2b6cb0;
                color: white;
            }
            .download-btn:hover {
                background-color: #2c5282;
            }
            .home-btn {
                background-color: #48bb78;
                color: white;
            }
            .home-btn:hover {
                background-color: #38a169;
            }
            .contract-info {
                background-color: #f7fafc;
                padding: 15px;
                border-radius: 6px;
                margin: 10px 0;
            }
            @media print {
                .button-container {
                    display: none;
                }
            }
        </style>
    </head>
    <body>
        <div class="container" id="contract">
            <div class="header">
                <h1>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</h1>
                <p>Độc lập – Tự do – Hạnh phúc</p>
                <div class="border-b-2 w-32 mx-auto my-4"></div>
                <h2>HỢP ĐỒNG CHO THUÊ XE MÁY</h2>
                <p>Số: …… – ……./HĐTX</p>
            </div>

            <div class="content">
                <div class="contract-info">
                    <p>– Căn cứ Bộ Luật Dân sự 2015;</p>
                    <p>– Căn cứ Luật thương mại 2005;</p>
                    <p>– Căn cứ vào nhu cầu và khả năng cung ứng của các bên dưới đây.</p>
                    <p>Hôm nay ngày …. tháng …. năm ……. tại ……………………………………. chúng tôi gồm:</p>
                </div>

                <h3>BÊN CHO THUÊ (Bên A)</h3>
                <div class="contract-info">
                    <p>Công ty : Motorbike Rental Service Portal.</p>
                    <p>Địa chỉ : Thạch Thất - Hà Nội.</p>
                    <p>Số điện thoại: 09417.76861.</p>
                </div>

                <h3>BÊN THUÊ (Bên B)</h3>
                <div class="contract-info">
                    <p>Ông/bà: ${requestScope.booking.name}.</p>
                    <p>Địa chỉ thường trú: ${requestScope.booking.address}.</p>
                    <p>Số điện thoại: ${requestScope.booking.phone_number}.</p>
                    <p>CMND/CCCD/Hộ chiếu: ${requestScope.booking.idNumber}.</p>
                    <p>Giấy phép lái xe: ${requestScope.booking.licenseNumber}.</p>
                </div>

                <h3>Điều 1. Đặc điểm và thỏa thuận thuê xe</h3>
                <div class="contract-info">
                    <p>Bên A đồng ý cho Bên B thuê và Bên B đồng ý thuê xe máy có đặc điểm sau đây:</p>
                    <c:forEach items="${requestScope.list}" var="m">
                        <ul>
                            <li>Nhãn hiệu: ${m.value.model}.</li>
                            <li>Màu Sơn: ${m.value.color}.</li>
                            <li>Giá thuê: ${m.value.dailyRate}VNĐ/ngày.</li>
                            <li>Biển kiểm soát số: ${m.value.licensePlate}.</li>
                        </ul>
                    </c:forEach>
                </div>

                <h3>Điều 2. Thời hạn thuê xe máy</h3>
                <div class="contract-info">
                    <p>Thời hạn thuê: từ ngày ${requestScope.booking.startDate} đến ngày ${requestScope.booking.endDate}</p>
                    <p>Tổng số ngày thuê : ${requestScope.days}.</p>
                </div>

                <!-- Các điều khoản tiếp theo giữ nguyên cấu trúc tương tự -->

                <div class="signatures">
                    <div>
                        <p>ĐẠI DIỆN BÊN A</p>
                        <p>(Ký và ghi rõ họ tên)</p>
                    </div>
                    <div>
                        <p>ĐẠI DIỆN BÊN B</p>
                        <p>(Ký và ghi rõ họ tên)</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="button-container">
            <button class="button home-btn" onclick="window.location.href = 'home'">
                Home Page
            </button>
            <button class="button download-btn" id="download">
                Tải hợp đồng (PDF)
            </button>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
        <script>
                document.getElementById("download").addEventListener("click", function () {
                    const element = document.getElementById('contract');
                    const opt = {
                        margin: 1,
                        filename: 'hop-dong-thue-xe.pdf',
                        image: {type: 'jpeg', quality: 0.98},
                        html2canvas: {scale: 2},
                        jsPDF: {unit: 'mm', format: 'a4', orientation: 'portrait'}
                    };
                    html2pdf().set(opt).from(element).save();
                });
        </script>
    </body>
</html>