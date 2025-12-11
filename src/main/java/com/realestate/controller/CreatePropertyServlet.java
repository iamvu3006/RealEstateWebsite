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

@WebServlet("/create-property")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class CreatePropertyServlet extends HttpServlet {
    private PropertyDAO propertyDAO = new PropertyDAO();
    
    // Thư mục lưu ảnh
    private static final String UPLOAD_DIR = "uploads";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra đã đăng nhập chưa
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/views/create-property.jsp").forward(request, response);
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
        
        try {
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
                request.getRequestDispatcher("/WEB-INF/views/create-property.jsp").forward(request, response);
                return;
            }
            
            // Tạo object Property
            Property property = new Property();
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
            
            // Xử lý upload ảnh
            List<String> uploadedImages = uploadImages(request);
            
            // Lưu property vào database
            int propertyId = propertyDAO.createProperty(property, uploadedImages);
            
            if (propertyId > 0) {
                response.sendRedirect(request.getContextPath() + 
                    "/my-properties?success=Đăng tin thành công! Tin đang chờ duyệt.");
            } else {
                request.setAttribute("error", "Đăng tin thất bại! Vui lòng thử lại.");
                request.getRequestDispatcher("/WEB-INF/views/create-property.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ! Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("/WEB-INF/views/create-property.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/create-property.jsp").forward(request, response);
        }
    }
    
    private List<String> uploadImages(HttpServletRequest request) throws IOException, ServletException {
        List<String> imagePaths = new ArrayList<>();
        
        // Lấy đường dẫn thực tế của thư mục uploads
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
        
        // Tạo thư mục nếu chưa có
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // Lấy tất cả các file được upload
        for (Part part : request.getParts()) {
            String fileName = getFileName(part);
            
            // Chỉ xử lý các part là file ảnh
            if (fileName != null && !fileName.isEmpty() && isImageFile(fileName)) {
                // Tạo tên file unique để tránh trùng
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                String filePath = uploadPath + File.separator + uniqueFileName;
                
                // Lưu file
                part.write(filePath);
                
                // Lưu đường dẫn relative
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