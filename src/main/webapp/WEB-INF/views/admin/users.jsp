<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý users - Admin</title>
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/properties">
                        🏠 Quản lý tin đăng
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
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
                <h2 class="mb-4">👥 Quản Lý Users</h2>
                
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
                                    <a href="${pageContext.request.contextPath}/admin/users" 
                                       class="btn ${statusFilter == null ? 'btn-primary' : 'btn-outline-primary'}">
                                        Tất cả
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/users?status=ACTIVE" 
                                       class="btn ${statusFilter == 'ACTIVE' ? 'btn-success' : 'btn-outline-success'}">
                                        ✅ Đang hoạt động
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/users?status=BLOCKED" 
                                       class="btn ${statusFilter == 'BLOCKED' ? 'btn-danger' : 'btn-outline-danger'}">
                                        🚫 Đã khóa
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-4 text-end">
                                <span class="badge bg-secondary fs-6">Tổng: ${users.size()} users</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Users Table -->
                <div class="card">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty users}">
                                <div class="text-center py-5">
                                    <h5 class="text-muted">Không có user nào</h5>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th style="width: 80px;">ID</th>
                                                <th>Username</th>
                                                <th>Họ tên</th>
                                                <th>Email</th>
                                                <th>Số điện thoại</th>
                                                <th style="width: 100px;">Role</th>
                                                <th style="width: 120px;">Trạng thái</th>
                                                <th style="width: 120px;">Ngày tạo</th>
                                                <th style="width: 150px;">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="user" items="${users}">
                                                <tr>
                                                    <td><strong>#${user.userId}</strong></td>
                                                    <td>${user.username}</td>
                                                    <td>${user.fullName}</td>
                                                    <td>${user.email}</td>
                                                    <td>${user.phone}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${user.role == 'ADMIN'}">
                                                                <span class="badge bg-danger">👑 ADMIN</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-info">USER</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${user.status == 'ACTIVE'}">
                                                                <span class="badge bg-success">✅ Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">🚫 Blocked</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy" />
                                                    </td>
                                                    <td>
                                                        <c:if test="${user.role != 'ADMIN'}">
                                                            <form method="post" action="${pageContext.request.contextPath}/admin/users" 
                                                                  style="display: inline;">
                                                                <input type="hidden" name="userId" value="${user.userId}">
                                                                
                                                                <c:choose>
                                                                    <c:when test="${user.status == 'ACTIVE'}">
                                                                        <button type="submit" name="action" value="block" 
                                                                                class="btn btn-sm btn-warning" title="Khóa"
                                                                                onclick="return confirm('Bạn có chắc muốn khóa user này?')">
                                                                            🔒 Khóa
                                                                        </button>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <button type="submit" name="action" value="unblock" 
                                                                                class="btn btn-sm btn-success" title="Mở khóa">
                                                                            🔓 Mở
                                                                        </button>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                
                                                                <button type="submit" name="action" value="delete" 
                                                                        class="btn btn-sm btn-danger" title="Xóa"
                                                                        onclick="return confirm('Bạn có chắc muốn xóa user này? Hành động này không thể hoàn tác!')">
                                                                    🗑️
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                        
                                                        <c:if test="${user.role == 'ADMIN'}">
                                                            <span class="text-muted small">Không thể thao tác</span>
                                                        </c:if>
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