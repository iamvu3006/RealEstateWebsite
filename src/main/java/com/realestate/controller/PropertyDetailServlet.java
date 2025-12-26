package com.realestate.controller;

import com.realestate.dao.PropertyDAO;
import com.realestate.model.Property;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/property-detail")
public class PropertyDetailServlet extends HttpServlet {
    private PropertyDAO propertyDAO = new PropertyDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== PROPERTY DETAIL - GET ===");
        
        String idParam = request.getParameter("id");
        System.out.println("Property ID parameter: " + idParam);
        
        if (idParam == null || idParam.isEmpty()) {
            System.out.println("ERROR: Property ID is null or empty!");
            response.sendRedirect(request.getContextPath() + "/properties");
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(idParam);
            System.out.println("Loading property with ID: " + propertyId);
            
            Property property = propertyDAO.getPropertyById(propertyId);
            
            if (property == null) {
                System.out.println("ERROR: Property not found!");
                request.setAttribute("error", "Không tìm thấy bất động sản!");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }
            
            System.out.println("✅ Property found: " + property.getTitle());
            System.out.println("Images count: " + property.getImages().size());
            
            request.setAttribute("property", property);
            
            // Forward đến JSP
            String jspPath = "/WEB-INF/views/property-detail.jsp";
            System.out.println("Forwarding to: " + jspPath);
            request.getRequestDispatcher(jspPath).forward(request, response);
            
        } catch (NumberFormatException e) {
            System.out.println("ERROR: Invalid property ID format!");
            response.sendRedirect(request.getContextPath() + "/properties");
        } catch (Exception e) {
            System.err.println("ERROR in PropertyDetailServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/");
        }
        
        System.out.println("=== PROPERTY DETAIL - END ===");
    }
}