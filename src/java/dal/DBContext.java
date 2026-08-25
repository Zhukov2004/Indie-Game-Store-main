package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    protected Connection connection;

    public DBContext() {
        try {
            String user = "root";
            String pass = "";
            String dbName = "zzz_shop";
            
            // Cấu hình URL chuẩn cho Driver 9.3.0 (Tránh lỗi Timezone & SSL)
            String url = "jdbc:mysql://localhost:3306/" + dbName + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            
            // Driver mới có thêm chữ "cj"
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Lỗi kết nối DBContext: " + ex.getMessage());
        }
    }
}