<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách bất động sản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .filter-sidebar {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            height: fit-content;
            position: sticky;
            top: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .property-card {
            transition: transform 0.3s;
            margin-bottom: 20px;
            height: 100%;
            border: 1px solid #eaeaea;
            border-radius: 10px;
            overflow: hidden;
        }
        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .property-img {
            height: 200px;
            object-fit: cover;
            width: 100%;
            background-color: #f5f5f5;
        }
        .card-body {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            padding: 15px;
        }
        .price-tag {
            color: #dc3545;
            font-weight: bold;
            font-size: 1.1rem;
        }
        .badge-transaction {
            font-size: 0.75rem;
            padding: 5px 10px;
        }
        .property-title {
            color: #2c3e50;
            font-weight: 600;
            line-height: 1.3;
            height: 40px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        .property-location {
            color: #7f8c8d;
            font-size: 0.9rem;
        }
        .property-meta {
            font-size: 0.85rem;
            color: #666;
        }
    </style>
</head>
<body>
    <jsp:include page="common/header.jsp" />
    
    <div class="container my-5">
        <div class="row">
            <!-- Filter Sidebar -->
            <div class="col-lg-3 col-md-4 mb-4">
                <div class="filter-sidebar">
                    <h5 class="mb-3"><i class="bi bi-filter me-2"></i>Bộ lọc tìm kiếm</h5>
                    <form action="${pageContext.request.contextPath}/properties" method="get">
                        <div class="mb-3">
                            <label class="form-label">Từ khóa</label>
                            <input type="text" name="keyword" class="form-control" 
                                   value="${param.keyword}" placeholder="Nhập từ khóa...">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Loại BĐS</label>
                            <select name="propertyType" class="form-select">
                                <option value="">Tất cả loại</option>
                                <option value="HOUSE" ${param.propertyType == 'HOUSE' ? 'selected' : ''}>Nhà ở</option>
                                <option value="APARTMENT" ${param.propertyType == 'APARTMENT' ? 'selected' : ''}>Chung cư</option>
                                <option value="LAND" ${param.propertyType == 'LAND' ? 'selected' : ''}>Đất nền</option>
                                <option value="COMMERCIAL" ${param.propertyType == 'COMMERCIAL' ? 'selected' : ''}>Thương mại</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Loại giao dịch</label>
                            <select name="transactionType" class="form-select">
                                <option value="">Tất cả</option>
                                <option value="SALE" ${param.transactionType == 'SALE' ? 'selected' : ''}>Bán</option>
                                <option value="RENT" ${param.transactionType == 'RENT' ? 'selected' : ''}>Cho thuê</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Thành phố</label>
                            <input type="text" name="city" class="form-control" 
                                   value="${param.city}" placeholder="VD: Hà Nội, Hồ Chí Minh">
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-search me-1"></i> Áp dụng bộ lọc
                            </button>
                            <a href="${pageContext.request.contextPath}/properties" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i> Xóa lọc
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Property List -->
            <div class="col-lg-9 col-md-8">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="mb-0">Danh sách bất động sản</h4>
                        <p class="text-muted mb-0 mt-1">
                            <i class="bi bi-house-check me-1"></i> Tìm thấy <strong>${properties.size()}</strong> bất động sản
                        </p>
                    </div>
                    
                    <!-- Sort Option -->
                    <div class="dropdown">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" 
                                data-bs-toggle="dropdown">
                            <i class="bi bi-sort-down me-1"></i> Sắp xếp
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="?sort=latest">Mới nhất</a></li>
                            <li><a class="dropdown-item" href="?sort=price_asc">Giá thấp đến cao</a></li>
                            <li><a class="dropdown-item" href="?sort=price_desc">Giá cao đến thấp</a></li>
                        </ul>
                    </div>
                </div>
                
                <c:choose>
                    <c:when test="${empty properties}">
                        <div class="alert alert-info text-center py-5">
                            <i class="bi bi-info-circle display-4 mb-3"></i>
                            <h5 class="mb-3">Không tìm thấy bất động sản nào!</h5>
                            <p class="mb-0">Vui lòng thử lại với các tiêu chí khác hoặc xóa bộ lọc.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                            <c:forEach var="property" items="${properties}">
                                <div class="col">
                                    <div class="card property-card h-100">
                                        <div class="position-relative">
                                            <!-- FIX: Thêm ${pageContext.request.contextPath} giống như home.jsp -->
                                            <img src="${pageContext.request.contextPath}${property.mainImage}" 
                                                 class="card-img-top property-img" 
                                                 alt="${property.title}"
                                                 onerror="this.src='https://via.placeholder.com/400x300?text=No+Image'">
                                            
                                            <!-- Badge loại giao dịch -->
                                            <div class="position-absolute top-0 end-0 m-2">
                                                <span class="badge badge-transaction bg-${property.transactionType == 'SALE' ? 'danger' : 'warning'}">
                                                    ${property.transactionType == 'SALE' ? 'BÁN' : 'CHO THUÊ'}
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <div class="card-body d-flex flex-column">
                                            <!-- Tiêu đề -->
                                            <h6 class="property-title mb-2">
                                                ${property.title}
                                            </h6>
                                            
                                            <!-- Giá -->
                                            <p class="price-tag mb-2">
                                                <fmt:formatNumber value="${property.price}" type="number" maxFractionDigits="0" /> VNĐ
                                                <c:if test="${property.transactionType == 'RENT'}">
                                                    <span class="text-muted small">/tháng</span>
                                                </c:if>
                                            </p>
                                            
                                            <!-- Địa điểm -->
                                            <p class="property-location mb-2">
                                                <i class="bi bi-geo-alt me-1"></i> ${property.district}, ${property.city}
                                            </p>
                                            
                                            <!-- Thông tin bổ sung -->
                                            <div class="property-meta d-flex justify-content-between mb-3">
                                                <span><i class="bi bi-arrows-fullscreen me-1"></i> ${property.area} m²</span>
                                                <span><i class="bi bi-eye me-1"></i> ${property.viewCount}</span>
                                            </div>
                                            
                                            <!-- Button chi tiết -->
                                            <div class="mt-auto">
                                                <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}" 
                                                   class="btn btn-outline-primary w-100">
                                                    <i class="bi bi-eye me-1"></i> Xem chi tiết
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation" class="mt-5">
                                <ul class="pagination justify-content-center">
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}&keyword=${param.keyword}&propertyType=${param.propertyType}&transactionType=${param.transactionType}&city=${param.city}">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </nav>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <jsp:include page="common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>