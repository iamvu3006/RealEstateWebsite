package com.realestate.dao;

import com.realestate.model.Property;
import com.realestate.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyDAO {
    
    // Lấy tất cả BĐS có status = APPROVED
    public List<Property> getAllProperties() {
        List<Property> properties = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name, u.phone FROM properties p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.status = 'APPROVED' " +
                     "ORDER BY p.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Property property = extractPropertyFromResultSet(rs);
                property.setImages(getPropertyImages(property.getPropertyId()));
                properties.add(property);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return properties;
    }
    
    // Lấy BĐS mới nhất
    public List<Property> getLatestProperties(int limit) {
        List<Property> properties = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name, u.phone FROM properties p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.status = 'APPROVED' " +
                     "ORDER BY p.created_at DESC LIMIT ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Property property = extractPropertyFromResultSet(rs);
                property.setImages(getPropertyImages(property.getPropertyId()));
                properties.add(property);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return properties;
    }
    
    // Tìm kiếm BĐS
    public List<Property> searchProperties(String keyword, String propertyType, 
                                          String transactionType, String city) {
        List<Property> properties = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, u.full_name, u.phone FROM properties p " +
            "JOIN users u ON p.user_id = u.user_id " +
            "WHERE p.status = 'APPROVED'"
        );
        
        List<Object> params = new ArrayList<>();
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (p.title LIKE ? OR p.address LIKE ? OR p.description LIKE ?)");
            String searchPattern = "%" + keyword + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        if (propertyType != null && !propertyType.isEmpty()) {
            sql.append(" AND p.property_type = ?");
            params.add(propertyType);
        }
        
        if (transactionType != null && !transactionType.isEmpty()) {
            sql.append(" AND p.transaction_type = ?");
            params.add(transactionType);
        }
        
        if (city != null && !city.isEmpty()) {
            sql.append(" AND p.city = ?");
            params.add(city);
        }
        
        sql.append(" ORDER BY p.created_at DESC");
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Property property = extractPropertyFromResultSet(rs);
                property.setImages(getPropertyImages(property.getPropertyId()));
                properties.add(property);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return properties;
    }
    
    // Lấy chi tiết BĐS theo ID
    public Property getPropertyById(int propertyId) {
        String sql = "SELECT p.*, u.full_name, u.phone FROM properties p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.property_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, propertyId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Property property = extractPropertyFromResultSet(rs);
                property.setImages(getPropertyImages(propertyId));
                
                // Tăng view count
                incrementViewCount(propertyId);
                
                return property;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Lấy danh sách ảnh của BĐS
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
    
    // Tăng lượt xem
    private void incrementViewCount(int propertyId) {
        String sql = "UPDATE properties SET view_count = view_count + 1 WHERE property_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, propertyId);
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Helper method
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
    /**
     * Tạo property mới kèm ảnh
     * @return propertyId nếu thành công, -1 nếu thất bại
     */
    public int createProperty(Property property, List<String> images) {
        String sqlProperty = "INSERT INTO properties (user_id, title, description, property_type, " +
                            "transaction_type, price, area, address, city, district, ward, " +
                            "bedrooms, bathrooms, status) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'PENDING')";
        
        String sqlImage = "INSERT INTO property_images (property_id, image_url, is_main) VALUES (?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement pstmtProperty = null;
        PreparedStatement pstmtImage = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction
            
            // 1. Insert property
            pstmtProperty = conn.prepareStatement(sqlProperty, Statement.RETURN_GENERATED_KEYS);
            pstmtProperty.setInt(1, property.getUserId());
            pstmtProperty.setString(2, property.getTitle());
            pstmtProperty.setString(3, property.getDescription());
            pstmtProperty.setString(4, property.getPropertyType());
            pstmtProperty.setString(5, property.getTransactionType());
            pstmtProperty.setDouble(6, property.getPrice());
            pstmtProperty.setDouble(7, property.getArea());
            pstmtProperty.setString(8, property.getAddress());
            pstmtProperty.setString(9, property.getCity());
            pstmtProperty.setString(10, property.getDistrict());
            pstmtProperty.setString(11, property.getWard());
            pstmtProperty.setInt(12, property.getBedrooms());
            pstmtProperty.setInt(13, property.getBathrooms());
            
            int affectedRows = pstmtProperty.executeUpdate();
            
            if (affectedRows == 0) {
                conn.rollback();
                return -1;
            }
            
            // Lấy propertyId vừa insert
            ResultSet generatedKeys = pstmtProperty.getGeneratedKeys();
            int propertyId = -1;
            if (generatedKeys.next()) {
                propertyId = generatedKeys.getInt(1);
            } else {
                conn.rollback();
                return -1;
            }
            
            // 2. Insert images
            if (images != null && !images.isEmpty()) {
                pstmtImage = conn.prepareStatement(sqlImage);
                
                for (int i = 0; i < images.size(); i++) {
                    pstmtImage.setInt(1, propertyId);
                    pstmtImage.setString(2, images.get(i));
                    pstmtImage.setBoolean(3, i == 0); // Ảnh đầu tiên là ảnh chính
                    pstmtImage.addBatch();
                }
                
                pstmtImage.executeBatch();
            }
            
            conn.commit(); // Commit transaction
            return propertyId;
            
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return -1;
        } finally {
            try {
                if (pstmtImage != null) pstmtImage.close();
                if (pstmtProperty != null) pstmtProperty.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Lấy danh sách BĐS của một user
     */
    public List<Property> getPropertiesByUser(int userId) {
        List<Property> properties = new ArrayList<>();
        String sql = "SELECT * FROM properties WHERE user_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Property property = extractPropertyFromResultSet(rs);
                property.setImages(getPropertyImages(property.getPropertyId()));
                properties.add(property);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return properties;
    }

    /**
     * Xóa property
     */
    public boolean deleteProperty(int propertyId, int userId) {
        // Chỉ cho phép xóa nếu là chủ sở hữu
        String sql = "DELETE FROM properties WHERE property_id = ? AND user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, propertyId);
            pstmt.setInt(2, userId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    /**
     * Cập nhật thông tin property
     * @param property Property object với thông tin mới
     * @param newImages Danh sách ảnh mới (nếu có)
     * @return true nếu thành công
     */
    public boolean updateProperty(Property property, List<String> newImages) {
        String sqlProperty = "UPDATE properties SET title = ?, description = ?, property_type = ?, " +
                            "transaction_type = ?, price = ?, area = ?, address = ?, city = ?, " +
                            "district = ?, ward = ?, bedrooms = ?, bathrooms = ?, " +
                            "status = 'PENDING' " + // Reset về PENDING để admin duyệt lại
                            "WHERE property_id = ? AND user_id = ?";
        
        String sqlDeleteImages = "DELETE FROM property_images WHERE property_id = ?";
        String sqlInsertImage = "INSERT INTO property_images (property_id, image_url, is_main) VALUES (?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement pstmtProperty = null;
        PreparedStatement pstmtDeleteImages = null;
        PreparedStatement pstmtInsertImage = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // 1. Update property info
            pstmtProperty = conn.prepareStatement(sqlProperty);
            pstmtProperty.setString(1, property.getTitle());
            pstmtProperty.setString(2, property.getDescription());
            pstmtProperty.setString(3, property.getPropertyType());
            pstmtProperty.setString(4, property.getTransactionType());
            pstmtProperty.setDouble(5, property.getPrice());
            pstmtProperty.setDouble(6, property.getArea());
            pstmtProperty.setString(7, property.getAddress());
            pstmtProperty.setString(8, property.getCity());
            pstmtProperty.setString(9, property.getDistrict());
            pstmtProperty.setString(10, property.getWard());
            pstmtProperty.setInt(11, property.getBedrooms());
            pstmtProperty.setInt(12, property.getBathrooms());
            pstmtProperty.setInt(13, property.getPropertyId());
            pstmtProperty.setInt(14, property.getUserId());
            
            int updated = pstmtProperty.executeUpdate();
            
            if (updated == 0) {
                conn.rollback();
                return false;
            }
            
            // 2. Update images nếu có ảnh mới
            if (newImages != null && !newImages.isEmpty()) {
                // Xóa ảnh cũ
                pstmtDeleteImages = conn.prepareStatement(sqlDeleteImages);
                pstmtDeleteImages.setInt(1, property.getPropertyId());
                pstmtDeleteImages.executeUpdate();
                
                // Thêm ảnh mới
                pstmtInsertImage = conn.prepareStatement(sqlInsertImage);
                for (int i = 0; i < newImages.size(); i++) {
                    pstmtInsertImage.setInt(1, property.getPropertyId());
                    pstmtInsertImage.setString(2, newImages.get(i));
                    pstmtInsertImage.setBoolean(3, i == 0);
                    pstmtInsertImage.addBatch();
                }
                pstmtInsertImage.executeBatch();
            }
            
            conn.commit();
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            try {
                if (pstmtInsertImage != null) pstmtInsertImage.close();
                if (pstmtDeleteImages != null) pstmtDeleteImages.close();
                if (pstmtProperty != null) pstmtProperty.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Xóa một ảnh cụ thể
     */
    public boolean deleteImage(int imageId, int userId) {
        String sql = "DELETE pi FROM property_images pi " +
                     "JOIN properties p ON pi.property_id = p.property_id " +
                     "WHERE pi.image_id = ? AND p.user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, imageId);
            pstmt.setInt(2, userId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
 // Thêm các method này vào class PropertyDAO.java

    /**
     * Lấy tất cả properties cho admin (không filter status)
     */
    public List<Property> getAllPropertiesForAdmin() {
        List<Property> properties = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name, u.phone FROM properties p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "ORDER BY p.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Property property = extractPropertyFromResultSet(rs);
                property.setImages(getPropertyImages(property.getPropertyId()));
                properties.add(property);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return properties;
    }

    /**
     * Lấy properties theo status
     */
    public List<Property> getPropertiesByStatus(String status) {
        List<Property> properties = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name, u.phone FROM properties p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.status = ? " +
                     "ORDER BY p.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Property property = extractPropertyFromResultSet(rs);
                property.setImages(getPropertyImages(property.getPropertyId()));
                properties.add(property);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return properties;
    }

    /**
     * Cập nhật status của property
     */
    public boolean updatePropertyStatus(int propertyId, String status) {
        String sql = "UPDATE properties SET status = ? WHERE property_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, propertyId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Admin xóa property (không cần check userId)
     */
    public boolean deletePropertyByAdmin(int propertyId) {
        String sql = "DELETE FROM properties WHERE property_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, propertyId);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Đếm tổng số properties
     */
    public int getTotalProperties() {
        String sql = "SELECT COUNT(*) FROM properties";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }

    /**
     * Đếm properties theo status
     */
    public int getPendingPropertiesCount() {
        return getPropertiesCountByStatus("PENDING");
    }

    public int getApprovedPropertiesCount() {
        return getPropertiesCountByStatus("APPROVED");
    }

    public int getRejectedPropertiesCount() {
        return getPropertiesCountByStatus("REJECTED");
    }

    private int getPropertiesCountByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM properties WHERE status = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
}