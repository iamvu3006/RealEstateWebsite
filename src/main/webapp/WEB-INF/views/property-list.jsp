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
    <style>
        .filter-sidebar {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            height: fit-content;
            position: sticky;
            top: 20px;
        }
        .property-card {
            transition: transform 0.3s;
            margin-bottom: 20px;
            height: 100%;
        }
        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .property-img {
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid #eee;
        }
        .card-body {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .price-tag {
            color: #dc3545;
            font-weight: bold;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="common/header.jsp" />
    
    <div class="container my-5">
        <h2 class="mb-4">Danh sách bất động sản</h2>
        
        <div class="row">
            <!-- Filter Sidebar -->
            <div class="col-lg-3 col-md-4 mb-4">
                <div class="filter-sidebar">
                    <h5 class="mb-3">🔍 Bộ lọc</h5>
                    <form action="${pageContext.request.contextPath}/properties" method="get">
                        <div class="mb-3">
                            <label class="form-label">Từ khóa</label>
                            <input type="text" name="keyword" class="form-control" 
                                   value="${keyword}" placeholder="Tìm kiếm...">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Loại BĐS</label>
                            <select name="propertyType" class="form-select">
                                <option value="">Tất cả</option>
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
                                   value="${city}" placeholder="VD: Hà Nội">
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100">Áp dụng</button>
                        <a href="${pageContext.request.contextPath}/properties" class="btn btn-outline-secondary w-100 mt-2">Xóa lọc</a>
                    </form>
                </div>
            </div>
            
            <!-- Property List -->
            <div class="col-lg-9 col-md-8">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <p class="text-muted mb-0">Tìm thấy <strong>${properties.size()}</strong> kết quả</p>
                    
                    <!-- Sort Option (Optional) -->
                    <div class="dropdown">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" 
                                data-bs-toggle="dropdown">
                            Sắp xếp
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="?sort=latest">Mới nhất</a></li>
                            <li><a class="dropdown-item" href="?sort=price_asc">Giá thấp đến cao</a></li>
                            <li><a class="dropdown-item" href="?sort=price_desc">Giá cao đến thấp</a></li>
                        </ul>
                    </div>
                </div>
                
                <c:choose>
                    <c:when test="${empty properties}">
                        <div class="alert alert-info text-center py-5">
                            <h5 class="mb-3">Không tìm thấy bất động sản nào!</h5>
                            <p class="mb-0">Vui lòng thử lại với các tiêu chí khác.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                            <c:forEach var="property" items="${properties}">
                                <div class="col">
                                    <div class="card property-card h-100">
                                        <div class="position-relative">
                                            <img src="${pageContext.request.contextPath}${property.mainImage}" 
                                                 class="card-img-top property-img" alt="${property.title}"
                                                 onerror="this.src='https://via.placeholder.com/400x300?text=No+Image'">
                                            <div class="position-absolute top-0 end-0 m-2">
                                                <span class="badge bg-${property.transactionType == 'SALE' ? 'danger' : 'warning'}">
                                                    ${property.transactionType == 'SALE' ? 'BÁN' : 'CHO THUÊ'}
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <div class="card-body d-flex flex-column">
                                            <h6 class="card-title text-truncate" title="${property.title}">
                                                ${property.title}
                                            </h6>
                                            <p class="price-tag mb-2">
                                                <fmt:formatNumber value="${property.price}" type="number" /> VNĐ
                                            </p>
                                            <p class="text-muted mb-2 small">
                                                <i class="bi bi-geo-alt"></i> ${property.district}, ${property.city}
                                            </p>
                                            
                                            <div class="mt-auto">
                                                <div class="d-flex justify-content-between align-items-center mb-2">
                                                    <span class="badge bg-info">${property.propertyType}</span>
                                                    <div class="text-muted small">
                                                        <span class="me-2">📐 ${property.area} m²</span>
                                                        <span>👁️ ${property.viewCount}</span>
                                                    </div>
                                                </div>
                                                
                                                <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}" 
                                                   class="btn btn-outline-primary w-100">
                                                    Xem chi tiết
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Pagination (Optional) -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation" class="mt-5">
                                <ul class="pagination justify-content-center">
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}&keyword=${keyword}">${i}</a>
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
    <script>
        // Thêm Bootstrap Icons
        document.addEventListener('DOMContentLoaded', function() {
            if (!document.querySelector('link[href*="bootstrap-icons"]')) {
                const link = document.createElement('link');
                link.rel = 'stylesheet';
                link.href = 'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css';
                document.head.appendChild(link);
            }
        });
        
        // Giữ lại giá trị filter khi submit
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            form.addEventListener('submit', function() {
                // Giữ lại giá trị đã chọn
                const selects = form.querySelectorAll('select');
                selects.forEach(select => {
                    localStorage.setItem(select.name, select.value);
                });
            });
        });
    </script>
</body>
</html>