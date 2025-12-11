package com.realestate.controller;

import com.realestate.dao.PropertyDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/delete-property")
public class DeletePropertyServlet extends HttpServlet {
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
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/my-properties?error=ID không hợp lệ!");
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(idParam);
            
            // Xóa property (chỉ cho phép xóa nếu là chủ sở hữu)
            boolean success = propertyDAO.deleteProperty(propertyId, userId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + 
                    "/my-properties?success=Xóa tin đăng thành công!");
            } else {
                response.sendRedirect(request.getContextPath() + 
                    "/my-properties?error=Không thể xóa tin đăng! Có thể bạn không có quyền.");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/my-properties?error=ID không hợp lệ!");
        }
    }
}