<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thay Đổi Xe</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f8;
                color: #333;
                margin: 0;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            form {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                max-width: 600px;
                width: 100%;
            }

            label {
                font-weight: bold;
                margin-top: 10px;
                display: block;
                color: #555;
            }

            select, textarea, input[type="file"] {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 1em;
                box-sizing: border-box;
            }

            button {
                background-color: #3498db;
                color: #ffffff;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                font-size: 1em;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease;
                width: 100%;
                margin-top: 10px;
            }

            button:hover {
                background-color: #2980b9;
            }

            .success-message {
                text-align: center;
                font-weight: bold;
                color: #27ae60;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <form action="checkmotorbikechange" method="POST" enctype="multipart/form-data">
            <label>Mã đơn hàng:</label> ${requestScope.booking.code} <br>
            
            <label for="vehicle">Loại xe:</label>
            <select name="motorbike" id="vehicle">
                <c:forEach items="${requestScope.motorbikes}" var="m">
                    <option value="${m.motorbikeId}">${m.model} - ${m.licensePlate}</option>
                </c:forEach>
            </select>

            <label for="vehicleCondition">Mô tả thay đổi:</label>
            <textarea id="vehicleCondition" name="description" rows="4" placeholder="Nhập thông tin thay đổi về tình trạng xe..."></textarea>

            <label for="images">Tải lên ảnh mô tả thay đổi:</label>
            <input type="file" name="images" accept="image/*" multiple required> 
            
            <input type="hidden" name="bid" id="bookid" value="${requestScope.booking.bookingId}">
            <button type="submit">Xác nhận</button>
        </form>

        <c:if test="${requestScope.check ne null}">
            <script>
                Swal.fire({
                    title: 'Thành công!',
                    text: 'Cập nhật thành công! Bạn có muốn tiếp tục?',
                    icon: 'info',
                    showCancelButton: true,
                    confirmButtonText: 'Tiếp tục',
                    cancelButtonText: 'Thoát'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'checkmotorbikechange?bid=' + ${requestScope.check};
                    } else if (result.isDismissed) {
                        window.location.href = 'home';
                    }
                });
            </script>
        </c:if>
    </body>
</html>
