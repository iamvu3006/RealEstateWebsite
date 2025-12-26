<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%-- Debug --%>
<%
    System.out.println("DEBUG: In my-properties.jsp");
    Object userId = session.getAttribute("userId");
    System.out.println("DEBUG: User ID in session: " + userId);
    
    java.util.List<com.realestate.model.Property> props = 
        (java.util.List<com.realestate.model.Property>) request.getAttribute("properties");
    System.out.println("DEBUG: Properties list size: " + (props != null ? props.size() : "null"));
    if (props != null) {
        for (com.realestate.model.Property p : props) {
            System.out.println("  - ID: " + p.getPropertyId() + 
                             ", Title: " + p.getTitle() + 
                             ", Status: " + p.getStatus());
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tin đăng của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .status-badge {
            font-size: 0.85em;
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
    <jsp:include page="common/header.jsp" />
    
    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>📋 Tin đăng của tôi</h2>
            <a href="${pageContext.request.contextPath}/create-property" class="btn btn-primary">
                ➕ Đăng tin mới
            </a>
        </div>
        
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
        
        <div class="card shadow">
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty properties}">
                        <div class="text-center py-5">
                            <h5 class="text-muted">Bạn chưa có tin đăng nào</h5>
                            <p>Hãy đăng tin đầu tiên để bắt đầu!</p>
                            <a href="${pageContext.request.contextPath}/create-property" 
                               class="btn btn-primary">Đăng tin ngay</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive property-table">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th style="width: 100px;">Ảnh</th>
                                        <th>Tiêu đề</th>
                                        <th style="width: 120px;">Giá</th>
                                        <th style="width: 100px;">Diện tích</th>
                                        <th style="width: 120px;">Trạng thái</th>
                                        <th style="width: 100px;">Lượt xem</th>
                                        <th style="width: 120px;">Ngày đăng</th>
                                        <th style="width: 150px;">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="property" items="${properties}">
                                        <tr>
                                            <td>
                                                <img src="${pageContext.request.contextPath}${property.mainImage}" 
                                                     alt="${property.title}">
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}" 
                                                   class="text-decoration-none fw-bold">
                                                    ${property.title}
                                                </a>
                                                <br>
                                                <small class="text-muted">
                                                    ${property.district}, ${property.city}
                                                </small>
                                            </td>
                                            <td class="text-danger fw-bold">
                                                <fmt:formatNumber value="${property.price}" type="number" />
                                            </td>
                                            <td>${property.area} m²</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${property.status == 'PENDING'}">
                                                        <span class="badge bg-warning status-badge">⏳ Chờ duyệt</span>
                                                    </c:when>
                                                    <c:when test="${property.status == 'APPROVED'}">
                                                        <span class="badge bg-success status-badge">✅ Đã duyệt</span>
                                                    </c:when>
                                                    <c:when test="${property.status == 'REJECTED'}">
                                                        <span class="badge bg-danger status-badge">❌ Từ chối</span>
                                                    </c:when>
                                                    <c:when test="${property.status == 'SOLD'}">
                                                        <span class="badge bg-secondary status-badge">💰 Đã bán</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">👁️ ${property.viewCount}</span>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${property.createdAt}" pattern="dd/MM/yyyy" />
                                            </td>
                                            <td>
                                                <div class="btn-group btn-group-sm" role="group">
                                                    <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}" 
                                                       class="btn btn-outline-primary" title="Xem">
                                                        👁️
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/edit-property?id=${property.propertyId}" 
                                                       class="btn btn-outline-warning" title="Sửa">
                                                        ✏️
                                                    </a>
                                                    <button onclick="confirmDelete(${property.propertyId})" 
                                                            class="btn btn-outline-danger" title="Xóa">
                                                        🗑️
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="mt-3">
                            <p class="text-muted">
                                Tổng số tin đăng: <strong>${properties.size()}</strong>
                            </p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <jsp:include page="common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(propertyId) {
            if (confirm('Bạn có chắc chắn muốn xóa tin đăng này?\n\nLưu ý: Hành động này không thể hoàn tác!')) {
                window.location.href = '${pageContext.request.contextPath}/delete-property?id=' + propertyId;
            }
        }
    </script>
</body>
</html>