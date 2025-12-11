<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa tin đăng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .existing-image {
            position: relative;
            display: inline-block;
            margin: 5px;
        }
        .existing-image img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 5px;
        }
        .image-preview {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }
        .image-preview-item {
            position: relative;
            width: 150px;
            height: 150px;
        }
        .image-preview-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 5px;
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="common/header.jsp" />
    
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>✏️ Sửa tin đăng</h2>
                    <a href="${pageContext.request.contextPath}/my-properties" class="btn btn-secondary">
                        ← Quay lại
                    </a>
                </div>
                
                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <div class="alert alert-warning">
                    <strong>⚠️ Lưu ý:</strong> Sau khi sửa, tin đăng sẽ được chuyển về trạng thái "Chờ duyệt" và cần admin phê duyệt lại.
                </div>
                
                <form method="post" action="${pageContext.request.contextPath}/edit-property" 
                      enctype="multipart/form-data">
                    
                    <input type="hidden" name="propertyId" value="${property.propertyId}">
                    
                    <!-- Thông tin cơ bản -->
                    <div class="form-section">
                        <h5 class="mb-3">📋 Thông tin cơ bản</h5>
                        
                        <div class="mb-3">
                            <label for="title" class="form-label">Tiêu đề tin đăng *</label>
                            <input type="text" class="form-control" id="title" name="title" 
                                   value="${property.title}" required>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="propertyType" class="form-label">Loại bất động sản *</label>
                                <select class="form-select" id="propertyType" name="propertyType" required>
                                    <option value="HOUSE" ${property.propertyType == 'HOUSE' ? 'selected' : ''}>Nhà ở</option>
                                    <option value="APARTMENT" ${property.propertyType == 'APARTMENT' ? 'selected' : ''}>Chung cư</option>
                                    <option value="LAND" ${property.propertyType == 'LAND' ? 'selected' : ''}>Đất nền</option>
                                    <option value="COMMERCIAL" ${property.propertyType == 'COMMERCIAL' ? 'selected' : ''}>Thương mại</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="transactionType" class="form-label">Loại giao dịch *</label>
                                <select class="form-select" id="transactionType" name="transactionType" required>
                                    <option value="SALE" ${property.transactionType == 'SALE' ? 'selected' : ''}>Bán</option>
                                    <option value="RENT" ${property.transactionType == 'RENT' ? 'selected' : ''}>Cho thuê</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="price" class="form-label">Giá (VNĐ) *</label>
                                <input type="number" class="form-control" id="price" name="price" 
                                       value="${property.price}" required min="0" step="1000000">
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="area" class="form-label">Diện tích (m²) *</label>
                                <input type="number" class="form-control" id="area" name="area" 
                                       value="${property.area}" required min="0" step="0.1">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="bedrooms" class="form-label">Số phòng ngủ</label>
                                <input type="number" class="form-control" id="bedrooms" name="bedrooms" 
                                       value="${property.bedrooms}" min="0">
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="bathrooms" class="form-label">Số phòng tắm</label>
                                <input type="number" class="form-control" id="bathrooms" name="bathrooms" 
                                       value="${property.bathrooms}" min="0">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả chi tiết *</label>
                            <textarea class="form-control" id="description" name="description" 
                                      rows="6" required>${property.description}</textarea>
                        </div>
                    </div>
                    
                    <!-- Địa chỉ -->
                    <div class="form-section">
                        <h5 class="mb-3">📍 Địa chỉ</h5>
                        
                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ *</label>
                            <input type="text" class="form-control" id="address" name="address" 
                                   value="${property.address}" required>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="city" class="form-label">Thành phố/Tỉnh *</label>
                                <input type="text" class="form-control" id="city" name="city" 
                                       value="${property.city}" required>
                            </div>
                            
                            <div class="col-md-4 mb-3">
                                <label for="district" class="form-label">Quận/Huyện *</label>
                                <input type="text" class="form-control" id="district" name="district" 
                                       value="${property.district}" required>
                            </div>
                            
                            <div class="col-md-4 mb-3">
                                <label for="ward" class="form-label">Phường/Xã</label>
                                <input type="text" class="form-control" id="ward" name="ward" 
                                       value="${property.ward}">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Hình ảnh -->
                    <div class="form-section">
                        <h5 class="mb-3">📷 Hình ảnh</h5>
                        
                        <c:if test="${not empty property.images}">
                            <div class="mb-3">
                                <label class="form-label">Ảnh hiện tại:</label>
                                <div>
                                    <c:forEach var="image" items="${property.images}" varStatus="status">
                                        <div class="existing-image">
                                            <img src="${pageContext.request.contextPath}${image}" alt="Ảnh ${status.index + 1}">
                                            ${status.index == 0 ? '<span class="badge bg-primary position-absolute" style="bottom:5px;left:5px">Ảnh chính</span>' : ''}
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        
                        <div class="mb-3">
                            <label for="images" class="form-label">Tải ảnh mới (Nếu muốn thay đổi)</label>
                            <input type="file" class="form-control" id="images" name="images" 
                                   accept="image/*" multiple onchange="previewImages(event)">
                            <small class="text-muted">
                                Nếu bạn tải ảnh mới, tất cả ảnh cũ sẽ bị thay thế. Tối đa 10 ảnh.
                            </small>
                        </div>
                        
                        <div id="imagePreview" class="image-preview"></div>
                    </div>
                    
                    <!-- Buttons -->
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary btn-lg px-5">
                            ✅ Cập nhật
                        </button>
                        <a href="${pageContext.request.contextPath}/my-properties" 
                           class="btn btn-secondary btn-lg px-5 ms-2">
                            ❌ Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImages(event) {
            const files = event.target.files;
            const preview = document.getElementById('imagePreview');
            preview.innerHTML = '';
            
            if (files.length > 10) {
                alert('Chỉ được chọn tối đa 10 ảnh!');
                event.target.value = '';
                return;
            }
            
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                
                if (!file.type.startsWith('image/')) {
                    continue;
                }
                
                const reader = new FileReader();
                reader.onload = function(e) {
                    const div = document.createElement('div');
                    div.className = 'image-preview-item';
                    div.innerHTML = `
                        <img src="${e.target.result}" alt="Preview">
                        ${i === 0 ? '<span class="badge bg-primary position-absolute" style="bottom:5px;left:5px">Ảnh chính</span>' : ''}
                    `;
                    preview.appendChild(div);
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>