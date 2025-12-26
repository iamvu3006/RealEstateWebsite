<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng tin bất động sản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
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
        .image-preview-item .remove-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            background: red;
            color: white;
            border: none;
            border-radius: 50%;
            width: 25px;
            height: 25px;
            cursor: pointer;
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="common/header.jsp" />
    
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <h2 class="mb-4">📝 Đăng tin bất động sản</h2>
                
                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <form method="post" action="${pageContext.request.contextPath}/create-property" 
                      enctype="multipart/form-data" id="propertyForm">
                    
                    <!-- Thông tin cơ bản -->
                    <div class="form-section">
                        <h5 class="mb-3">📋 Thông tin cơ bản</h5>
                        
                        <div class="mb-3">
                            <label for="title" class="form-label">Tiêu đề tin đăng *</label>
                            <input type="text" class="form-control" id="title" name="title" 
                                   value="${param.title}" required
                                   placeholder="VD: Bán nhà 3 tầng mặt phố Trần Duy Hưng">
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="propertyType" class="form-label">Loại bất động sản *</label>
                                <select class="form-select" id="propertyType" name="propertyType" required>
                                    <option value="">-- Chọn loại BĐS --</option>
                                    <option value="HOUSE" ${param.propertyType == 'HOUSE' ? 'selected' : ''}>Nhà ở</option>
                                    <option value="APARTMENT" ${param.propertyType == 'APARTMENT' ? 'selected' : ''}>Chung cư</option>
                                    <option value="LAND" ${param.propertyType == 'LAND' ? 'selected' : ''}>Đất nền</option>
                                    <option value="COMMERCIAL" ${param.propertyType == 'COMMERCIAL' ? 'selected' : ''}>Thương mại</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="transactionType" class="form-label">Loại giao dịch *</label>
                                <select class="form-select" id="transactionType" name="transactionType" required>
                                    <option value="">-- Chọn loại giao dịch --</option>
                                    <option value="SALE" ${param.transactionType == 'SALE' ? 'selected' : ''}>Bán</option>
                                    <option value="RENT" ${param.transactionType == 'RENT' ? 'selected' : ''}>Cho thuê</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="price" class="form-label">Giá (VNĐ) *</label>
                                <input type="number" class="form-control" id="price" name="price" 
                                       value="${param.price}" required min="0" step="1000000"
                                       placeholder="VD: 5000000000">
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="area" class="form-label">Diện tích (m²) *</label>
                                <input type="number" class="form-control" id="area" name="area" 
                                       value="${param.area}" required min="0" step="0.1"
                                       placeholder="VD: 80">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="bedrooms" class="form-label">Số phòng ngủ</label>
                                <input type="number" class="form-control" id="bedrooms" name="bedrooms" 
                                       value="${param.bedrooms}" min="0" placeholder="VD: 3">
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="bathrooms" class="form-label">Số phòng tắm</label>
                                <input type="number" class="form-control" id="bathrooms" name="bathrooms" 
                                       value="${param.bathrooms}" min="0" placeholder="VD: 2">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả chi tiết *</label>
                            <textarea class="form-control" id="description" name="description" 
                                      rows="6" required placeholder="Mô tả chi tiết về bất động sản...">${param.description}</textarea>
                            <small class="text-muted">Mô tả càng chi tiết càng dễ bán/cho thuê</small>
                        </div>
                    </div>
                    
                    <!-- Địa chỉ -->
                    <div class="form-section">
                        <h5 class="mb-3">📍 Địa chỉ</h5>
                        
                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ *</label>
                            <input type="text" class="form-control" id="address" name="address" 
                                   value="${param.address}" required
                                   placeholder="VD: Số 123 Đường ABC">
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="city" class="form-label">Thành phố/Tỉnh *</label>
                                <input type="text" class="form-control" id="city" name="city" 
                                       value="${param.city}" required placeholder="VD: Hà Nội">
                            </div>
                            
                            <div class="col-md-4 mb-3">
                                <label for="district" class="form-label">Quận/Huyện *</label>
                                <input type="text" class="form-control" id="district" name="district" 
                                       value="${param.district}" required placeholder="VD: Cầu Giấy">
                            </div>
                            
                            <div class="col-md-4 mb-3">
                                <label for="ward" class="form-label">Phường/Xã</label>
                                <input type="text" class="form-control" id="ward" name="ward" 
                                       value="${param.ward}" placeholder="VD: Dịch Vọng">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Hình ảnh -->
                    <div class="form-section">
                        <h5 class="mb-3">📷 Hình ảnh</h5>
                        <p class="text-muted">Tối đa 10 ảnh. Ảnh đầu tiên sẽ là ảnh đại diện.</p>
                        
                        <div class="mb-3">
                            <input type="file" class="form-control" id="images" name="images" 
                                   accept="image/*" multiple onchange="previewImages(event)">
                            <small class="text-muted">Chấp nhận: JPG, JPEG, PNG, GIF (Tối đa 10MB/ảnh)</small>
                        </div>
                        
                        <div id="imagePreview" class="image-preview"></div>
                    </div>
                    
                    <!-- Buttons -->
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary btn-lg px-5">
                            ✅ Đăng tin
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
                
                // FIX: Dùng JavaScript thuần
                let html = '<img src="' + e.target.result + '" alt="Preview">';
                html += '<button type="button" class="remove-btn" onclick="removeImage(this, ' + i + ')">×</button>';
                
                if (i === 0) {
                    html += '<span class="badge bg-primary position-absolute" style="bottom:5px;left:5px">Ảnh chính</span>';
                }
                
                div.innerHTML = html;
                preview.appendChild(div);
            };
            reader.readAsDataURL(file);
        }
    }
    
    function removeImage(btn, index) {
        const input = document.getElementById('images');
        const dt = new DataTransfer();
        const files = input.files;
        
        for (let i = 0; i < files.length; i++) {
            if (i !== index) {
                dt.items.add(files[i]);
            }
        }
        
        input.files = dt.files;
        
        // Tạo event object để gọi lại previewImages
        const event = {
            target: input
        };
        previewImages(event);
    }
    
    // Validation form
    document.getElementById('propertyForm').addEventListener('submit', function(e) {
        const price = document.getElementById('price').value;
        const area = document.getElementById('area').value;
        
        if (price <= 0) {
            e.preventDefault();
            alert('Giá phải lớn hơn 0!');
            return false;
        }
        
        if (area <= 0) {
            e.preventDefault();
            alert('Diện tích phải lớn hơn 0!');
            return false;
        }
    });
	</script>
</body>
</html>