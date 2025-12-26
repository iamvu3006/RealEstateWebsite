# 🎯 HƯỚNG DẪN DEMO CHI TIẾT - REAL ESTATE WEBSITE

## 📋 CHUẨN BỊ TRƯỚC KHI DEMO

### ✅ Checklist:
- [ ] Eclipse IDE đã cài đặt
- [ ] Apache Tomcat đã cài và config trong Eclipse
- [ ] MySQL đã cài và đang chạy
- [ ] Đã tạo database `real_estate_db`
- [ ] Đã import tất cả file code vào project
- [ ] Đã thêm các thư viện JAR cần thiết
- [ ] Đã chạy script SQL tạo bảng và dữ liệu mẫu
- [ ] Đã tạo ảnh placeholder hoặc config ảnh online

---

## 🚀 BƯỚC 1: SETUP PROJECT

### 1.1. Tạo Database
```sql
CREATE DATABASE real_estate_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE real_estate_db;
```

### 1.2. Chạy script tạo bảng (từ outline ban đầu)
```sql
-- Chạy script tạo 4 bảng: users, properties, property_images, favorites
```

### 1.3. Chạy script dữ liệu mẫu
```sql
-- Chạy file sample_data.sql đã tạo ở trên
```

### 1.4. Kiểm tra dữ liệu
```sql
SELECT COUNT(*) FROM users;        -- Phải có 6 users
SELECT COUNT(*) FROM properties;   -- Phải có ~16 properties
SELECT COUNT(*) FROM property_images; -- Phải có nhiều ảnh
```

### 1.5. Cập nhật DBConnection.java
```java
private static final String URL = "jdbc:mysql://localhost:3306/real_estate_db";
private static final String USER = "root";
private static final String PASSWORD = "YOUR_MYSQL_PASSWORD"; // ← Đổi password của bạn
```

### 1.6. Thêm thư viện JAR vào project
Right-click project → Properties → Java Build Path → Libraries → Add External JARs:
- `mysql-connector-java-8.x.jar`
- `jstl-1.2.jar`
- `standard-1.2.jar`
- `commons-fileupload-1.4.jar`
- `commons-io-2.11.0.jar`

---

## 🎬 BƯỚC 2: CHẠY PROJECT LẦN ĐẦU

### 2.1. Deploy lên Tomcat
1. Right-click project → Run As → Run on Server
2. Chọn Tomcat server
3. Click Finish

### 2.2. Mở trình duyệt
URL: `http://localhost:8080/RealEstateWebsite/`

### 2.3. Kiểm tra lỗi
**Nếu gặp lỗi 404**:
- Kiểm tra project đã deploy chưa
- Kiểm tra context path

**Nếu gặp lỗi Database**:
- Kiểm tra MySQL có đang chạy không
- Kiểm tra username/password trong DBConnection
- Kiểm tra database name

**Nếu gặp lỗi Class not found**:
- Kiểm tra đã thêm đủ JAR libraries chưa
- Clean and Build project lại

---

## 🎭 BƯỚC 3: DEMO CHỨC NĂNG - KỊCH BẢN CHI TIẾT

### 🏠 DEMO 1: TRANG CHỦ (Public)

**Mục tiêu**: Giới thiệu trang chủ, tìm kiếm nhanh

1. **Truy cập trang chủ**: `http://localhost:8080/RealEstateWebsite/`
2. **Quan sát**:
   - Header với logo, menu navigation
   - Hero section với form tìm kiếm
   - Hiển thị 6 BĐS mới nhất
   - Footer

3. **Test tìm kiếm nhanh**:
   - Chọn "Loại BĐS": Nhà ở
   - Chọn "Loại giao dịch": Bán
   - Click "Tìm kiếm"
   - → Phải chuyển sang trang danh sách với kết quả lọc

**Điểm cần check**:
- ✅ Ảnh hiển thị đúng
- ✅ Giá format đúng (có dấu phẩy)
- ✅ Badge hiển thị đẹp
- ✅ Hover card có hiệu ứng

---

### 📋 DEMO 2: DANH SÁCH BẤT ĐỘNG SẢN

**Mục tiêu**: Tìm kiếm, lọc BĐS

1. **Click vào "Bất động sản" ở menu**
2. **Quan sát sidebar lọc**:
   - Từ khóa
   - Loại BĐS
   - Loại giao dịch
   - Thành phố

3. **Test tìm kiếm**:
   - Nhập từ khóa: "Vinhomes"
   - Click "Áp dụng"
   - → Chỉ hiển thị BĐS có từ "Vinhomes"

