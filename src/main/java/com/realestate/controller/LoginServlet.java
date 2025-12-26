package com.realestate.controller;

import com.realestate.dao.UserDAO;
import com.realestate.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("=== LOGIN GET - Showing login page ===");
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== LOGIN POST - Processing login ===");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        System.out.println("Username: " + username);
        System.out.println("Password length: " + (password != null ? password.length() : 0));
        System.out.println("Remember: " + remember);
        
        if (username == null || username.trim().isEmpty()) {
            System.out.println("ERROR: Username is empty!");
            request.setAttribute("error", "Vui lòng nhập tên đăng nhập!");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            System.out.println("ERROR: Password is empty!");
            request.setAttribute("error", "Vui lòng nhập mật khẩu!");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        System.out.println("Calling userDAO.login()...");
        User user = userDAO.login(username, password);
        
        if (user != null) {
            System.out.println("✅ Login SUCCESS for user: " + user.getUsername());
            System.out.println("User role: " + user.getRole());
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            
            System.out.println("Session created with ID: " + session.getId());
            
            // Remember me cookie
            if ("on".equals(remember)) {
                Cookie userCookie = new Cookie("username", username);
                userCookie.setMaxAge(7 * 24 * 60 * 60);
                response.addCookie(userCookie);
                System.out.println("Remember me cookie set");
            }
            
            // Redirect based on role
            String redirectUrl;
            if ("ADMIN".equals(user.getRole())) {
                redirectUrl = request.getContextPath() + "/admin/dashboard";
                System.out.println("Redirecting ADMIN to: " + redirectUrl);
            } else {
                redirectUrl = request.getContextPath() + "/";
                System.out.println("Redirecting USER to: " + redirectUrl);
            }
            
            response.sendRedirect(redirectUrl);
            
        } else {
            System.out.println("❌ Login FAILED - Invalid credentials");
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
        
        System.out.println("=== LOGIN POST - End ===");
    }
}