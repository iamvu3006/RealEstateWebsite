package com.realestate.controller;

import com.realestate.dao.UserDAO;
import com.realestate.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("=== REGISTER GET - Showing register page ===");
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== REGISTER POST - Processing registration ===");
        
        request.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        System.out.println("Username: " + username);
        System.out.println("Full name: " + fullName);
        System.out.println("Email: " + email);
        System.out.println("Phone: " + phone);
        
        // Validation
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            System.out.println("ERROR: Required fields are empty!");
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            System.out.println("ERROR: Passwords don't match!");
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        System.out.println("Checking if username exists...");
        if (userDAO.isUsernameExists(username)) {
            System.out.println("ERROR: Username already exists!");
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        System.out.println("Checking if email exists...");
        if (userDAO.isEmailExists(email)) {
            System.out.println("ERROR: Email already exists!");
            request.setAttribute("error", "Email đã được sử dụng!");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Tạo user mới
        System.out.println("Creating new user...");
        User user = new User(username, password, fullName, email);
        user.setPhone(phone);
        
        boolean success = userDAO.register(user);
        System.out.println("Registration result: " + success);
        
        if (success) {
            System.out.println("✅ Registration SUCCESS!");
            response.sendRedirect(request.getContextPath() + "/login?success=Đăng ký thành công! Vui lòng đăng nhập.");
        } else {
            System.out.println("❌ Registration FAILED!");
            request.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
        
        System.out.println("=== REGISTER POST - End ===");
    }
}