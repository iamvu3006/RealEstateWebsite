<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Real Estate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            overflow: hidden;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .login-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-box {
            width: 420px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
            padding: 40px;
            position: relative;
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .login-logo {
            font-size: 2.2rem;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .login-title {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .login-subtitle {
            color: #7f8c8d;
            font-size: 0.95rem;
        }
        
        .form-control {
            border: 1px solid #dfe6e9;
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 0.95rem;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .form-label {
            font-weight: 500;
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }
        
        .btn-login {
            background: #2c3e50;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 500;
            font-size: 1rem;
            transition: all 0.3s;
            color: white;
        }
        
        .btn-login:hover {
            background: #3498db;
            transform: translateY(-1px);
        }
        
        .alert {
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 0.9rem;
            margin-bottom: 20px;
        }
        
        .login-footer {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            font-size: 0.9rem;
        }
        
        .login-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }
        
        .login-link:hover {
            text-decoration: underline;
            color: #2980b9;
        }
        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 15px 0 25px;
        }
        
        .form-check-input:checked {
            background-color: #3498db;
            border-color: #3498db;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <div class="login-logo">
                    <i class="fas fa-home"></i>
                </div>
                <h3 class="login-title">Đăng nhập</h3>
                <p class="login-subtitle">Hệ thống bất động sản chuyên nghiệp</p>
            </div>
            
            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success d-flex align-items-center" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <div><%= request.getParameter("success") %></div>
                </div>
            <% } %>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <div><%= request.getAttribute("error") %></div>
                </div>
            <% } %>
            
            <form method="post" action="${pageContext.request.contextPath}/login">
                <div class="mb-3">
                    <label for="username" class="form-label">Tên đăng nhập</label>
                    <input type="text" class="form-control" id="username" name="username" 
                           value="${cookie.username.value}" placeholder="Nhập tên đăng nhập" required>
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Nhập mật khẩu" required>
                </div>
                
                <div class="remember-forgot">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="remember" name="remember">
                        <label class="form-check-label" for="remember" style="font-size: 0.9rem;">Ghi nhớ đăng nhập</label>
                    </div>
                    <a href="#" class="login-link" style="font-size: 0.9rem;">Quên mật khẩu?</a>
                </div>
                
                <button type="submit" class="btn btn-login w-100">
                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                </button>
            </form>
            
            <div class="login-footer">
                <span class="text-muted">Chưa có tài khoản? </span>
                <a href="${pageContext.request.contextPath}/register" class="login-link">Đăng ký ngay</a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>