4. **Test lọc kết hợp**:
   - Loại BĐS: Chung cư
   - Loại giao dịch: Bán
   - Thành phố: Hà Nội
   - → Hiển thị đúng kết quả

**Điểm cần check**:
- ✅ Số kết quả hiển thị đúng
- ✅ Lọc hoạt động chính xác
- ✅ Button "Xóa lọc" hoạt động

---

### 🔍 DEMO 3: CHI TIẾT BẤT ĐỘNG SẢN

**Mục tiêu**: Xem thông tin chi tiết, gallery ảnh

1. **Click vào 1 BĐS bất kỳ**
2. **Quan sát**:
   - Breadcrumb đúng
   - Gallery ảnh (main + thumbnails)
   - Thông tin đầy đủ: giá, diện tích, phòng ngủ/tắm...
   - Mô tả chi tiết
   - Box liên hệ (bên phải)

3. **Test gallery**:
   - Click vào thumbnail → Ảnh chính thay đổi

4. **Test responsive** (nếu có):
   - Thu nhỏ trình duyệt
   - Layout phải thích nghi

**Điểm cần check**:
- ✅ Tất cả thông tin hiển thị đúng
- ✅ Số điện thoại clickable
- ✅ Lượt xem tăng khi refresh
- ✅ Nút "Gọi ngay" hoạt động

---

### 🔐 DEMO 4: ĐĂNG NHẬP & ĐĂNG KÝ

**Scenario 1: Đăng ký tài khoản mới**

1. **Click "Đăng ký" ở header**
2. **Điền form**:
   - Username: `testuser`
   - Password: `test123`
   - Confirm: `test123`
   - Họ tên: `Nguyễn Test`
   - Email: `test@test.com`
   - SĐT: `0999999999`

3. **Click "Đăng ký"**
   - → Chuyển sang trang login với message thành công
   - → Check database: user mới đã được tạo

4. **Test validation**:
   - Thử đăng ký lại username đã tồn tại
   - Thử password không khớp
   - Thử email đã tồn tại

**Scenario 2: Đăng nhập**

1. **Đăng nhập user thường**:
   - Username: `nguyenvana`
   - Password: `user123`
   - Check "Ghi nhớ"
   - → Vào được trang chủ, header hiển thị tên user

2. **Đăng nhập admin**:
   - Logout
   - Username: `admin`
   - Password: `admin123`
   - → Vào được, header có menu "Quản trị"

**Điểm cần check**:
- ✅ Validation form hoạt động
- ✅ Password được hash (check trong DB)
- ✅ Session lưu đúng thông tin
- ✅ Remember me cookie hoạt động

---

### ➕ DEMO 5: ĐĂNG TIN RAO (User)

**Tiền điều kiện**: Đã đăng nhập với user `nguyenvana`

1. **Click "Đăng tin" ở menu**
2. **Điền form đầy đủ**:
   - Tiêu đề: "Bán căn hộ test 2PN"
   - Loại BĐS: Chung cư
   - Loại GD: Bán
   - Giá: 3000000000
   - Diện tích: 80
   - Phòng ngủ: 2
   - Phòng tắm: 1
   - Mô tả: "Đây là tin test..."
   - Địa chỉ: "123 Test Street"
   - Thành phố: "Hà Nội"
   - Quận: "Test District"

3. **Upload ảnh**:
   - Chọn 2-3 ảnh từ máy
   - Quan sát preview

4. **Click "Đăng tin"**
   - → Chuyển sang "Tin của tôi" với message thành công
   - → Tin mới có status "Chờ duyệt"

**Test validation**:
- Thử bỏ trống trường bắt buộc
- Thử nhập giá âm
- Thử upload quá 10 ảnh

**Điểm cần check**:
- ✅ Form validation hoạt động
- ✅ Upload ảnh thành công
- ✅ Ảnh được lưu vào thư mục uploads/
- ✅ Database có record mới
- ✅ Status mặc định là PENDING

---

### 📝 DEMO 6: QUẢN LÝ TIN ĐĂNG (User)

**Tiền điều kiện**: Đã đăng nhập với user có tin đăng

1. **Click "Tin của tôi"**
2. **Quan sát danh sách**:
   - Hiển thị tất cả tin của user
   - Có đầy đủ: ảnh, tiêu đề, giá, trạng thái...
   - Nút: Xem, Sửa, Xóa

3. **Test Xem tin**:
   - Click nút "👁️"
   - → Mở trang chi tiết trong tab mới

