package com.realestate.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Test database connection
 * Chạy main method này để test kết nối
 */
public class TestDBConnection {
    
    public static void main(String[] args) {
        System.out.println("=== TESTING DATABASE CONNECTION ===");
        
        try {
            // Test connection
            Connection conn = DBConnection.getConnection();
            System.out.println("✅ Connection SUCCESS!");
            System.out.println("Database: " + conn.getCatalog());
            
            // Test query users
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
            
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("✅ Total users: " + count);
            }
            
            // Test query properties
            rs = stmt.executeQuery("SELECT COUNT(*) FROM properties WHERE status = 'APPROVED'");
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("✅ Approved properties: " + count);
            }
            
            // Test login query
            System.out.println("\n=== TESTING LOGIN QUERY ===");
            rs = stmt.executeQuery("SELECT * FROM users WHERE username = 'admin'");
            
            if (rs.next()) {
                System.out.println("Username: " + rs.getString("username"));
                System.out.println("Password: " + rs.getString("password"));
                System.out.println("Role: " + rs.getString("role"));
                System.out.println("Status: " + rs.getString("status"));
            } else {
                System.out.println("❌ Admin user not found!");
            }
            
            conn.close();
            System.out.println("\n✅ All tests PASSED!");
            
        } catch (Exception e) {
            System.err.println("❌ ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }
}