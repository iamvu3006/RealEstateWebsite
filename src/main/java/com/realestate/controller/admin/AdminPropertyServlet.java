package com.realestate.controller.admin;

import com.realestate.dao.PropertyDAO;
import com.realestate.model.Property;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/properties")
public class AdminPropertyServlet extends HttpServlet {
    private PropertyDAO propertyDAO = new PropertyDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String statusFilter = request.getParameter("status");
        
        List<Property> properties;
        if (statusFilter != null && !statusFilter.isEmpty()) {
            properties = propertyDAO.getPropertiesByStatus(statusFilter);
        } else {
            properties = propertyDAO.getAllPropertiesForAdmin();
        }
        
        request.setAttribute("properties", properties);
        request.setAttribute("statusFilter", statusFilter);
        request.getRequestDispatcher("/WEB-INF/views/admin/properties.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String propertyId = request.getParameter("propertyId");
        
        if (propertyId == null || propertyId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/properties?error=ID không hợp lệ");
            return;
        }
        
        try {
            int id = Integer.parseInt(propertyId);
            boolean success = false;
            String message = "";
            
            switch (action) {
                case "approve":
                    success = propertyDAO.updatePropertyStatus(id, "APPROVED");
                    message = success ? "Đã duyệt tin thành công!" : "Duyệt tin thất bại!";
                    break;
                    
                case "reject":
                    success = propertyDAO.updatePropertyStatus(id, "REJECTED");
                    message = success ? "Đã từ chối tin!" : "Từ chối tin thất bại!";
                    break;
                    
                case "delete":
                    success = propertyDAO.deletePropertyByAdmin(id);
                    message = success ? "Đã xóa tin!" : "Xóa tin thất bại!";
                    break;
                    
                default:
                    message = "Hành động không hợp lệ!";
            }
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/properties?success=" + message);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/properties?error=" + message);
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/properties?error=ID không hợp lệ");
        }
    }
}