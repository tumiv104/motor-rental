<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create New Motorbike</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --accent-color: #00b4d8;
                --background-color: #f8f9fa;
                --card-background: #ffffff;
                --text-primary: #333333;
                --text-secondary: #6c757d;
            }

            body {
                background-color: var(--background-color);
                font-family: 'Segoe UI', sans-serif;
                padding-top: 56px;
                color: var(--text-primary);
            }

            /* Navbar Styles */
            .navbar {
                background-color: #5bc0de;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 10;
            }

            .navbar .nav-link {
                color: white !important;
                transition: color 0.2s;
            }

            .navbar .nav-link:hover {
                color: #f0ad4e !important;
            }

            /* Sidebar Styles */
            .sidebar {
                min-width: 250px;
                background-color: #f8f9fa;
                color: #343a40;
                height: 100vh;
                position: fixed;
                top: 56px;
                left: 0;
                padding: 15px;
                z-index: 1000;
            }

            .sidebar h3 {
                color: #5bc0de;
                margin-bottom: 20px;
                font-size: 1.5rem;
                padding-bottom: 10px;
                border-bottom: 2px solid #5bc0de;
            }

            .sidebar .nav {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .sidebar .nav-item {
                margin-bottom: 5px;
            }

            .sidebar .nav-link {
                display: block;
                padding: 10px 15px;
                color: #6c757d !important;
                text-decoration: none;
                transition: all 0.3s ease;
                border-radius: 5px;
            }

            .sidebar .nav-link:hover {
                background-color: #e9ecef;
                color: #5bc0de !important;
                transform: translateX(10px);
            }

            .sidebar .nav-link i {
                margin-right: 10px;
                width: 20px;
                text-align: center;
            }

            .sidebar .nav-link.active {
                background-color: #5bc0de;
                color: white !important;
            }

            /* Main Content Area */
            .main-content {
                margin-left: 10px;
                padding: 20px;
            }

            /* Form Styles */
            .form-container {
                background: var(--card-background);
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                padding: 2rem;
                margin-top: 2rem;
            }

            .form-container h1 {
                color: var(--primary-color);
                font-size: 2rem;
                margin-bottom: 1.5rem;
                text-align: center;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                color: var(--text-secondary);
                font-weight: 500;
                margin-bottom: 0.5rem;
            }

            .form-control {
                border: 2px solid #e9ecef;
                border-radius: 8px;
                padding: 0.75rem;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.25);
            }

            .error-message {
                background-color: #fff3f3;
                border-left: 4px solid #dc3545;
                color: #dc3545;
                padding: 1rem;
                margin-bottom: 1.5rem;
                border-radius: 4px;
            }
            /* Image Upload Styles */
            .image-upload-container {
                border: 2px dashed #ddd;
                border-radius: 8px;
                padding: 20px;
                text-align: center;
                margin-bottom: 1.5rem;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .image-upload-container:hover {
                border-color: var(--primary-color);
            }

            .image-preview {
                max-width: 200px;
                max-height: 200px;
                margin: 10px auto;
                display: none;
            }

            .btn-submit {
                background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
                border: none;
                border-radius: 8px;
                color: white;
                padding: 12px 30px;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                width: 100%;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                }

                .sidebar.show {
                    transform: translateX(0);
                }

                .main-content {
                    padding: 1rem;
                }

                .form-container {
                    margin: 1rem;
                    padding: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
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
                    <li class="nav-item"><a class="nav-link" href="profile"><i class="fas fa-user mr-1"></i> Hồ sơ</a></li>
                    <li class="nav-item"><a class="nav-link" href="createmotorbyuser"><i class="fas fa-motorcycle mr-2"></i> Cho thuê xe</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/websitereview"><i class="fas fa-star mr-1"></i> Đánh giá </a></li>
                        <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="login"><i class="fas fa-sign-in-alt mr-1"></i> Đăng nhập</a></li>
                        </c:if>
                </ul>
            </div>
        </nav>



        <!-- Main Content -->
        <div class="main-content">
            <div class="container">
                <div class="form-container">
                    <h1><i class="fas fa-motorcycle me-2"></i>Đăng ký cho thuê xe</h1>

                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            ${errorMessage}
                        </div>
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        <div class="error-message">
                            Vui lòng <a href="login.jsp">đăng nhập</a> để thêm xe.
                        </div>
                    </c:if>

                    <c:if test="${not empty sessionScope.user && sessionScope.user.role != 'rental'}">
                        <div class="error-message">
                            Bạn cần <a href="updateaccountrole.jsp">đăng ký tài khoản cho thuê xe</a> để sử dụng tính năng này.
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">${errorMessage}</div>
                    </c:if>

                    <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'rental'}">
                        <form action="createmotorbyuser" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Tên xe <span class="text-danger">*</span></label>
                                        <input type="text" name="model" class="form-control" placeholder="VD: Wave Alpha" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Hãng xe <span class="text-danger">*</span></label>
                                        <input type="text" name="brand" class="form-control" placeholder="VD: Honda" required>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Năm sản xuất <span class="text-danger">*</span></label>
                                        <input type="number" name="year" class="form-control" required min="2010" max="2024" value="2024">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Giá thuê/ngày(VND) <span class="text-danger">*</span></label>
                                        <input type="number" step="1000" name="daily_rate" class="form-control" placeholder="VD: 50000" required min="0">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Biển số xe <span class="text-danger">*</span></label>
                                        <input type="text" name="license_plate" class="form-control" placeholder="VD: 30T41975" required 
                                               pattern="[0-9]{2}[A-Z]{1}[0-9]{4,5}"
                                               title="Biển số xe phải đúng định dạng: 59A12345">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Loại nhiên liệu <span class="text-danger">*</span></label>
                                        <select name="fuel_type" class="form-control" required>
                                            <option value="">Lựa chọn loại nhiên liệu</option>
                                            <option value="RON95">RON 95</option>
                                            <option value="RON92">RON 92</option>
                                            <option value="E5RON92">E5 RON 92</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Số km đã đi (km)</label>
                                        <input type="number" name="mileage" class="form-control" min="0">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Màu sắc</label>
                                        <input type="text" name="color" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Dung tích xi-lanh (cc)</label>
                                        <input type="text" name="engine_size" class="form-control">
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Ảnh xe máy</label>
                                <div class="image-upload-container">
                                    <i class="fas fa-cloud-upload-alt fa-3x mb-3"></i>

                                    <input type="file" id="image_upload" name="image" accept="image/*" 
                                           onchange="previewImage(this)" class="form-control">
                                    <p>Nhấn vào để tải ảnh lên</p>
                                    <div class="mt-3">
                                        <img id="preview" class="image-preview" style="max-width: 200px; display: none;">
                                    </div>
                                </div>
                            </div>

                            <input type="hidden" name="type_id" value="1">
                            <input type="hidden" name="status" value="Pending">

                            <button type="submit" class="btn-submit">
                                <i class="fas fa-plus-circle me-2"></i>Cho thuê
                            </button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
                                               function validateForm() {
                                                   const year = document.getElementsByName('year')[0].value;
                                                   const currentYear = new Date().getFullYear();

                                                   if (year < 2010 || year > currentYear) {
                                                       alert('Năm phải ở trong khoảng 2010 và ' + currentYear);
                                                       return false;
                                                   }

                                                   const licensePlate = document.getElementsByName('license_plate')[0].value;
                                                   const licensePlatePattern = /^[0-9]{2}[A-Z]{1}[0-9]{4,5}$/;
                                                   if (!licensePlatePattern.test(licensePlate)) {
                                                       alert('Biển số xe phải đúng định dạng: 59A12345');
                                                       return false;
                                                   }

                                                   const dailyRate = document.getElementsByName('daily_rate')[0].value;
                                                   if (dailyRate <= 0) {
                                                       alert('Giá thuê phải lớn hơn 0');
                                                       return false;
                                                   }

                                                   return true;
                                               }

                                               function previewImage(input) {
                                                   const preview = document.getElementById('preview');
                                                   const file = input.files[0];

                                                   if (file) {
                                                       // Validate file type
                                                       if (!file.type.startsWith('image/')) {
                                                           alert('Hãy chọn một ảnh');
                                                           input.value = '';
                                                           preview.style.display = 'none';
                                                           return;
                                                       }

                                                       // Validate file size (max 10MB)
                                                       if (file.size > 10 * 1024 * 1024) {
                                                           alert('Dung lượng ảnh phải ít hơn 10MB');
                                                           input.value = '';
                                                           preview.style.display = 'none';
                                                           return;
                                                       }

                                                       const reader = new FileReader();
                                                       reader.onload = function (e) {
                                                           preview.src = e.target.result;
                                                           preview.style.display = 'block';
                                                       }
                                                       reader.readAsDataURL(file);
                                                   } else {
                                                       preview.style.display = 'none';
                                                   }
                                               }

                                               // Drag and drop functionality
                                               const dropZone = document.querySelector('.image-upload-container');
                                               const fileInput = document.getElementById('image_upload');

                                               dropZone.addEventListener('dragover', (e) => {
                                                   e.preventDefault();
                                                   dropZone.classList.add('dragover');
                                               });

                                               dropZone.addEventListener('dragleave', (e) => {
                                                   e.preventDefault();
                                                   dropZone.classList.remove('dragover');
                                               });

                                               dropZone.addEventListener('drop', (e) => {
                                                   e.preventDefault();
                                                   dropZone.classList.remove('dragover');

                                                   const files = e.dataTransfer.files;
                                                   if (files.length) {
                                                       fileInput.files = files;
                                                       previewImage(fileInput);
                                                   }
                                               });
        </script>
    </body>
</html>