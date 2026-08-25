package dal;

import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    // 1. KIỂM TRA ĐĂNG NHẬP (Lấy cả trạng thái khóa)
    public User checkLogin(String user, String pass) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            st.setString(2, pass);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("full_name"),
                    rs.getInt("role"),
                    rs.getDouble("balance"),
                    rs.getBoolean("is_locked") // <-- Lấy trạng thái khóa
                );
            }
        } catch (SQLException e) {
            System.out.println("Lỗi checkLogin: " + e.getMessage());
        }
        return null;
    }

    // 2. KIỂM TRA TÀI KHOẢN TỒN TẠI
    public boolean checkUserExist(String user) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return true;
        } catch (SQLException e) {}
        return false;
    }

    // 3. ĐĂNG KÝ MỚI (Mặc định không khóa)
    public void signup(String user, String pass, String fullName) {
        String sql = "INSERT INTO users (username, password, full_name, role, balance, is_locked) VALUES (?, ?, ?, 0, 0, 0)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            st.setString(2, pass);
            st.setString(3, fullName);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi signup: " + e.getMessage());
        }
    }

    // 4. CẬP NHẬT SỐ DƯ
    public void updateBalance(int userId, double newBalance) {
        String sql = "UPDATE users SET balance = ? WHERE user_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDouble(1, newBalance);
            st.setInt(2, userId);
            st.executeUpdate();
        } catch (SQLException e) {}
    }

    // 5. LẤY USER THEO ID
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("user_id"), rs.getString("username"), rs.getString("password"),
                    rs.getString("full_name"), rs.getInt("role"), rs.getDouble("balance"),
                    rs.getBoolean("is_locked")
                );
            }
        } catch (SQLException e) {}
        return null;
    }

    // 6. LẤY TẤT CẢ USER (Cho Admin quản lý)
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 0"; // Chỉ lấy khách hàng
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new User(
                    rs.getInt("user_id"), rs.getString("username"), rs.getString("password"),
                    rs.getString("full_name"), rs.getInt("role"), rs.getDouble("balance"),
                    rs.getBoolean("is_locked") // <-- Lấy trạng thái khóa
                ));
            }
        } catch (SQLException e) {}
        return list;
    }

    // 7. KHÓA / MỞ KHÓA USER (MỚI)
    public void lockUser(int userId, boolean lockStatus) {
        String sql = "UPDATE users SET is_locked = ? WHERE user_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, lockStatus); // true = khóa, false = mở
            st.setInt(2, userId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi lockUser: " + e.getMessage());
        }
    }
}