package com.realestate.controller;

import com.realestate.dao.PropertyDAO;
import com.realestate.model.Property;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/properties")
public class PropertyListServlet extends HttpServlet {
    private PropertyDAO propertyDAO = new PropertyDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        String propertyType = request.getParameter("propertyType");
        String transactionType = request.getParameter("transactionType");
        String city = request.getParameter("city");
        
        List<Property> properties;
        
        // Nếu có tham số tìm kiếm -> search, không thì lấy tất cả
        if (keyword != null || propertyType != null || transactionType != null || city != null) {
            properties = propertyDAO.searchProperties(keyword, propertyType, transactionType, city);
        } else {
            properties = propertyDAO.getAllProperties();
        }
        
        request.setAttribute("properties", properties);
        request.setAttribute("keyword", keyword);
        request.setAttribute("propertyType", propertyType);
        request.setAttribute("transactionType", transactionType);
        request.setAttribute("city", city);
        
        request.getRequestDispatcher("/WEB-INF/views/property-list.jsp").forward(request, response);
    }
}