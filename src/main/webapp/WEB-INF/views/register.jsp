<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Real Estate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            overflow: hidden;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .register-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .register-box {
            width: 480px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
            padding: 40px;
            position: relative;
        }
        
        .register-header {
            text-align: center;
            margin-bottom: 25px;
        }
        
        .register-logo {
            font-size: 2.2rem;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .register-title {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .register-subtitle {
            color: #7f8c8d;
            font-size: 0.95rem;
        }
        
        .form-control {
            border: 1px solid #dfe6e9;
            border-radius: 8px;
            padding: 10px 15px;
            font-size: 0.9rem;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .form-label {
            font-weight: 500;
            color: #2c3e50;
            margin-bottom: 6px;
            font-size: 0.9rem;
        }
        
        .btn-register {
            background: #2c3e50;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 500;
            font-size: 1rem;
            transition: all 0.3s;
            color: white;
        }
        
        .btn-register:hover {
            background: #3498db;
            transform: translateY(-1px);
        }
        
        .alert {
            border-radius: 8px;
            padding: 10px 15px;
            font-size: 0.85rem;
            margin-bottom: 15px;
        }
        
        .register-footer {
            text-align: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
            font-size: 0.9rem;
        }
        
        .register-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }
        
        .register-link:hover {
            text-decoration: underline;
            color: #2980b9;
        }
        
        .row {
            margin-left: -8px;
            margin-right: -8px;
        }
        
        .col-md-6 {
            padding-left: 8px;
            padding-right: 8px;
        }
        
        .mb-3 {
            margin-bottom: 15px !important;
        }
        
        .required-star {
            color: #e74c3c;
        }
        
        .form-check-input:checked {
            background-color: #3498db;
            border-color: #3498db;
        }
        
        .form-check-label {
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-box">
            <div class="register-header">
                <div class="register-logo">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h3 class="register-title">Đăng ký tài khoản</h3>
                <p class="register-subtitle">Tham gia cùng chúng tôi</p>
            </div>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <div><%= request.getAttribute("error") %></div>
                </div>
            <% } %>
            
            <form method="post" action="${pageContext.request.contextPath}/register">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="username" class="form-label">Tên đăng nhập <span class="required-star">*</span></label>
                        <input type="text" class="form-control" id="username" name="username" 
                               value="${param.username}" placeholder="Tên đăng nhập" required>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label for="fullName" class="form-label">Họ và tên <span class="required-star">*</span></label>
                        <input type="text" class="form-control" id="fullName" name="fullName" 
                               value="${param.fullName}" placeholder="Họ và tên" required>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="password" class="form-label">Mật khẩu <span class="required-star">*</span></label>
                        <input type="password" class="form-control" id="password" name="password" 
                               placeholder="Mật khẩu" required>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu <span class="required-star">*</span></label>
                        <input type="password" class="form-control" id="confirmPassword" 
                               name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="email" class="form-label">Email <span class="required-star">*</span></label>
                    <input type="email" class="form-control" id="email" name="email" 
                           value="${param.email}" placeholder="email@example.com" required>
                </div>
                
                <div class="mb-3">
                    <label for="phone" class="form-label">Số điện thoại</label>
                    <input type="tel" class="form-control" id="phone" name="phone" 
                           value="${param.phone}" placeholder="0123 456 789">
                </div>
                
                <div class="mb-3">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="terms" required>
                        <label class="form-check-label" for="terms">
                            Tôi đồng ý với <a href="#" class="register-link">điều khoản dịch vụ</a>
                        </label>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-register w-100">
                    <i class="fas fa-user-plus me-2"></i>Đăng ký
                </button>
            </form>
            
            <div class="register-footer">
                <span class="text-muted">Đã có tài khoản? </span>
                <a href="${pageContext.request.contextPath}/login" class="register-link">Đăng nhập ngay</a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Kiểm tra mật khẩu khớp
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (confirmPassword !== '' && password !== confirmPassword) {
                this.style.borderColor = '#e74c3c';
                this.style.boxShadow = '0 0 0 3px rgba(231, 76, 60, 0.1)';
            } else {
                this.style.borderColor = '#3498db';
                this.style.boxShadow = '0 0 0 3px rgba(52, 152, 219, 0.1)';
            }
        });
        
        // Format số điện thoại
        document.getElementById('phone').addEventListener('input', function() {
            let value = this.value.replace(/\D/g, '');
            if (value.length > 0) {
                value = value.match(/(\d{0,4})(\d{0,3})(\d{0,3})/);
                this.value = !value[2] ? value[1] : value[1] + ' ' + value[2] + (value[3] ? ' ' + value[3] : '');
            }
        });
    </script>
</body>
</html>