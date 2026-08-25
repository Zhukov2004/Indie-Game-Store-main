package dal;

import java.sql.Connection;
import model.Product;
import java.util.List;

public class TestConnection {
    public static void main(String[] args) {
        // 1. Test kết nối cơ bản
        System.out.println("Dang kiem tra ket noi...");
        ProductDAO dao = new ProductDAO();
        
        // 2. Thử lấy dữ liệu
        List<Product> list = dao.getAllProducts();
        
        if (list != null && !list.isEmpty()) {
            System.out.println("--- THANH CONG! DA LAY DUOC DU LIEU ---");
            for (Product p : list) {
                System.out.println("- " + p.getName());
            }
        } else {
            System.out.println("--- THAT BAI! KHONG CO DU LIEU ---");
            System.out.println("Hay kiem tra lai Console xem co bao loi do (Exception) khong.");
        }
    }
}