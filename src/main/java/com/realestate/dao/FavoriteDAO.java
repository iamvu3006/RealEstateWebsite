package com.realestate.dao;

import com.realestate.model.Property;
import com.realestate.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FavoriteDAO {
    
    /**
     * Kiểm tra property đã được user yêu thích chưa
     */
    public boolean isFavorite(int userId, int propertyId) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE user_id = ? AND property_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.setInt(2, propertyId);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Thêm property vào danh sách yêu thích
     */
    public boolean addFavorite(int userId, int propertyId) {
        String sql = "INSERT INTO favorites (user_id, property_id) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.setInt(2, propertyId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Xóa property khỏi danh sách yêu thích
     */
    public boolean removeFavorite(int userId, int propertyId) {
        String sql = "DELETE FROM favorites WHERE user_id = ? AND property_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.setInt(2, propertyId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Lấy danh sách property yêu thích của user
     */
    public List<Property> getFavoriteProperties(int userId) {
        List<Property> properties = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name, u.phone FROM favorites f " +
                     "JOIN properties p ON f.property_id = p.property_id " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE f.user_id = ? " +
                     "ORDER BY f.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            PropertyDAO propertyDAO = new PropertyDAO();
            
            while (rs.next()) {
                Property property = extractPropertyFromResultSet(rs);
                // Lấy images riêng
                property.setImages(getPropertyImages(property.getPropertyId()));
                properties.add(property);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return properties;
    }
    
    /**
     * Đếm số lượng property yêu thích của user
     */
    public int getFavoriteCount(int userId) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Helper methods
    private Property extractPropertyFromResultSet(ResultSet rs) throws SQLException {
        Property property = new Property();
        property.setPropertyId(rs.getInt("property_id"));
        property.setUserId(rs.getInt("user_id"));
        property.setTitle(rs.getString("title"));
        property.setDescription(rs.getString("description"));
        property.setPropertyType(rs.getString("property_type"));
        property.setTransactionType(rs.getString("transaction_type"));
        property.setPrice(rs.getDouble("price"));
        property.setArea(rs.getDouble("area"));
        property.setAddress(rs.getString("address"));
        property.setCity(rs.getString("city"));
        property.setDistrict(rs.getString("district"));
        property.setWard(rs.getString("ward"));
        property.setBedrooms(rs.getInt("bedrooms"));
        property.setBathrooms(rs.getInt("bathrooms"));
        property.setStatus(rs.getString("status"));
        property.setViewCount(rs.getInt("view_count"));
        property.setCreatedAt(rs.getTimestamp("created_at"));
        property.setUpdatedAt(rs.getTimestamp("updated_at"));
        property.setOwnerName(rs.getString("full_name"));
        property.setOwnerPhone(rs.getString("phone"));
        return property;
    }
    
    private List<String> getPropertyImages(int propertyId) {
        List<String> images = new ArrayList<>();
        String sql = "SELECT image_url FROM property_images WHERE property_id = ? ORDER BY is_main DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, propertyId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                images.add(rs.getString("image_url"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return images;
    }
}