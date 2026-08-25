# ZZZ Shop (Zenless Zone Zero E-Commerce Web) 🌟

[![repo size](https://img.shields.io/github/repo-size/Zhukov2004/Indie-Game-Store-main?style=flat-square)](https://github.com/Zhukov2004/Indie-Game-Store-main)
[![issues](https://img.shields.io/github/issues/Zhukov2004/Indie-Game-Store-main?style=flat-square)](https://github.com/Zhukov2004/Indie-Game-Store-main/issues)
[![license](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](./LICENSE)

**ZZZ Shop** là một ứng dụng Web Thương mại điện tử Full-stack được phát triển bằng **Java Servlet/JSP** và cơ sở dữ liệu **MySQL**, mô phỏng nền tảng cửa hàng trực tuyến chuyên cung cấp các vật phẩm, tài khoản, nạp game và phụ kiện độc quyền của tựa game hành động bom tấn **Zenless Zone Zero (ZZZ)**.

Dự án áp dụng mô hình **MVC (Model - View - Controller)** truyền thống, sử dụng JDBC để tương tác cơ sở dữ liệu, mang đến trải nghiệm mua sắm trực quan với giao diện đậm chất phong cách Urban Fantasy / TV Retro của New Eridu.

---

## 🚀 Tính năng nổi bật

### 👤 Dành cho Khách hàng (Client)
- **🛍️ Cửa hàng & Danh mục:** Tra cứu danh sách nhân vật (Agents), phe phái (Factions), vật phẩm và các gói sản phẩm.
- **🛒 Giỏ hàng & Thanh toán:** Thêm sản phẩm vào giỏ, quản lý số lượng và tiến hành đặt hàng (`CheckoutServlet`).
- **💳 Hệ thống Nạp tiền (Deposit):** Hỗ trợ các bước nạp tiền, xác nhận giao dịch qua mã QR mô phỏng.
- **📦 Quản lý Đơn hàng:** Xem lại lịch sử mua hàng (`order_history.jsp`) và chi tiết từng đơn hàng (`order_detail.jsp`).
- **🔍 Tìm kiếm nhanh:** Tích hợp tìm kiếm không đồng bộ qua AJAX (`SearchAjaxServlet`).
- **🔐 Xác thực tài khoản:** Đăng nhập, đăng ký tài khoản người dùng và quản lý phiên làm việc (Session).

### 🛡️ Dành cho Quản trị viên (Admin CMS)
- **📊 Quản trị hệ thống (`admin.jsp`):** Giao diện quản lý tập trung dành riêng cho Admin.
- **📝 Quản lý Nội dung (CRUD):** Quản lý sản phẩm (`ProductManageServlet`), quản lý tài khoản người dùng (`UserManagerServlet`), quản lý giao dịch (`TransactionManageServlet`) và các bản cập nhật (`UpdateManageServlet`).
- **🛡️ Phân quyền truy cập:** Kiểm soát quyền hạn thông qua Servlet/Filter, chặn người dùng thường truy cập vào các trang quản trị nhạy cảm.

---

## 💻 Công nghệ sử dụng (Tech Stack)

Dự án được xây dựng theo mô hình Monolithic Web App trên nền tảng Java EE / Jakarta EE:

| Thành phần | Công nghệ / Thư viện | Mô tả |
| -------------------- | -------------------------------- | -------------------------------------------------- |
| **Backend** | Java, Jakarta Servlet / JSP | Xử lý logic nghiệp vụ, điều hướng request/response |
| **Database** | MySQL | Lưu trữ dữ liệu người dùng, sản phẩm, đơn hàng |
| **Kết nối CSDL** | JDBC (Java Database Connectivity)| Kết nối và thực thi câu lệnh SQL |
| **Web Server** | Apache Tomcat (tích hợp NetBeans) | Chạy và triển khai ứng dụng web |
| **IDE** | Apache NetBeans | Môi trường phát triển chính |
| **Frontend** | HTML5, CSS3 (Custom `style.css`), JSP | Giao diện người dùng, responsive design |

---

## 📂 Cấu trúc dự án

```text
ZZZ_Shop/
├── Web Pages/                      # Tầng View (JSP & Tài nguyên)
│   ├── META-INF/
│   ├── WEB-INF/                    # Cấu hình web.xml, bảo mật
│   ├── images/                     # Tài nguyên hình ảnh của shop
│   ├── includes/                   # Các component dùng chung (header, footer...)
│   ├── admin.jsp                   # Trang quản trị CMS
│   ├── agents.jsp                  # Danh sách nhân vật / agents
│   ├── cart.jsp                    # Giỏ hàng
│   ├── character_detail.jsp        # Chi tiết nhân vật
│   ├── deposit.jsp                 # Trang nạp tiền
│   ├── deposit_confirm.jsp         # Xác nhận nạp tiền
│   ├── deposit_qr.jsp              # QR code nạp tiền
│   ├── faction_view.jsp            # Xem theo phe phái
│   ├── home.jsp                    # Trang chủ cửa hàng
│   ├── index.jsp                   # Trang chuyển hướng / landing
│   ├── login.jsp                   # Đăng nhập
│   ├── order_detail.jsp            # Chi tiết đơn hàng
│   ├── order_history.jsp           # lịch sử mua hàng
│   ├── order_success.jsp           # Đặt hàng thành công
│   ├── product_form.jsp            # Form thêm/sửa sản phẩm
│   ├── register.jsp                # Đăng ký tài khoản
│   ├── style.css                   # File định kiểu giao diện
│   └── update_form.jsp             # Form cập nhật thông tin
│
└── Source Packages/                # Tầng Controller, DAO & Model (Java)
    ├── controller/                 # Các Servlet điều hướng
    │   ├── AdminServlet.java
    │   ├── AgentServlet.java
    │   ├── CartServlet.java
    │   ├── CharacterDetailServlet.java
    │   ├── CheckoutServlet.java
    │   ├── DepositConfirmServlet.java
    │   ├── DepositServlet.java
    │   ├── FactionServlet.java
    │   ├── HomeServlet.java
    │   ├── LoginServlet.java
    │   ├── LogoutServlet.java
    │   ├── OrderDetailServlet.java
    │   ├── OrderHistoryServlet.java
    │   ├── ProductManageServlet.java
    │   ├── RegisterServlet.java
    │   ├── SearchAjaxServlet.java
    │   ├── TransactionManageServlet.java
    │   ├── UpdateManageServlet.java
    │   └── UserManagerServlet.java
    ├── dal/                        # Tầng thao tác cơ sở dữ liệu (Data Access Layer)
    │   ├── DBContext.java
    │   ├── OrderDAO.java
    │   ├── ProductDAO.java
    │   ├── TestConnection.java
    │   ├── TransactionDAO.java
    │   ├── UpdateDAO.java
    │   └── UserDAO.java
    └── model/                      # Các lớp đối tượng thực thể (JavaBeans)
        ├── Cart.java
        ├── GameUpdate.java
        ├── Item.java
        ├── Order.java
        ├── Product.java
        ├── Transaction.java
        └── User.java

```text

---
## ⚙️ Hướng dẫn Cài đặt & Chạy dự án trên NetBeans

### Yêu cầu hệ thống

1. **Apache NetBeans IDE** (phiên bản hỗ trợ Java EE / Jakarta EE).
2. **Apache Tomcat Server** (phiên bản 10.x trở lên tương thích với thư viện `jakarta.servlet`).
3. **MySQL Server** (thông qua XAMPP, Laragon hoặc MySQL Workbench).

---

### Bước 1: Chuẩn bị Cơ sở dữ liệu (MySQL)

1. Mở công cụ quản lý MySQL của bạn (ví dụ: phpMyAdmin hoặc MySQL Workbench).
2. Tạo một cơ sở dữ liệu (Database) mới đặt tên là: **`ZZZ_Shop`** (hoặc tên tùy ý khớp với cấu hình kết nối của bạn).
3. Import file mã nguồn cấu trúc cơ sở dữ liệu SQL (nếu có) vào database vừa tạo để khởi tạo các bảng dữ liệu (người dùng, sản phẩm, đơn hàng,...).

---

### Bước 3: Mở Project trên Apache NetBeans

1. Khởi động phần mềm **Apache NetBeans IDE**.
2. Trên thanh menu, chọn **File** > **Open Project...**
3. Trỏ tới thư mục chứa project **`ZZZ_Shop`** của bạn và nhấn **Open Project**.

---

### Bước 4: Cấu hình Apache Tomcat Server trên NetBeans

1. Kiểm tra xem project đã gắn kết với Apache Tomcat chưa bằng cách nhấp chuột phải vào tên project chọn **Properties**.
2. Chọn mục **Run** hoặc **Server**:
* Đảm bảo phần **Server** đã được trỏ tới Apache Tomcat Server của bạn.
* Kiểm tra **Java EE Version** (thường là Jakarta EE 9 hoặc 10 tùy phiên bản Tomcat bạn dùng).


3. Nhấn **OK** để lưu lại.

---

### Bước 5: Chạy ứng dụng (Run)

1. Nhấp chuột phải trực tiếp vào tên project **`ZZZ_Shop`**.
2. Chọn **Run** (hoặc nhấn phím tắt `F6`).
3. NetBeans sẽ tự động build file WAR, khởi động Apache Tomcat Server và mở trang chủ của ứng dụng trên trình duyệt web mặc định (thường chạy tại đường dẫn: `http://localhost:8080/ZZZ_Shop/`).

---

## 🤝 Đóng góp (Contributing)

Mọi đóng góp, báo lỗi (issue) hoặc yêu cầu tính năng mới đều được hoan nghênh. Vui lòng tạo Pull Request hoặc liên hệ với nhóm phát triển để đóng góp cho dự án.

---

## 📄 License

Dự án được phân phối dưới [MIT License](https://www.google.com/search?q=./LICENSE).

```
