<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Verify OTP</title>
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
                animation: float 6s ease-in-out infinite;
            }

            @keyframes float {
                0% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-10px);
                }
                100% {
                    transform: translateY(0px);
                }
            }

            .otp-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .otp-header h3 {
                color: #2d3748;
                font-weight: 700;
                font-size: 2rem;
                margin-bottom: 15px;
            }

            .otp-header p {
                color: #718096;
                font-size: 1rem;
                line-height: 1.5;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-control {
                height: 50px;
                border-radius: 12px;
                border: 2px solid #e2e8f0;
                padding: 10px 20px;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                text-align: center;
                letter-spacing: 5px;
                font-weight: 600;
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.25);
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

            .btn-secondary {
                background: transparent;
                color: #667eea;
                border: 2px solid #667eea;
            }

            .btn-secondary:hover:not(:disabled) {
                background: rgba(102, 126, 234, 0.1);
                color: #667eea;
                border-color: #667eea;
            }

            .btn-secondary:disabled {
                opacity: 0.7;
                cursor: not-allowed;
            }

            #countdown {
                margin: 20px 0;
                font-size: 0.95rem;
                color: #718096;
            }

            #timer, #countdown-timer {
                font-weight: 700;
                color: #4a5568;
            }

            .error-message, .success-message {
                padding: 12px;
                border-radius: 10px;
                margin: 15px 0;
                font-size: 0.95rem;
                display: none;
            }

            .error-message {
                background-color: rgba(245, 101, 101, 0.1);
                color: #e53e3e;
            }

            .success-message {
                background-color: rgba(72, 187, 120, 0.1);
                color: #38a169;
            }

            .error-message:not(:empty),
            .success-message:not(:empty) {
                display: block;
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

            /* Animation for form elements */
            .fade-in {
                animation: fadeIn 0.5s ease-out;
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

            /* Responsive adjustments */
            @media (max-width: 480px) {
                .container {
                    padding: 25px;
                }

                .otp-header h3 {
                    font-size: 1.75rem;
                }
            }
        </style>
    </head>

    <body>
        <div class="container fade-in">
            <div class="otp-header">
                <h3>Xác nhận mã OTP</h3>
                <p>Vui lòng nhập mã OTP mà chúng tôi đã gửi về mail của bạn!</p>
            </div>

            <form action="verifyotp" method="POST">
                <div class="form-group">
                    <input type="text" name="otp" class="form-control" placeholder="• • • • • •" maxlength="6" 
                           required autocomplete="off" pattern="\d{6}" 
                           oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                </div>
                <button type="submit" class="btn btn-primary btn-block">Xác nhận</button>
            </form>

            <div class="error-message text-center">${error}</div>
            <div class="success-message text-center">${message}</div>

            <div id="countdown" class="text-center">
                Mã OTP sẽ hết hạn sau <span id="timer">60</span> giây.
            </div>

            <button id="resendBtn" class="btn btn-secondary btn-block" onclick="resendOTP()" disabled>
                Gửi lại mã OTP (<span id="countdown-timer">60</span>s)
            </button>

            <div class="text-center">
                <a href="forgotpassword.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Trở lại nhập Email
                </a>
            </div>
        </div>

        <!-- Script section remains the same but with enhanced alert -->
        <script>
            let countdownTimer;
            const countdownDuration = 60;

            function startCountdown() {
                let timeLeft = countdownDuration;
                document.getElementById("resendBtn").disabled = true;

                countdownTimer = setInterval(() => {
                    timeLeft -= 1;
                    document.getElementById("timer").innerText = timeLeft;
                    document.getElementById("countdown-timer").innerText = timeLeft;

                    if (timeLeft <= 0) {
                        clearInterval(countdownTimer);
                        document.getElementById("timer").innerText = countdownDuration;
                        document.getElementById("countdown-timer").innerText = countdownDuration;
                        document.getElementById("resendBtn").disabled = false;
                    }
                }, 1000);
            }

            function resendOTP() {
                fetch('verifyotp', {method: 'PUT'})
                        .then(response => response.text())
                        .then(message => {
                            const successDiv = document.createElement('div');
                            successDiv.className = 'success-message text-center fade-in';
                            successDiv.textContent = message;

                            // Remove any existing success messages
                            document.querySelectorAll('.success-message').forEach(el => el.remove());

                            // Insert new message after the form
                            document.querySelector('form').insertAdjacentElement('afterend', successDiv);

                            // Remove message after 3 seconds
                            setTimeout(() => {
                                successDiv.style.opacity = '0';
                                setTimeout(() => successDiv.remove(), 300);
                            }, 3000);

                            startCountdown();
                        })
                        .catch(error => console.error('Error:', error));
            }

            // Input formatting
            document.querySelector('input[name="otp"]').addEventListener('input', function (e) {
                let value = this.value.replace(/\D/g, '');
                if (value.length > 6)
                    value = value.slice(0, 6);
                this.value = value;
            });

            window.onload = startCountdown;
        </script>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>