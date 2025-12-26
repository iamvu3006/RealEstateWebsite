<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${property.title} - Real Estate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .main-image {
            width: 100%;
            height: 500px;
            object-fit: cover;
            border-radius: 10px;
        }
        .thumbnail {
            width: 100%;
            height: 100px;
            object-fit: cover;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.2s;
            border: 2px solid transparent;
        }
        .thumbnail:hover {
            transform: scale(1.05);
            border-color: #0d6efd;
        }
        .info-box {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .contact-box {
            position: sticky;
            top: 20px;
            background: white;
            border: 2px solid #0d6efd;
            border-radius: 10px;
            padding: 20px;
        }
        .favorite-btn {
            transition: all 0.3s;
        }
        .favorite-btn:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <jsp:include page="common/header.jsp" />
    
    <div class="container my-5">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/properties">Bất động sản</a></li>
                <li class="breadcrumb-item active">${property.title}</li>
            </ol>
        </nav>
        
        <div class="row">
            <!-- Left Column - Property Details -->
            <div class="col-md-8">
                <!-- Title and Status -->
                <h2 class="mb-3">${property.title}</h2>
                <p class="text-muted mb-3">
                    📍 ${property.address}, ${property.ward}, ${property.district}, ${property.city}
                </p>
                <p class="mb-4">
                    <span class="badge bg-info">${property.propertyType}</span>
                    <span class="badge bg-success">${property.transactionType}</span>
                    <span class="badge bg-secondary">👁️ ${property.viewCount} lượt xem</span>
                </p>
                
                <!-- Price -->
                <h3 class="text-danger mb-4">
                    <fmt:formatNumber value="${property.price}" type="number" /> VNĐ
                </h3>
                
                <!-- Image Gallery -->
                <div class="mb-4">
                    <c:choose>
                        <c:when test="${not empty property.images}">
                            <img src="${pageContext.request.contextPath}${property.images[0]}" 
                                 class="main-image mb-3" id="mainImage" alt="${property.title}"
                                 onerror="this.src='https://via.placeholder.com/800x500?text=No+Image'">
                            
                            <c:if test="${property.images.size() > 1}">
                                <div class="row g-2">
                                    <c:forEach var="image" items="${property.images}" varStatus="status">
                                        <div class="col-3">
                                            <img src="${pageContext.request.contextPath}${image}" 
                                                 class="thumbnail" 
                                                 onclick="changeImage('${pageContext.request.contextPath}${image}')"
                                                 alt="Ảnh ${status.index + 1}"
                                                 onerror="this.src='https://via.placeholder.com/150?text=No+Image'">
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/800x500?text=No+Image+Available" 
                                 class="main-image mb-3" alt="No image">
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Property Information -->
                <div class="info-box">
                    <h5 class="mb-3">📋 Thông tin chi tiết</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <strong>Diện tích:</strong> ${property.area} m²
                        </div>
                        <c:if test="${property.bedrooms > 0}">
                            <div class="col-md-6 mb-3">
                                <strong>Phòng ngủ:</strong> ${property.bedrooms}
                            </div>
                        </c:if>
                        <c:if test="${property.bathrooms > 0}">
                            <div class="col-md-6 mb-3">
                                <strong>Phòng tắm:</strong> ${property.bathrooms}
                            </div>
                        </c:if>
                        <div class="col-md-6 mb-3">
                            <strong>Loại hình:</strong> 
                            <c:choose>
                                <c:when test="${property.propertyType == 'HOUSE'}">Nhà ở</c:when>
                                <c:when test="${property.propertyType == 'APARTMENT'}">Chung cư</c:when>
                                <c:when test="${property.propertyType == 'LAND'}">Đất nền</c:when>
                                <c:when test="${property.propertyType == 'COMMERCIAL'}">Thương mại</c:when>
                            </c:choose>
                        </div>
                        <div class="col-md-6 mb-3">
                            <strong>Giao dịch:</strong> 
                            ${property.transactionType == 'SALE' ? 'Bán' : 'Cho thuê'}
                        </div>
                        <div class="col-md-6 mb-3">
                            <strong>Ngày đăng:</strong> 
                            <fmt:formatDate value="${property.createdAt}" pattern="dd/MM/yyyy" />
                        </div>
                    </div>
                </div>
                
                <!-- Description -->
                <div class="info-box">
                    <h5 class="mb-3">📝 Mô tả chi tiết</h5>
                    <p style="white-space: pre-wrap;">${property.description}</p>
                </div>
                
                <!-- Map placeholder -->
                <div class="info-box">
                    <h5 class="mb-3">🗺️ Vị trí</h5>
                    <p class="text-muted">
                        <i>Chức năng bản đồ sẽ được cập nhật sau</i><br>
                        Địa chỉ: ${property.address}, ${property.ward}, ${property.district}, ${property.city}
                    </p>
                </div>
            </div>
            
            <!-- Right Column - Contact & Actions -->
            <div class="col-md-4">
                <div class="contact-box">
                    <h5 class="mb-3">📞 Thông tin liên hệ</h5>
                    
                    <div class="mb-3">
                        <label class="text-muted">Người đăng:</label>
                        <p class="fw-bold mb-0">${property.ownerName}</p>
                    </div>
                    
                    <div class="mb-4">
                        <label class="text-muted">Số điện thoại:</label>
                        <p class="fw-bold fs-5 text-primary mb-0">
                            <a href="tel:${property.ownerPhone}" class="text-decoration-none">
                                ${property.ownerPhone}
                            </a>
                        </p>
                    </div>
                    
                    <a href="tel:${property.ownerPhone}" class="btn btn-primary w-100 mb-2">
                        📞 Gọi ngay
                    </a>
                    
                    <!-- FAVORITE BUTTON -->
                    <c:choose>
                        <c:when test="${sessionScope.user == null}">
                            <!-- Chưa đăng nhập -->
                            <button class="btn btn-outline-danger w-100 favorite-btn" 
                                    onclick="showLoginRequired()">
                                ❤️ Thêm vào yêu thích
                            </button>
                        </c:when>
                        <c:when test="${sessionScope.userId == property.userId}">
                            <!-- Là chủ tin đăng -->
                            <hr>
                            <p class="text-muted small mb-2">Đây là tin đăng của bạn</p>
                            <a href="${pageContext.request.contextPath}/edit-property?id=${property.propertyId}" 
                               class="btn btn-warning w-100 mb-2">✏️ Sửa tin</a>
                            <button class="btn btn-danger w-100" 
                                    onclick="confirmDelete(${property.propertyId})">
                                🗑️ Xóa tin
                            </button>
                        </c:when>
                        <c:otherwise>
                            <!-- Đã đăng nhập, không phải chủ tin -->
                            <button class="btn btn-outline-danger w-100 favorite-btn" 
                                    id="favoriteBtn"
                                    onclick="toggleFavorite(${property.propertyId})">
                                ❤️ <span id="favoriteText">Thêm vào yêu thích</span>
                            </button>
                            
                            <small class="text-muted d-block mt-2 text-center" id="favoriteStatus"></small>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Change main image
        function changeImage(imageSrc) {
            document.getElementById('mainImage').src = imageSrc;
        }
        
        // Delete property
        function confirmDelete(propertyId) {
            if (confirm('Bạn có chắc chắn muốn xóa tin đăng này?')) {
                window.location.href = '${pageContext.request.contextPath}/delete-property?id=' + propertyId;
            }
        }
        
        // Show login required modal
        function showLoginRequired() {
            alert('Bạn cần đăng nhập để sử dụng tính năng này!');
            window.location.href = '${pageContext.request.contextPath}/login';
        }
        
        // Toggle favorite
        function toggleFavorite(propertyId) {
            const btn = document.getElementById('favoriteBtn');
            const text = document.getElementById('favoriteText');
            const status = document.getElementById('favoriteStatus');
            
            btn.disabled = true;
            status.textContent = 'Đang xử lý...';
            
            fetch('${pageContext.request.contextPath}/favorite', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'propertyId=' + propertyId + '&action=toggle'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    if (data.isFavorite) {
                        btn.classList.remove('btn-outline-danger');
                        btn.classList.add('btn-danger');
                        text.textContent = 'Đã yêu thích';
                        status.textContent = '✅ Đã thêm vào yêu thích';
                    } else {
                        btn.classList.remove('btn-danger');
                        btn.classList.add('btn-outline-danger');
                        text.textContent = 'Thêm vào yêu thích';
                        status.textContent = 'Đã xóa khỏi yêu thích';
                    }
                    
                    setTimeout(() => {
                        status.textContent = '';
                    }, 3000);
                } else {
                    alert(data.message || 'Có lỗi xảy ra!');
                }
                btn.disabled = false;
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra! Vui lòng thử lại.');
                btn.disabled = false;
            });
        }
        
        // Check if property is already favorited
        <c:if test="${sessionScope.user != null && sessionScope.userId != property.userId}">
        window.addEventListener('DOMContentLoaded', function() {
            fetch('${pageContext.request.contextPath}/favorite?propertyId=${property.propertyId}&action=check')
                .then(response => response.json())
                .then(data => {
                    if (data.isFavorite) {
                        const btn = document.getElementById('favoriteBtn');
                        const text = document.getElementById('favoriteText');
                        btn.classList.remove('btn-outline-danger');
                        btn.classList.add('btn-danger');
                        text.textContent = 'Đã yêu thích';
                    }
                })
                .catch(error => console.error('Error checking favorite:', error));
        });
        </c:if>
    </script>
</body>
</html>