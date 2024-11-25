<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Motorbike</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-image: url("https://motogo.vn/wp-content/uploads/2021/06/thue-xe-may-da-lat-4.jpg");
                background-size: cover;
                background-position: center;
                margin: 0;
                padding: 0;
            }
            .container {
                background-color: rgba(255, 255, 255, 0.9);
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
                padding: 20px;
                width: 800px;
                margin: 50px auto;
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
                padding: 10px;
                background-color: #4CAF50;
                color: white;
                border-radius: 5px;
            }
            .form-row {
                display: flex;
                justify-content: space-between; /* Căn chỉnh đều */
                margin-bottom: 15px;
            }
            .form-group {
                width: 30%; /* Chiều rộng mỗi trường */
                margin-right: 10px; /* Khoảng cách giữa các trường */
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            input[type="text"],
            input[type="number"],
            select {
                width: 100%; /* Chiều rộng ô nhập liệu */
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                transition: border-color 0.3s;
            }
            input[type="text"]:focus,
            input[type="number"]:focus,
            select:focus {
                border-color: #4CAF50;
                outline: none;
            }
            input[type="submit"] {
                width: 100%;
                padding: 10px;
                border: none;
                border-radius: 4px;
                background-color: #4CAF50;
                color: white;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            input[type="submit"]:hover {
                background-color: #45a049;
            }
            .error-message {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <c:choose>
                <c:when test="${not empty motorbike}">
                    <h1>Cập nhật xe máy</h1>
                </c:when>
                <c:otherwise>
                    <h1>Tạo xe mới</h1>
                </c:otherwise>
            </c:choose>

            <c:if test="${not empty motorbike}">
                <form action="editmotorbike" method="post">
                    <input type="hidden" name="id" value="${motorbike.motorbikeId}">

                    <div class="form-row">
                        <div class="form-group">
                            <label for="type_id">Loại xe:</label>
                            <select name="type_id" required>
                                <c:forEach items="${motorbikeTypes}" var="type">
                                    <option value="${type.typeId}" ${type.typeId == motorbike.typeId ? 'selected' : ''}>${type.typeName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="model">Tên xe:</label>
                            <input type="text" name="model" value="${motorbike.model}" required>
                        </div>
                        <div class="form-group">
                            <label for="brand">Hãng xe:</label>
                            <input type="text" name="brand" value="${motorbike.brand}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="year">Năm sản xuất:</label>
                            <input type="number" name="year" value="${motorbike.year}" required>
                        </div>
                        <div class="form-group">
                            <label for="dailyRate">Giá thuê/Ngày:</label>
                            <input type="number" step="0.01" name="dailyRate" value="${motorbike.dailyRate}" required>
                        </div>
                        <div class="form-group">
                            <label for="status">Trạng thái:</label>
                            <input type="text" name="status" value="${motorbike.status}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="licensePlate">Biển số xe:</label>
                            <input type="text" name="licensePlate" value="${motorbike.licensePlate}" required>
                        </div>
                        <div class="form-group">
                            <label for="color">Màu sắc:</label>
                            <input type="text" name="color" value="${motorbike.color}" required>
                        </div>
                        <div class="form-group">
                            <label for="engineSize">Dung tích xi-lanh:</label>
                            <input type="text" name="engineSize" value="${motorbike.engineSize}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="fuelType">Nhiên liệu:</label>
                            <input type="text" name="fuelType" value="${motorbike.fuelType}" required>
                        </div>
                        <div class="form-group">
                            <label for="imageUrl">Ảnh:</label>
                            <input type="text" name="imageUrl" value="${motorbike.imageUrl}">
                        </div>
                        <div class="form-group">
                            <label for="mileage">Số km đã đi:</label>
                            <input type="number" name="mileage" value="${motorbike.mileage}" required>
                        </div>
                    </div>

                    <input type="submit" value="Update">
                </form>
            </c:if>

            <c:if test="${empty motorbike}">
                <form action="createmotorbike" method="POST">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="type_id">Loại xe:</label>
                            <select name="type_id" required>
                                <c:forEach items="${motorbikeTypes}" var="type">
                                    <option value="${type.typeId}">${type.typeName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="model">Tên xe:</label>
                            <input type="text" name="model" required>
                        </div>
                        <div class="form-group">
                            <label for="brand">Hãng xe:</label>
                            <input type="text" name="brand" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="year">Năm sản xuất:</label>
                            <input type="number" name="year" required>
                        </div>
                        <div class="form-group">
                            <label for="dailyRate">Giá thuê/Ngày:</label>
                            <input type="number" step="0.01" name="dailyRate" required>
                        </div>
                        <div class="form-group">
                            <label for="status">Trạng thái:</label>
                            <input type="text" name="status" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="licensePlate">Biển số xe:</label>
                            <input type="text" name="licensePlate" required>
                        </div>
                        <div class="form-group">
                            <label for="color">Màu sắc:</label>
                            <input type="text" name="color" required>
                        </div>
                        <div class="form-group">
                            <label for="engineSize">Dung tích xi-lanh:</label>
                            <input type="text" name="engineSize" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="fuelType">Nhiên liệu:</label>
                            <input type="text" name="fuelType" required>
                        </div>
                        <div class="form-group">
                            <label for="imageUrl">Ảnh:</label>
                            <input type="text" name="imageUrl">
                        </div>
                        <div class="form-group">
                            <label for="mileage">Số km đã đi:</label>
                            <input type="number" name="mileage" required>
                        </div>
                    </div>

                    <input type="submit" value="Tạo">
                </form>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>
        </div>
    </body>
</html>
