package com.realestate.controller;

import com.realestate.dao.PropertyDAO;
import com.realestate.model.Property;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class HomeServlet extends HttpServlet {
    private PropertyDAO propertyDAO = new PropertyDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy 6 BĐS mới nhất
        List<Property> latestProperties = propertyDAO.getLatestProperties(6);
        request.setAttribute("latestProperties", latestProperties);
        
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}