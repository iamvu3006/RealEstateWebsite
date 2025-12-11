<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .stat-card {
            border-left: 4px solid;
            transition: transform 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .stat-card.primary { border-color: #0d6efd; }
        .stat-card.success { border-color: #198754; }
        .stat-card.warning { border-color: #ffc107; }
        .stat-card.danger { border-color: #dc3545; }
        .stat-card.info { border-color: #0dcaf0; }
        
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                        📊 Dashboard
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/properties">
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
                <h2 class="mb-4">📊 Dashboard Quản Trị</h2>
                
                <!-- Statistics Cards -->
                <div class="row g-4 mb-4">
                    <!-- Total Users -->
                    <div class="col-md-4">
                        <div class="card stat-card primary">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted mb-2">Tổng Users</h6>
                                        <h2 class="mb-0">${stats.totalUsers}</h2>
                                    </div>
                                    <div class="fs-1">👥</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-outline-primary mt-3 w-100">
                                    Xem chi tiết →
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Total Properties -->
                    <div class="col-md-4">
                        <div class="card stat-card info">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted mb-2">Tổng Tin Đăng</h6>
                                        <h2 class="mb-0">${stats.totalProperties}</h2>
                                    </div>
                                    <div class="fs-1">🏠</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/properties" class="btn btn-sm btn-outline-info mt-3 w-100">
                                    Xem chi tiết →
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Pending Properties -->
                    <div class="col-md-4">
                        <div class="card stat-card warning">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted mb-2">Chờ Duyệt</h6>
                                        <h2 class="mb-0">${stats.pendingProperties}</h2>
                                    </div>
                                    <div class="fs-1">⏳</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/properties?status=PENDING" class="btn btn-sm btn-outline-warning mt-3 w-100">
                                    Duyệt ngay →
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Approved Properties -->
                    <div class="col-md-4">
                        <div class="card stat-card success">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted mb-2">Đã Duyệt</h6>
                                        <h2 class="mb-0">${stats.approvedProperties}</h2>
                                    </div>
                                    <div class="fs-1">✅</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/properties?status=APPROVED" class="btn btn-sm btn-outline-success mt-3 w-100">
                                    Xem chi tiết →
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Rejected Properties -->
                    <div class="col-md-4">
                        <div class="card stat-card danger">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted mb-2">Đã Từ Chối</h6>
                                        <h2 class="mb-0">${stats.rejectedProperties}</h2>
                                    </div>
                                    <div class="fs-1">❌</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/properties?status=REJECTED" class="btn btn-sm btn-outline-danger mt-3 w-100">
                                    Xem chi tiết →
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">⚡ Thao Tác Nhanh</h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <a href="${pageContext.request.contextPath}/admin/properties?status=PENDING" 
                                   class="btn btn-warning w-100 py-3">
                                    <div class="fs-4 mb-2">⏳</div>
                                    <div>Duyệt Tin Chờ</div>
                                    <small class="text-muted">${stats.pendingProperties} tin</small>
                                </a>
                            </div>
                            <div class="col-md-4">
                                <a href="${pageContext.request.contextPath}/admin/users" 
                                   class="btn btn-info w-100 py-3">
                                    <div class="fs-4 mb-2">👥</div>
                                    <div>Quản Lý Users</div>
                                    <small class="text-muted">${stats.totalUsers} users</small>
                                </a>
                            </div>
                            <div class="col-md-4">
                                <a href="${pageContext.request.contextPath}/admin/properties" 
                                   class="btn btn-success w-100 py-3">
                                    <div class="fs-4 mb-2">🏠</div>
                                    <div>Tất Cả Tin Đăng</div>
                                    <small class="text-muted">${stats.totalProperties} tin</small>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>