4. **Test Sửa tin**:
   - Click nút "✏️"
   - → Mở form sửa với data đã điền sẵn
   - Sửa tiêu đề thành "Căn hộ test - ĐÃ SỬA"
   - Click "Cập nhật"
   - → Quay lại "Tin của tôi" với message thành công
   - → Tin có status lại là PENDING (cần admin duyệt lại)

5. **Test Xóa tin**:
   - Click nút "🗑️"
   - → Hiện confirm dialog
   - Click OK
   - → Tin bị xóa khỏi danh sách

**Điểm cần check**:
- ✅ Chỉ hiển thị tin của user đó
- ✅ Badge status hiển thị đúng màu
- ✅ Sửa tin reset về PENDING
- ✅ Xóa tin thành công

---

### 👑 DEMO 7: ADMIN DASHBOARD

**Tiền điều kiện**: Logout user, login lại với admin

1. **Đăng nhập admin**:
   - Username: `admin`
   - Password: `admin123`

2. **Click "Quản trị" ở menu**
   - → Vào Admin Dashboard

3. **Quan sát Dashboard**:
   - Sidebar menu: Dashboard, Quản lý tin, Quản lý users
   - 5 thẻ thống kê:
     * Tổng Users
     * Tổng Tin Đăng
     * Chờ Duyệt (màu vàng)
     * Đã Duyệt (màu xanh)
     * Đã Từ Chối (màu đỏ)
   - Quick Actions với số liệu

4. **Click vào các thẻ thống kê**:
   - Click "Chờ Duyệt"
   - → Chuyển sang trang Quản lý tin với filter PENDING

**Điểm cần check**:
- ✅ Số liệu thống kê đúng
- ✅ Sidebar highlight menu đúng
- ✅ Link trong thẻ thống kê hoạt động

---

### ✅ DEMO 8: DUYỆT TIN (Admin)

**Mục tiêu**: Duyệt/từ chối/xóa tin

1. **Vào "Quản lý tin đăng"**
2. **Quan sát**:
   - Bộ lọc: Tất cả, Chờ duyệt, Đã duyệt, Từ chối
   - Bảng với đầy đủ thông tin
   - Cột Thao tác có các nút

3. **Click filter "Chờ duyệt"**
   - → Chỉ hiển thị tin PENDING

4. **Test Duyệt tin**:
   - Với tin đầu tiên có status PENDING
   - Click nút "✅"
   - → Tin biến mất khỏi danh sách PENDING
   - Click filter "Đã duyệt"
   - → Tin xuất hiện trong danh sách này

5. **Test Từ chối tin**:
   - Vào filter "Chờ duyệt"
   - Click nút "❌" trên 1 tin
   - → Tin chuyển sang REJECTED

6. **Test Xóa tin**:
   - Click nút "🗑️"
   - → Confirm dialog
   - OK → Tin bị xóa vĩnh viễn

**Điểm cần check**:
- ✅ Filter hoạt động chính xác
- ✅ Duyệt tin thành công
- ✅ Từ chối tin thành công
- ✅ Xóa tin admin không cần check userId

---

### 👥 DEMO 9: QUẢN LÝ USERS (Admin)

**Mục tiêu**: Khóa/mở/xóa user

1. **Click "Quản lý users" ở sidebar**
2. **Quan sát**:
   - Filter: Tất cả, Đang hoạt động, Đã khóa
   - Bảng users với đầy đủ info
   - Role badge: ADMIN (đỏ), USER (xanh)
   - Status badge: Active (xanh), Blocked (đỏ)

3. **Test Khóa user**:
   - Tìm user role=USER, status=ACTIVE
   - Click "🔒 Khóa"
   - → Confirm dialog
   - OK → User chuyển sang BLOCKED
   - Click filter "Đã khóa"
   - → User xuất hiện trong danh sách

4. **Test Mở khóa user**:
   - Tìm user BLOCKED
   - Click "🔓 Mở"
   - → User chuyển về ACTIVE

5. **Test Xóa user**:
   - Click "🗑️" trên 1 user
   - → Confirm
   - OK → User bị xóa

6. **Test bảo vệ Admin**:
   - Thử xóa user có role=ADMIN
   - → Không có nút thao tác
   - Message: "Không thể thao tác"

**Điểm cần check**:
- ✅ Khóa user thành công
- ✅ User bị khóa không login được
- ✅ Mở khóa user thành công
- ✅ Không thể xóa/khóa admin

---

## 🧪 BƯỚC 4: TEST CÁC TRƯỜNG HỢP ĐẶC BIỆT

### Test 1: User bị khóa thử đăng nhập
```
Username: hoangvane (đã bị khóa trong sample data)
Password: user123
→ Phải báo lỗi: "Tài khoản đã bị khóa"
```

