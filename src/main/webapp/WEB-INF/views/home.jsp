<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Real Estate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 0;
        }
        .property-card {
            transition: transform 0.3s;
            height: 100%;
        }
        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .property-img {
            height: 200px;
            object-fit: cover;
        }
        .price-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255,255,255,0.9);
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
            color: #dc3545;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="common/header.jsp" />
    
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container text-center">
            <h1 class="display-4 mb-4">Tìm ngôi nhà mơ ước của bạn</h1>
            <p class="lead mb-5">Hàng ngàn bất động sản đang chờ đón bạn</p>
            
            <!-- Search Form -->
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <form action="${pageContext.request.contextPath}/properties" method="get" class="bg-white p-4 rounded shadow">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <select name="propertyType" class="form-select">
                                    <option value="">Loại BĐS</option>
                                    <option value="HOUSE">Nhà ở</option>
                                    <option value="APARTMENT">Chung cư</option>
                                    <option value="LAND">Đất nền</option>
                                    <option value="COMMERCIAL">Thương mại</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select name="transactionType" class="form-select">
                                    <option value="">Loại giao dịch</option>
                                    <option value="SALE">Bán</option>
                                    <option value="RENT">Cho thuê</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="keyword" class="form-control" placeholder="Tìm theo địa chỉ, tiêu đề...">
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">🔍 Tìm kiếm</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Latest Properties -->
    <div class="container my-5">
        <h2 class="text-center mb-4">Bất động sản mới nhất</h2>
        
        <div class="row g-4">
            <c:forEach var="property" items="${latestProperties}">
                <div class="col-md-4">
                    <div class="card property-card">
                        <div class="position-relative">
                            <img src="${pageContext.request.contextPath}${property.mainImage}" 
                                 class="card-img-top property-img" alt="${property.title}">
                            <span class="price-badge">
                                <fmt:formatNumber value="${property.price}" type="number" /> VNĐ
                            </span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate">${property.title}</h5>
                            <p class="text-muted mb-2">
                                📍 ${property.district}, ${property.city}
                            </p>
                            <p class="mb-2">
                                <span class="badge bg-info">${property.propertyType}</span>
                                <span class="badge bg-success">${property.transactionType}</span>
                            </p>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">📐 ${property.area} m²</small>
                                <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}" 
                                   class="btn btn-sm btn-outline-primary">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/properties" class="btn btn-primary btn-lg">
                Xem tất cả bất động sản →
            </a>
        </div>
    </div>
    
    <!-- Footer -->
    <jsp:include page="common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>