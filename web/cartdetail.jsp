<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ hàng</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f0f4f8; /* Light background for contrast */
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 900px;
                margin: 30px auto;
                background-color: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
                animation: fadeIn 0.5s ease-in-out; /* Added animation */
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
            h1 {
                text-align: center;
                color: #2c3e50; /* Darker blue for contrast */
                margin-bottom: 20px;
                font-size: 2.5em; /* Increased font size */
                font-weight: bold;
            }
            .cart-item {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                padding: 15px;
                background-color: #ffffff; /* White background for items */
                border: 1px solid #e1e1e1;
                border-radius: 10px;
                transition: transform 0.2s, box-shadow 0.2s; /* Smooth transitions */
            }
            .cart-item:hover {
                transform: translateY(-3px); /* Lift effect on hover */
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }
            .cart-item img {
                width: 120px;
                height: 120px;
                border-radius: 8px;
                margin-right: 20px;
                border: 1px solid #ccc; /* Border around images */
            }
            .cart-item-details {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: center; /* Center content vertically */
            }
            .cart-item-details p {
                margin: 5px 0;
            }
            .cart-item-details p.model {
                font-weight: bold;
                font-size: 18px;
                color: #34495e; /* Soft dark color */
            }
            .cart-item-details p.price {
                color: #e67e22; /* Orange color for price */
                font-size: 20px;
                font-weight: bold;
            }
            .btn {
                padding: 10px 15px;
                background-color: #3498db; /* Brighter blue */
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.2s; /* Smooth transition */
                margin-left: 10px;
            }
            .btn:hover {
                background-color: #2980b9; /* Darker blue on hover */
                transform: scale(1.05); /* Scale effect on hover */
            }
            .total {
                font-size: 22px;
                margin-top: 20px;
                color: #333;
                text-align: right;
                font-weight: bold; /* Bold total */
                padding: 10px 0; /* Spacing for clarity */
                border-top: 1px solid #e1e1e1; /* Separator line */
            }
            .actions {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }
            .empty-cart {
                color: #e74c3c; /* Red for empty cart notice */
                font-size: 20px;
                text-align: center;
                margin-bottom: 20px;
            }
        </style>
        <script>
            function confirmRemove(item) {
                return confirm("Bạn có chắc muốn xóa " + item + " khỏi giỏ hàng?");
            }
        </script>
    </head>
    <body>
        <div class="container">
            <h1>Giỏ hàng</h1>
            <c:if test="${sessionScope.quantity == 0}">
                <div class="empty-cart">Giỏ hàng trống</div>
                <input class="btn" type="button" value="Tiếp tục mua hàng" onclick="window.location.href = 'listmoto'">
            </c:if>
            <c:if test="${sessionScope.quantity != 0}">
                <c:forEach items="${requestScope.carts}" var="c">
                    <div class="cart-item">
                        <img src="${c.value.imageUrl}" alt="${c.value.model}">
                        <div class="cart-item-details">
                            <p class="model">${c.value.model}</p>
                            <p class="price">${c.value.dailyRate} VND/ngày</p>
                        </div>
                        <input class="btn" type="button" value="Xóa" 
                               onclick="if (confirmRemove('${c.value.model}'))
                                           window.location.href = 'cartDetail?cid=${c.key}'">
                    </div>
                </c:forEach>
                <div class="total">Tổng: ${sessionScope.total_cost} VND</div>
                <div class="actions">
                    <input class="btn" type="button" value="Tiếp tục mua hàng" onclick="window.location.href = 'listmoto'">
                    <input class="btn" type="button" value="Thanh toán" onclick="window.location.href = 'bookinfo'">
                </div>
            </c:if>
        </div>
    </body>
</html>
