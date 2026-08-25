package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Transaction;

public class TransactionDAO extends DBContext {

    // 1. TẠO YÊU CẦU NẠP TIỀN (PENDING)
    public void createTransaction(int userId, double amount) {
        String sql = "INSERT INTO transactions (user_id, amount, status) VALUES (?, ?, 'PENDING')";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setDouble(2, amount);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 2. LẤY TẤT CẢ GIAO DỊCH (Cho Admin)
    public List<Transaction> getAllTransactions() {
        List<Transaction> list = new ArrayList<>();
        String sql = "SELECT t.*, u.username FROM transactions t JOIN users u ON t.user_id = u.user_id ORDER BY t.created_at DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Transaction t = new Transaction(
                    rs.getInt("id"), rs.getInt("user_id"), rs.getDouble("amount"),
                    rs.getString("status"), rs.getTimestamp("created_at")
                );
                t.setUserName(rs.getString("username"));
                list.add(t);
            }
        } catch (Exception e) {}
        return list;
    }

    // 3. LẤY 1 GIAO DỊCH THEO ID
    public Transaction getTransactionById(int id) {
        String sql = "SELECT * FROM transactions WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Transaction(
                    rs.getInt("id"), rs.getInt("user_id"), rs.getDouble("amount"),
                    rs.getString("status"), rs.getTimestamp("created_at")
                );
            }
        } catch (Exception e) {}
        return null;
    }

    // 4. CẬP NHẬT TRẠNG THÁI (DUYỆT/TỪ CHỐI)
    public void updateStatus(int id, String status) {
        String sql = "UPDATE transactions SET status = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, status);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (Exception e) {}
    }
}