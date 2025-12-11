package com.realestate.controller.admin;

import com.realestate.dao.PropertyDAO;
import com.realestate.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private PropertyDAO propertyDAO = new PropertyDAO();
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy thống kê
        Map<String, Integer> stats = new HashMap<>();
        
        stats.put("totalUsers", userDAO.getTotalUsers());
        stats.put("totalProperties", propertyDAO.getTotalProperties());
        stats.put("pendingProperties", propertyDAO.getPendingPropertiesCount());
        stats.put("approvedProperties", propertyDAO.getApprovedPropertiesCount());
        stats.put("rejectedProperties", propertyDAO.getRejectedPropertiesCount());
        
        request.setAttribute("stats", stats);
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}