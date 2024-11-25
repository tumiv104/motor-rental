<%-- 
    Document   : createmotorbike
    Created on : Nov 6, 2024, 8:39:27 PM
    Author     : hungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .form-container {
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
            }
            .form-group input, .form-group select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .error-message {
                color: red;
                margin-top: 5px;
                font-size: 14px;
            }
            .success-message {
                color: green;
                margin-top: 5px;
                font-size: 14px;
            }
            button[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            button[type="submit"]:hover {
                background-color: #45a049;
            }
        </style>
    </head>
</head>
<body>
    <div class="form-container">
        <h1>Create New Motorbike</h1>

        

        <form action="createmotorbike" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label>Motorbike Type: <span style="color: red;">*</span></label>
                <select name="type_id" required>
                    <option value="">Select motorbike type</option>
                    <c:forEach items="${motorbikeTypes}" var="type">
                        <option value="${type.typeId}">${type.typeName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>Model: <span style="color: red;">*</span></label>
                <input type="text" name="model" required>
            </div>

            <div class="form-group">
                <label>Brand: <span style="color: red;">*</span></label>
                <input type="text" name="brand" required>
            </div>

            <div class="form-group">
                <label>Year: <span style="color: red;">*</span></label>
                <input type="number" name="year" required min="2010" max="2024"
                       value="2024">
            </div>

            <div class="form-group">
                <label>Daily Rate (VND): <span style="color: red;">*</span></label>
                <input type="number" step="1000" name="daily_rate" required min="0">
            </div>

            <div class="form-group">
                <label>License Plate: <span style="color: red;">*</span></label>
                <input type="text" name="license_plate" required 
                       pattern="[0-9]{2}[A-Z]{1}[0-9]{4,5}"
                       title="License plate format: 59A12345">
            </div>

            <div class="form-group">
                <label>Fuel Type: <span style="color: red;">*</span></label>
                <select name="fuel_type" required>
                    <option value="">Select fuel type</option>
                    <option value="RON95">RON 95</option>
                    <option value="RON92">RON 92</option>
                    <option value="E5RON92">E5 RON 92</option>
                </select>
            </div>

            <div class="form-group">
                <label>Mileage (km):</label>
                <input type="number" name="mileage" min="0">
            </div>

            <div class="form-group">
                <label>Color:</label>
                <input type="text" name="color">
            </div>

            <div class="form-group">
                <label>Engine Size (cc):</label>
                <input type="text" name="engine_size">
            </div>

            <div class="form-group">
                <label>Image URL:</label>
                <input type="url" name="image_url">
            </div>

            <input type="hidden" name="type_id" value="1">

            <button type="submit">Create Motorbike</button>
        </form>
        <a href="home">home</a>
    </div>

    <script>
        function validateForm() {
            const year = document.getElementsByName('year')[0].value;
            const currentYear = new Date().getFullYear();

            if (year < 2010 || year > currentYear) {
                alert('Year must be between 2010 and ' + currentYear);
                return false;
            }

            const licensePlate = document.getElementsByName('license_plate')[0].value;
            const licensePlatePattern = /^[0-9]{2}[A-Z]{1}[0-9]{4,5}$/;
            if (!licensePlatePattern.test(licensePlate)) {
                alert('License plate must be in format: 59A12345');
                return false;
            }

            const dailyRate = document.getElementsByName('daily_rate')[0].value;
            if (dailyRate <= 0) {
                alert('Daily rate must be greater than 0');
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
