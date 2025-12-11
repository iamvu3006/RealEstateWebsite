package com.realestate.controller;

import com.realestate.dao.PropertyDAO;
import com.realestate.model.Property;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/edit-property")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class EditPropertyServlet extends HttpServlet {
    private PropertyDAO propertyDAO = new PropertyDAO();
    private static final String UPLOAD_DIR = "uploads";
    
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
            response.sendRedirect(request.getContextPath() + "/my-properties");
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(idParam);
            Property property = propertyDAO.getPropertyById(propertyId);
            
            // Kiểm tra quyền sở hữu
            if (property == null || property.getUserId() != userId) {
                response.sendRedirect(request.getContextPath() + 
                    "/my-properties?error=Bạn không có quyền sửa tin này!");
                return;
            }
            
            request.setAttribute("property", property);
            request.getRequestDispatcher("/WEB-INF/views/edit-property.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/my-properties");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        String idParam = request.getParameter("propertyId");
        
        try {
            int propertyId = Integer.parseInt(idParam);
            
            // Kiểm tra quyền sở hữu
            Property existingProperty = propertyDAO.getPropertyById(propertyId);
            if (existingProperty == null || existingProperty.getUserId() != userId) {
                response.sendRedirect(request.getContextPath() + 
                    "/my-properties?error=Bạn không có quyền sửa tin này!");
                return;
            }
            
            // Lấy thông tin từ form
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String propertyType = request.getParameter("propertyType");
            String transactionType = request.getParameter("transactionType");
            double price = Double.parseDouble(request.getParameter("price"));
            double area = Double.parseDouble(request.getParameter("area"));
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String district = request.getParameter("district");
            String ward = request.getParameter("ward");
            
            String bedroomsStr = request.getParameter("bedrooms");
            String bathroomsStr = request.getParameter("bathrooms");
            int bedrooms = (bedroomsStr != null && !bedroomsStr.isEmpty()) ? 
                           Integer.parseInt(bedroomsStr) : 0;
            int bathrooms = (bathroomsStr != null && !bathroomsStr.isEmpty()) ? 
                            Integer.parseInt(bathroomsStr) : 0;
            
            // Validation
            if (title == null || title.trim().isEmpty() ||
                propertyType == null || transactionType == null ||
                address == null || city == null) {
                
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                request.setAttribute("property", existingProperty);
                request.getRequestDispatcher("/WEB-INF/views/edit-property.jsp").forward(request, response);
                return;
            }
            
            // Cập nhật thông tin
            Property property = new Property();
            property.setPropertyId(propertyId);
            property.setUserId(userId);
            property.setTitle(title);
            property.setDescription(description);
            property.setPropertyType(propertyType);
            property.setTransactionType(transactionType);
            property.setPrice(price);
            property.setArea(area);
            property.setAddress(address);
            property.setCity(city);
            property.setDistrict(district);
            property.setWard(ward);
            property.setBedrooms(bedrooms);
            property.setBathrooms(bathrooms);
            
            // Xử lý upload ảnh mới (nếu có)
            List<String> newImages = uploadImages(request);
            
            // Cập nhật database
            boolean success = propertyDAO.updateProperty(property, newImages);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + 
                    "/my-properties?success=Cập nhật tin đăng thành công!");
            } else {
                request.setAttribute("error", "Cập nhật thất bại! Vui lòng thử lại.");
                request.setAttribute("property", property);
                request.getRequestDispatcher("/WEB-INF/views/edit-property.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + 
                "/my-properties?error=Dữ liệu không hợp lệ!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + 
                "/my-properties?error=Có lỗi xảy ra: " + e.getMessage());
        }
    }
    
    private List<String> uploadImages(HttpServletRequest request) throws IOException, ServletException {
        List<String> imagePaths = new ArrayList<>();
        
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
        
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        for (Part part : request.getParts()) {
            String fileName = getFileName(part);
            
            if (fileName != null && !fileName.isEmpty() && isImageFile(fileName)) {
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                String filePath = uploadPath + File.separator + uniqueFileName;
                
                part.write(filePath);
                imagePaths.add("/" + UPLOAD_DIR + "/" + uniqueFileName);
            }
        }
        
        return imagePaths;
    }
    
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String content : contentDisposition.split(";")) {
                if (content.trim().startsWith("filename")) {
                    return content.substring(content.indexOf('=') + 1).trim()
                                  .replace("\"", "");
                }
            }
        }
        return null;
    }
    
    private boolean isImageFile(String fileName) {
        String extension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        return extension.equals("jpg") || extension.equals("jpeg") || 
               extension.equals("png") || extension.equals("gif");
    }
}