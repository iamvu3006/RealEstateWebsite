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
        
        // Lấy danh sách BĐS của user
        List<Property> properties = propertyDAO.getPropertiesByUser(userId);
        
        request.setAttribute("properties", properties);
        request.getRequestDispatcher("/WEB-INF/views/my-properties.jsp").forward(request, response);
    }
}