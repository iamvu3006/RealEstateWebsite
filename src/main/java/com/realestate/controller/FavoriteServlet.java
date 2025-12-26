package com.realestate.controller;

import com.realestate.dao.FavoriteDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/favorite")
public class FavoriteServlet extends HttpServlet {
    private FavoriteDAO favoriteDAO = new FavoriteDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            out.print("{\"success\": false, \"message\": \"Chưa đăng nhập\"}");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");
        String propertyIdStr = request.getParameter("propertyId");
        
        if (propertyIdStr == null || propertyIdStr.isEmpty()) {
            out.print("{\"success\": false, \"message\": \"Thiếu property ID\"}");
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            
            if ("check".equals(action)) {
                // Kiểm tra đã yêu thích chưa
                boolean isFavorite = favoriteDAO.isFavorite(userId, propertyId);
                out.print("{\"success\": true, \"isFavorite\": " + isFavorite + "}");
            } else {
                out.print("{\"success\": false, \"message\": \"Action không hợp lệ\"}");
            }
            
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"Property ID không hợp lệ\"}");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            out.print("{\"success\": false, \"message\": \"Bạn cần đăng nhập để sử dụng tính năng này!\"}");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");
        String propertyIdStr = request.getParameter("propertyId");
        
        if (propertyIdStr == null || propertyIdStr.isEmpty()) {
            out.print("{\"success\": false, \"message\": \"Thiếu property ID\"}");
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            
            if ("toggle".equals(action)) {
                // Toggle favorite: Nếu đã yêu thích thì xóa, chưa thì thêm
                boolean isFavorite = favoriteDAO.isFavorite(userId, propertyId);
                
                if (isFavorite) {
                    // Xóa khỏi yêu thích
                    boolean success = favoriteDAO.removeFavorite(userId, propertyId);
                    if (success) {
                        out.print("{\"success\": true, \"isFavorite\": false, \"message\": \"Đã xóa khỏi yêu thích\"}");
                    } else {
                        out.print("{\"success\": false, \"message\": \"Không thể xóa khỏi yêu thích\"}");
                    }
                } else {
                    // Thêm vào yêu thích
                    boolean success = favoriteDAO.addFavorite(userId, propertyId);
                    if (success) {
                        out.print("{\"success\": true, \"isFavorite\": true, \"message\": \"Đã thêm vào yêu thích\"}");
                    } else {
                        out.print("{\"success\": false, \"message\": \"Không thể thêm vào yêu thích\"}");
                    }
                }
            } else {
                out.print("{\"success\": false, \"message\": \"Action không hợp lệ\"}");
            }
            
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"Property ID không hợp lệ\"}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        }
    }
}