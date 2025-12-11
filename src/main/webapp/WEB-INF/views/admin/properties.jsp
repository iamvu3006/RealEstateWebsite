<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tin đăng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: calc(100vh - 56px);
            background: #f8f9fa;
            padding: 20px;
        }
        .sidebar .nav-link {
            color: #333;
            padding: 10px 15px;
            margin-bottom: 5px;
            border-radius: 5px;
        }
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background: #0d6efd;
            color: white;
        }
        .property-table img {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar">
                <h5 class="mb-3">⚙️ Admin Menu</h5>
                <nav class="nav flex-column">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                        📊 Dashboard
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/properties">
                        🏠 Quản lý tin đăng
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                        👥 Quản lý users
                    </a>
                    <hr>
                    <a class="nav-link" href="${pageContext.request.contextPath}/">
                        ← Về trang chủ
                    </a>
                </nav>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-10 p-4">
                <h2 class="mb-4">🏠 Quản Lý Tin Đăng</h2>
                
                <c:if test="${param.success != null}">
                    <div class="alert alert-success alert-dismissible fade show">
                        ${param.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        ${param.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Filter -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <div class="btn-group" role="group">
                                    <a href="${pageContext.request.contextPath}/admin/properties" 
                                       class="btn ${statusFilter == null ? 'btn-primary' : 'btn-outline-primary'}">
                                        Tất cả
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/properties?status=PENDING" 
                                       class="btn ${statusFilter == 'PENDING' ? 'btn-warning' : 'btn-outline-warning'}">
                                        ⏳ Chờ duyệt
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/properties?status=APPROVED" 
                                       class="btn ${statusFilter == 'APPROVED' ? 'btn-success' : 'btn-outline-success'}">
                                        ✅ Đã duyệt
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/properties?status=REJECTED" 
                                       class="btn ${statusFilter == 'REJECTED' ? 'btn-danger' : 'btn-outline-danger'}">
                                        ❌ Từ chối
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-4 text-end">
                                <span class="badge bg-secondary fs-6">Tổng: ${properties.size()} tin</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Properties Table -->
                <div class="card">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty properties}">
                                <div class="text-center py-5">
                                    <h5 class="text-muted">Không có tin đăng nào</h5>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive property-table">
                                    <table class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th style="width: 80px;">ID</th>
                                                <th style="width: 100px;">Ảnh</th>
                                                <th>Tiêu đề</th>
                                                <th style="width: 120px;">Người đăng</th>
                                                <th style="width: 120px;">Giá</th>
                                                <th style="width: 120px;">Trạng thái</th>
                                                <th style="width: 120px;">Ngày đăng</th>
                                                <th style="width: 200px;">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="property" items="${properties}">
                                                <tr>
                                                    <td><strong>#${property.propertyId}</strong></td>
                                                    <td>
                                                        <img src="${pageContext.request.contextPath}${property.mainImage}" 
                                                             alt="${property.title}">
                                                    </td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}" 
                                                           class="text-decoration-none fw-bold" target="_blank">
                                                            ${property.title}
                                                        </a>
                                                        <br>
                                                        <small class="text-muted">
                                                            <span class="badge bg-info">${property.propertyType}</span>
                                                            <span class="badge bg-success">${property.transactionType}</span>
                                                        </small>
                                                    </td>
                                                    <td>
                                                        ${property.ownerName}
                                                        <br>
                                                        <small class="text-muted">${property.ownerPhone}</small>
                                                    </td>
                                                    <td class="text-danger fw-bold">
                                                        <fmt:formatNumber value="${property.price}" type="number" />
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${property.status == 'PENDING'}">
                                                                <span class="badge bg-warning">⏳ Chờ duyệt</span>
                                                            </c:when>
                                                            <c:when test="${property.status == 'APPROVED'}">
                                                                <span class="badge bg-success">✅ Đã duyệt</span>
                                                            </c:when>
                                                            <c:when test="${property.status == 'REJECTED'}">
                                                                <span class="badge bg-danger">❌ Từ chối</span>
                                                            </c:when>
                                                            <c:when test="${property.status == 'SOLD'}">
                                                                <span class="badge bg-secondary">💰 Đã bán</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${property.createdAt}" pattern="dd/MM/yyyy" />
                                                    </td>
                                                    <td>
                                                        <form method="post" action="${pageContext.request.contextPath}/admin/properties" 
                                                              style="display: inline;">
                                                            <input type="hidden" name="propertyId" value="${property.propertyId}">
                                                            
                                                            <c:if test="${property.status == 'PENDING'}">
                                                                <button type="submit" name="action" value="approve" 
                                                                        class="btn btn-sm btn-success" title="Duyệt">
                                                                    ✅
                                                                </button>
                                                                <button type="submit" name="action" value="reject" 
                                                                        class="btn btn-sm btn-warning" title="Từ chối">
                                                                    ❌
                                                                </button>
                                                            </c:if>
                                                            
                                                            <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}" 
                                                               class="btn btn-sm btn-info" title="Xem" target="_blank">
                                                                👁️
                                                            </a>
                                                            
                                                            <button type="submit" name="action" value="delete" 
                                                                    class="btn btn-sm btn-danger" title="Xóa"
                                                                    onclick="return confirm('Bạn có chắc muốn xóa tin này?')">
                                                                🗑️
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>