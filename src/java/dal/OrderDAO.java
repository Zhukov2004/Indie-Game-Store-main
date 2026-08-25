package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Item;
import model.Order;
import model.User;
import model.Product;

public class OrderDAO extends DBContext {

    // 1. LƯU ĐƠN HÀNG MỚI (Checkout)
    public void addOrder(User u, Cart cart) {
        LocalDate curDate = java.time.LocalDate.now();
        String date = curDate.toString();
        try {
            // Thêm vào bảng orders
            String sql = "INSERT INTO orders (user_id, order_date, total_money) VALUES (?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setInt(1, u.getId());
            st.setString(2, date);
            st.setDouble(3, cart.getTotalMoney());
            st.executeUpdate();

            // Lấy ID vừa tạo
            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                int oid = rs.getInt(1);
                // Thêm chi tiết vào order_details
                for (Item i : cart.getItems()) {
                    String sql2 = "INSERT INTO order_details (oid, pid, quantity, price) VALUES (?, ?, ?, ?)";
                    PreparedStatement st2 = connection.prepareStatement(sql2);
                    st2.setInt(1, oid);
                    st2.setInt(2, i.getProduct().getId());
                    st2.setInt(3, i.getQuantity());
                    st2.setDouble(4, i.getPrice());
                    st2.executeUpdate();
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi addOrder: " + e.getMessage());
        }
    }

    // 2. LẤY LỊCH SỬ MUA HÀNG (Của 1 User)
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_id DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1), rs.getInt(2), rs.getDate(3), rs.getDouble(4)));
            }
        } catch (SQLException e) {}
        return list;
    }

    // 3. LẤY CHI TIẾT 1 ĐƠN HÀNG (Order Detail)
    public List<Item> getOrderDetail(int orderId) {
        List<Item> list = new ArrayList<>();
        String sql = "SELECT od.quantity, od.price, p.* FROM order_details od JOIN products p ON od.pid = p.id WHERE od.oid = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setImage(rs.getString("image"));
                p.setRarity(rs.getString("rarity"));
                p.setType(rs.getString("type"));
                
                list.add(new Item(p, rs.getInt("quantity"), rs.getDouble("price")));
            }
        } catch (Exception e) {}
        return list;
    }

    // 4. LẤY 1 ĐƠN HÀNG THEO ID (Header info)
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Order(rs.getInt(1), rs.getInt(2), rs.getDate(3), rs.getDouble(4));
            }
        } catch (Exception e) {}
        return null;
    }

    // 5. LẤY TOÀN BỘ ĐƠN HÀNG (Cho Admin)
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.username FROM orders o JOIN users u ON o.user_id = u.user_id ORDER BY o.order_date DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt(1), rs.getInt(2), rs.getDate(3), rs.getDouble(4));
                o.setUserName(rs.getString("username")); // Cần thêm thuộc tính userName vào Model Order
                list.add(o);
            }
        } catch (Exception e) {}
        return list;
    }
    // ... (Các code cũ giữ nguyên) ...

    // --- THỐNG KÊ DOANH THU (DASHBOARD) ---

    // 1. Tổng doanh thu toàn thời gian
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_money) FROM orders";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {}
        return 0;
    }

    // 2. Doanh thu HÔM NAY (Real-time)
    public double getTodayRevenue() {
        String sql = "SELECT SUM(total_money) FROM orders WHERE order_date = CURDATE()";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {}
        return 0;
    }

    // 3. Tổng số đơn hàng
    public int countOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {}
        return 0;
    }
}
