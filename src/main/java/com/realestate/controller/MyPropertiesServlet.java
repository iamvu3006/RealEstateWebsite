package com.realestate.controller;

import com.realestate.dao.PropertyDAO;
import com.realestate.model.Property;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/my-properties")
public class MyPropertiesServlet extends HttpServlet {
    private PropertyDAO propertyDAO = new PropertyDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        
        // Debug
        System.out.println("DEBUG: Loading properties for user ID: " + userId);
        
        // Lấy danh sách BĐS của user
        List<Property> properties = propertyDAO.getPropertiesByUser(userId);
        
        // Debug số lượng property
        System.out.println("DEBUG: User " + userId + " has " + properties.size() + " properties");
        for (Property p : properties) {
            System.out.println("  - Property ID: " + p.getPropertyId() + ", Title: " + p.getTitle() + ", Status: " + p.getStatus());
        }
        
        // Lấy và decode thông báo success
        String success = request.getParameter("success");
        if (success != null) {
            try {
                success = java.net.URLDecoder.decode(success, "UTF-8");
                request.setAttribute("success", success);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        request.setAttribute("properties", properties);
        request.getRequestDispatcher("/WEB-INF/views/my-properties.jsp").forward(request, response);
    }
}