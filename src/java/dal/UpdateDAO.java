package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.GameUpdate;

public class UpdateDAO extends DBContext {
    
    // 1. LẤY DANH SÁCH TIN MỚI NHẤT (Dùng cho Trang chủ - Giới hạn 10 tin)
    public List<GameUpdate> getLatestUpdates() {
        List<GameUpdate> list = new ArrayList<>();
        String sql = "SELECT * FROM updates ORDER BY date DESC LIMIT 10"; 
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                // Xử lý link null (nếu có)
                String link = rs.getString("official_link");
                if (link == null || link.isEmpty()) link = "https://zenless.hoyoverse.com/en-us/news";

                list.add(new GameUpdate(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("type"),
                    rs.getString("version"),
                    rs.getDate("date"),
                    rs.getString("content"),
                    link
                ));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi getLatestUpdates: " + e.getMessage());
        }
        return list;
    }

    // 2. LẤY TẤT CẢ TIN TỨC (Dùng cho Admin Panel - Không giới hạn)
    public List<GameUpdate> getAllUpdates() {
        List<GameUpdate> list = new ArrayList<>();
        String sql = "SELECT * FROM updates ORDER BY date DESC"; 
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while(rs.next()) {
                String link = rs.getString("official_link");
                if (link == null || link.isEmpty()) link = "#";

                list.add(new GameUpdate(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("type"),
                    rs.getString("version"),
                    rs.getDate("date"),
                    rs.getString("content"),
                    link
                ));
            }
        } catch(SQLException e) {
            System.out.println("Lỗi getAllUpdates: " + e.getMessage());
        }
        return list;
    }

    // 3. THÊM TIN TỨC MỚI (Admin)
    public void insertUpdate(GameUpdate u) {
        String sql = "INSERT INTO updates (title, type, version, date, content, official_link) VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, u.getTitle());
            st.setString(2, u.getType());
            st.setString(3, u.getVersion());
            st.setDate(4, u.getDate());
            st.setString(5, u.getContent());
            st.setString(6, u.getLink());
            st.executeUpdate();
        } catch(SQLException e) {
            System.out.println("Lỗi insertUpdate: " + e.getMessage());
        }
    }

    // 4. XÓA TIN TỨC (Admin)
    public void deleteUpdate(int id) {
        String sql = "DELETE FROM updates WHERE id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch(SQLException e) {
            System.out.println("Lỗi deleteUpdate: " + e.getMessage());
        }
    }
    
    // 5. LẤY 1 TIN TỨC THEO ID (Để hiển thị vào form Sửa)
    public GameUpdate getUpdateById(int id) {
        String sql = "SELECT * FROM updates WHERE id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if(rs.next()) {
                return new GameUpdate(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("type"),
                    rs.getString("version"),
                    rs.getDate("date"),
                    rs.getString("content"),
                    rs.getString("official_link")
                );
            }
        } catch(SQLException e) {
            System.out.println("Lỗi getUpdateById: " + e.getMessage());
        }
        return null;
    }

    // 6. CẬP NHẬT TIN TỨC (Admin)
    public void updateUpdate(GameUpdate u) {
        String sql = "UPDATE updates SET title=?, type=?, version=?, date=?, content=?, official_link=? WHERE id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, u.getTitle());
            st.setString(2, u.getType());
            st.setString(3, u.getVersion());
            st.setDate(4, u.getDate());
            st.setString(5, u.getContent());
            st.setString(6, u.getLink());
            st.setInt(7, u.getId());
            st.executeUpdate();
        } catch(SQLException e) {
            System.out.println("Lỗi updateUpdate: " + e.getMessage());
        }
    }
}