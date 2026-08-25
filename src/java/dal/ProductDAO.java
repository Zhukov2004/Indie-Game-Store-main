package dal;

import java.util.ArrayList;
import java.util.List;
import model.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProductDAO extends DBContext {

    // --- HÀM PHỤ: Lấy ID nhân vật dựa trên tên file ảnh ---
    // Ví dụ: đưa vào 'lycaon.png' -> Trả về ID của Lycaon (ví dụ: 11)
    private int getIdByImageName(String imageName) {
        if (imageName == null || imageName.equals("no-image.png")) return 0;
        String sql = "SELECT id FROM products WHERE image = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, imageName);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {}
        return 0; // Không tìm thấy (có thể là NPC hoặc chưa cập nhật)
    }

    // --- HÀM MAP DỮ LIỆU ---
    private Product mapProduct(ResultSet rs) {
        try {
            // Xử lý các trường String (tránh null)
            String typeVal = "Unknown"; try { typeVal = rs.getString("type"); } catch(Exception e) { try { typeVal = rs.getString("category"); } catch(Exception ex){} }
            String imgVal = "no-image.png"; try { imgVal = rs.getString("image"); } catch(Exception e) { try { imgVal = rs.getString("image_url"); } catch(Exception ex){} }
            String descVal = "No data."; try { if(rs.getString("description") != null) descVal = rs.getString("description"); } catch(Exception e){}
            String vidVal = "f7lQWp1f0kQ"; try { if(rs.getString("video_id") != null && !rs.getString("video_id").isEmpty()) vidVal = rs.getString("video_id"); } catch(Exception e){}
            
            String wName = "Unknown Engine"; try { if(rs.getString("w_engine_name") != null) wName = rs.getString("w_engine_name"); } catch(Exception e){}
            String wImg = "w_default.png"; try { if(rs.getString("w_engine_image") != null) wImg = rs.getString("w_engine_image"); } catch(Exception e){}
            
            String t1 = "no-image.png"; try { if(rs.getString("teammate_1") != null) t1 = rs.getString("teammate_1"); } catch(Exception e){}
            String t2 = "no-image.png"; try { if(rs.getString("teammate_2") != null) t2 = rs.getString("teammate_2"); } catch(Exception e){}
            
            boolean isUp = false; try { isUp = rs.getBoolean("is_upcoming"); } catch(Exception e){}

            Product p = new Product(
                rs.getInt("id"), rs.getString("name"), typeVal, rs.getString("rarity"),
                rs.getDouble("price"), imgVal, descVal, vidVal,
                wName, wImg, t1, t2, isUp
            );
            
            // --- QUAN TRỌNG: TÌM VÀ GÁN ID ĐỒNG ĐỘI ---
            p.setTeammate1Id(getIdByImageName(t1));
            p.setTeammate2Id(getIdByImageName(t2));

            return p;
        } catch (Exception e) {
            return null;
        }
    }

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = mapProduct(rs);
                if (p != null) list.add(p);
            }
        } catch (Exception e) {
            System.out.println("Error getAllProducts: " + e.getMessage());
        }
        return list;
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return mapProduct(rs);
        } catch (Exception e) {
            System.out.println("Error getProductById: " + e.getMessage());
        }
        return null;
    }

    // Các hàm tìm kiếm và Admin
    public List<Product> searchByName(String txt) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? LIMIT 4";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + txt + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) list.add(mapProduct(rs));
        } catch (Exception e) {}
        return list;
    }

    public void deleteProduct(int id) {
        try { PreparedStatement st = connection.prepareStatement("DELETE FROM products WHERE id=?"); st.setInt(1, id); st.executeUpdate(); } catch (Exception e) {}
    }
    public void insertProduct(Product p) {
        try {
            String sql = "INSERT INTO products (name, type, rarity, price, image, description, video_id, is_upcoming, w_engine_name, w_engine_image, teammate_1, teammate_2) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, p.getName()); st.setString(2, p.getType()); st.setString(3, p.getRarity());
            st.setDouble(4, p.getPrice()); st.setString(5, p.getImage()); st.setString(6, p.getDescription());
            st.setString(7, p.getVideoId()); st.setBoolean(8, p.isUpcoming());
            st.setString(9, p.getwEngineName()); st.setString(10, p.getwEngineImage()); st.setString(11, p.getTeammate1()); st.setString(12, p.getTeammate2());
            st.executeUpdate();
        } catch (Exception e) {}
    }
    public void updateProduct(Product p) {
        try {
            String sql = "UPDATE products SET name=?, type=?, rarity=?, price=?, image=?, description=?, video_id=?, is_upcoming=? WHERE id=?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, p.getName()); st.setString(2, p.getType()); st.setString(3, p.getRarity());
            st.setDouble(4, p.getPrice()); st.setString(5, p.getImage()); st.setString(6, p.getDescription());
            st.setString(7, p.getVideoId()); st.setBoolean(8, p.isUpcoming()); st.setInt(9, p.getId());
            st.executeUpdate();
        } catch (Exception e) {}
    }
}