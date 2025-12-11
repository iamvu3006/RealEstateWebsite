package com.realestate.controller.admin;

import com.realestate.dao.UserDAO;
import com.realestate.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String statusFilter = request.getParameter("status");
        
        List<User> users;
        if (statusFilter != null && !statusFilter.isEmpty()) {
            users = userDAO.getUsersByStatus(statusFilter);
        } else {
            users = userDAO.getAllUsers();
        }
        
        request.setAttribute("users", users);
        request.setAttribute("statusFilter", statusFilter);
        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String userId = request.getParameter("userId");
        
        if (userId == null || userId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=ID không hợp lệ");
            return;
        }
        
        try {
            int id = Integer.parseInt(userId);
            boolean success = false;
            String message = "";
            
            switch (action) {
                case "block":
                    success = userDAO.updateUserStatus(id, "BLOCKED");
                    message = success ? "Đã khóa tài khoản!" : "Khóa tài khoản thất bại!";
                    break;
                    
                case "unblock":
                    success = userDAO.updateUserStatus(id, "ACTIVE");
                    message = success ? "Đã mở khóa tài khoản!" : "Mở khóa thất bại!";
                    break;
                    
                case "delete":
                    success = userDAO.deleteUser(id);
                    message = success ? "Đã xóa tài khoản!" : "Xóa tài khoản thất bại!";
                    break;
                    
                default:
                    message = "Hành động không hợp lệ!";
            }
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/users?success=" + message);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=" + message);
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=ID không hợp lệ");
        }
    }
}