<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reset Password</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            body {
                min-height: 100vh;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .container {
                max-width: 450px;
                width: 90%;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
                transform: translateY(0);
                transition: all 0.3s ease;
            }

            .container:hover {
                transform: translateY(-5px);
            }

            .password-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .password-header h3 {
                color: #2d3748;
                font-weight: 700;
                font-size: 2rem;
                margin-bottom: 15px;
            }

            .password-header p {
                color: #718096;
                font-size: 1rem;
                line-height: 1.5;
            }

            .form-group {
                margin-bottom: 25px;
                position: relative;
            }

            .form-control {
                height: 50px;
                border-radius: 12px;
                border: 2px solid #e2e8f0;
                padding: 10px 20px;
                padding-right: 40px;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.25);
            }

            .password-toggle {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: #718096;
            }

            .password-toggle:hover {
                color: #667eea;
            }

            .password-strength {
                height: 5px;
                margin-top: 10px;
                border-radius: 10px;
                transition: all 0.3s ease;
            }

            .strength-weak {
                background-color: #fc8181;
            }
            .strength-medium {
                background-color: #f6e05e;
            }
            .strength-strong {
                background-color: #68d391;
            }

            .btn {
                height: 50px;
                border-radius: 12px;
                font-size: 1rem;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.35);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.45);
                background: linear-gradient(135deg, #5a6fd6 0%, #6a4492 100%);
            }

            .back-link {
                display: inline-flex;
                align-items: center;
                color: #667eea;
                text-decoration: none;
                font-weight: 500;
                margin-top: 20px;
                transition: all 0.3s ease;
            }

            .back-link i {
                margin-right: 8px;
                font-size: 0.9rem;
            }

            .back-link:hover {
                color: #764ba2;
                text-decoration: none;
                transform: translateX(-3px);
            }

            .error-message {
                padding: 12px;
                border-radius: 10px;
                margin: 15px 0;
                background-color: rgba(245, 101, 101, 0.1);
                color: #e53e3e;
                font-size: 0.95rem;
                display: none;
            }

            .error-message:not(:empty) {
                display: block;
            }

            /* Password requirements list */
            .password-requirements {
                margin: 15px 0;
                padding: 15px;
                background: rgba(237, 242, 247, 0.5);
                border-radius: 10px;
                font-size: 0.9rem;
            }

            .requirement {
                color: #718096;
                margin: 5px 0;
                display: flex;
                align-items: center;
            }

            .requirement i {
                margin-right: 8px;
                font-size: 12px;
            }

            .requirement.valid {
                color: #38a169;
            }

            .requirement.invalid {
                color: #e53e3e;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .fade-in {
                animation: fadeIn 0.5s ease-out;
            }
        </style>
    </head>
    <body>
        <div class="container fade-in">
            <div class="password-header">
                <h3>Reset Password</h3>
                <p>Create a strong password for your account</p>
            </div>

            <form action="resetpassword" method="post" id="resetForm">
                <div class="form-group">
                    <input type="password" class="form-control" id="newPassword1" 
                           name="newPassword1" placeholder="New Password" required>
                    <i class="password-toggle fas fa-eye" onclick="togglePassword('newPassword1')"></i>
                    <div class="password-strength" id="passwordStrength"></div>
                </div>

                <div class="form-group">
                    <input type="password" class="form-control" id="confirmNewPassword" 
                           name="confirmNewPassword" placeholder="Confirm New Password" required>
                    <i class="password-toggle fas fa-eye" onclick="togglePassword('confirmNewPassword')"></i>
                </div>

                <div class="password-requirements">
                    <div class="requirement" id="length"><i class="fas fa-circle"></i> At least 8 characters</div>
                    <div class="requirement" id="match"><i class="fas fa-circle"></i> Passwords match</div>
                </div>

                <button type="submit" class="btn btn-primary btn-block" id="submitBtn" disabled>
                    Reset Password
                </button>

                <div class="text-center">
                    <a href="forgotpassword.jsp" class="back-link">
                        <i class="fas fa-arrow-left"></i> Back to Email
                    </a>
                </div>
            </form>

            <div class="error-message text-center">${error}</div>
        </div>

        <script>
            function togglePassword(inputId) {
                const input = document.getElementById(inputId);
                const icon = input.nextElementSibling;

                if (input.type === 'password') {
                    input.type = 'text';
                 
                    icon.classList.add('fa-eye-slash');
                } else {
                    input.type = 'password';
 
                    icon.classList.add('fa-eye');
                }
            }

            function validatePassword() {
                const password = document.getElementById('newPassword1').value;
                const confirmPassword = document.getElementById('confirmNewPassword').value;
                const submitBtn = document.getElementById('submitBtn');

                // Password requirements
                const requirements = {
                    length: password.length >= 8,
                    match: password === confirmPassword && password !== ''
                };

                // Update requirement indicators
                for (const [req, valid] of Object.entries(requirements)) {
                    const element = document.getElementById(req);
                    element.classList.remove('valid', 'invalid');
                    element.classList.add(valid ? 'valid' : 'invalid');
                    element.querySelector('i').className = valid ?
                            'fas fa-check-circle' : 'fas fa-circle';
                }

                // Update password strength indicator
                const strength = document.getElementById('passwordStrength');
                const validCount = Object.values(requirements).filter(Boolean).length;

                strength.className = 'password-strength';
                if (validCount <= 1) {
                    strength.classList.add('strength-weak');
                    strength.style.width = '50%';
                
                } else {
                    strength.classList.add('strength-strong');
                    strength.style.width = '100%';
                }

                // Enable/disable submit button
                submitBtn.disabled = !Object.values(requirements).every(Boolean);
            }

            // Add event listeners
            document.getElementById('newPassword1').addEventListener('input', validatePassword);
            document.getElementById('confirmNewPassword').addEventListener('input', validatePassword);

            // Form submission
//            document.getElementById('resetForm').addEventListener('submit', function (e) {
//                if (!validatePassword()) {
//                    e.preventDefault();
//                    alert('Please ensure all password requirements are met.');
//                }
//            });

            // Initialize validation on page load
            validatePassword();
        </script>
    </body>
</html>