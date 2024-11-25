<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="js/address.js"></script>
        <style>
            body {
                background-color: #f0f2f5;
                font-family: 'Arial', sans-serif;
            }
            .signup-container {
                max-width: 600px;
                background: white;
                padding: 40px;
                margin: auto;
                border-radius: 15px;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
                margin-top: 100px;
                transition: transform 0.3s;
            }
            .signup-container:hover {
                transform: translateY(-5px);
            }
            .signup-container h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #333;
                font-weight: bold;
            }
            .input-group {
                margin-bottom: 20px;
            }
            .input-group-prepend .input-group-text {
                background-color: #007bff;
                color: white;
                border: none;
                width: 40px;
                text-align: center;
            }
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
                font-weight: bold;
            }
            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }
            .text-center a {
                color: #007bff;
                text-decoration: none;
                font-weight: bold;
            }
            .text-center a:hover {
                text-decoration: underline;
            }
            .alert {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

        <div class="signup-container">
            <h2>Sign Up</h2>

            <!-- Error Message Display -->
            <% String errorMessage = (String) request.getAttribute("error"); %>
            <% if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
            <% } %>

            <form action="signup" method="post">
                <div class="form-row">
                    <!-- Username -->
                    <div class="form-group col-md-6">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                            </div>
                            <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="form-group col-md-6">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            </div>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                        </div>
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group col-md-6">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            </div>
                            <input type="password" class="form-control" id="confirmpassword" name="confirmpassword" placeholder="Confirm Password" required>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="form-group col-md-6">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            </div>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                        </div>
                    </div>

                    <!-- Full Name -->
                    <div class="form-group col-md-6">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-user-tag"></i></span>
                            </div>
                            <input type="text" class="form-control" id="full_name" name="full_name" placeholder="Full Name" required>
                        </div>
                    </div>

                    <!-- Phone Number -->
                    <div class="form-group col-md-6">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                            </div>
                            <input type="text" class="form-control" id="phone_number" name="phone_number" placeholder="Phone Number" required>
                        </div>
                    </div>

                    <!-- Date of Birth -->
                    <div class="form-group col-md-6">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                            </div>
                            <input type="date" class="form-control" id="date_of_birth" name="date_of_birth" required>
                        </div>
                    </div>
                </div>

                <!-- Address (Province, District, Ward) -->
                <div class="form-group">
                    <label for="province"><i class="fas fa-map-marker-alt"></i> Address</label>
                    <select id="province" name="province" class="form-control" required>
                        <option value="">Tỉnh/Thành</option>
                        <c:forEach items="${requestScope.provinces}" var="p">
                            <option value="${p.id}">${p.name}</option>
                        </c:forEach>
                    </select>
                    <div class="mt-2">
                        <select id="district" name="district" class="form-control" required>
                            <option value="">Quận/Huyện</option>
                        </select>
                    </div>
                    <div class="mt-2">
                        <select id="ward" name="ward" class="form-control" required>
                            <option value="">Xã/Phường</option>
                        </select>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary btn-block">Sign Up</button>
            </form>

            <!-- Redirect to Login -->
            <p class="text-center mt-3">Already have an account? <a href="login">Login here</a></p>
        </div>

    </body>
</html>