### Test 2: User thử sửa tin của người khác
```
1. Login user A
2. Copy URL sửa tin của user B
3. Paste vào browser
→ Phải redirect về "Tin của tôi" với message lỗi
```

### Test 3: User thường thử vào admin panel
```
1. Login user thường
2. Vào URL: /admin/dashboard
→ Phải redirect về login
```

### Test 4: Chưa login thử đăng tin
```
1. Logout
2. Truy cập: /create-property
→ Phải redirect về login
```

### Test 5: Upload file không phải ảnh
```
1. Vào form đăng tin
2. Chọn file .pdf hoặc .txt
→ File không được upload, chỉ chấp nhận ảnh
```

### Test 6: SQL Injection
```
Username: admin' OR '1'='1
Password: anything
→ Không được đăng nhập (PreparedStatement đã chặn)
```

---

## 📊 BƯỚC 5: CHECKLIST DEMO HOÀN CHỈNH

### ✅ Frontend
- [ ] Tất cả trang load được
- [ ] Header/Footer hiển thị đúng
- [ ] Navigation menu hoạt động
- [ ] Form validation hoạt động
- [ ] Button hover có hiệu ứng
- [ ] Alert message hiển thị đẹp

### ✅ Authentication
- [ ] Đăng ký thành công
- [ ] Đăng nhập thành công
- [ ] Session lưu đúng
- [ ] Logout hoạt động
- [ ] Remember me hoạt động
- [ ] Filter bảo vệ route

### ✅ User Functions
- [ ] Xem danh sách BĐS
- [ ] Tìm kiếm/lọc hoạt động
- [ ] Xem chi tiết BĐS
- [ ] Đăng tin thành công
- [ ] Upload ảnh thành công
- [ ] Sửa tin thành công
- [ ] Xóa tin thành công

### ✅ Admin Functions
- [ ] Dashboard hiển thị thống kê đúng
- [ ] Duyệt tin thành công
- [ ] Từ chối tin thành công
- [ ] Xóa tin thành công
- [ ] Khóa user thành công
- [ ] Mở khóa user thành công
- [ ] Xóa user thành công
- [ ] Không thể xóa admin

### ✅ Database
- [ ] Data insert đúng
- [ ] Foreign key hoạt động
- [ ] Cascade delete hoạt động
- [ ] Transaction hoạt động

### ✅ Security
- [ ] Password được hash
- [ ] SQL Injection bị chặn
- [ ] Authorization hoạt động
- [ ] Session timeout hoạt động

---

## 🐛 BƯỚC 6: XỬ LÝ LỖI THƯỜNG GẶP

### Lỗi 1: 404 Not Found
**Nguyên nhân**: URL mapping sai
**Giải pháp**:
- Check @WebServlet annotation
- Check context path trong URL
- Restart server

### Lỗi 2: Cannot connect to database
**Nguyên nhân**: MySQL không chạy hoặc config sai
**Giải pháp**:
- Start MySQL service
- Check username/password trong DBConnection
- Check database name

### Lỗi 3: ClassNotFoundException
**Nguyên nhân**: Thiếu JAR libraries
**Giải pháp**:
- Add lại tất cả JAR files
- Clean and Build project
- Restart Eclipse

### Lỗi 4: Ảnh không hiển thị
**Nguyên nhân**: Path ảnh sai hoặc thiếu file
**Giải pháp**:
- Check thư mục uploads/ đã có ảnh chưa
- Check path trong database đúng chưa
- Hoặc dùng ảnh placeholder online

### Lỗi 5: Upload ảnh fail
**Nguyên nhân**: Thiếu commons-fileupload library
**Giải pháp**:
- Add commons-fileupload-1.4.jar
- Add commons-io-2.11.0.jar
- Restart server

### Lỗi 6: JSP compile error
**Nguyên nhân**: Thiếu JSTL library
**Giải pháp**:
- Add jstl-1.2.jar
- Add standard-1.2.jar
- Clean project

---

## 🎓 KẾT LUẬN

Sau khi hoàn thành tất cả các bước demo trên, project của bạn đã:

✅ **Có đầy đủ chức năng cơ bản**
✅ **Hoạt động ổn định**
✅ **Có dữ liệu mẫu để demo**
✅ **Đạt yêu cầu bài tập nhóm**

**Điểm cộng nếu có**:
- Giao diện đẹp, responsive
- Code clean, có comment
- Xử lý lỗi tốt
- Có validation đầy đủ
- Security tốt

**Chúc bạn demo thành công! 🎉**
