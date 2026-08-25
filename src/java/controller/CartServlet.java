package controller;

import dal.ProductDAO;
import model.Cart;
import model.Item;
import model.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý hành động xóa nếu có tham số ?action=delete&id=...
        String action = request.getParameter("action");
        if (action != null && action.equals("delete")) {
            String id_raw = request.getParameter("id");
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart != null) {
                try {
                    int id = Integer.parseInt(id_raw);
                    cart.removeItem(id);
                } catch (Exception e) {}
            }
            session.setAttribute("cart", cart); // Cập nhật lại session
        }
        
        // Chuyển sang trang xem giỏ hàng
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý thêm vào giỏ hàng
        HttpSession session = request.getSession();
        Cart cart = null;
        Object o = session.getAttribute("cart");
        
        // Kiểm tra xem đã có giỏ hàng chưa
        if (o != null) {
            cart = (Cart) o;
        } else {
            cart = new Cart();
        }
        
        String tnum = request.getParameter("num"); // Số lượng (thường là 1)
        String tid = request.getParameter("id");   // ID sản phẩm
        
        try {
            int num = Integer.parseInt(tnum);
            int id = Integer.parseInt(tid);
            
            ProductDAO dao = new ProductDAO();
            Product p = dao.getProductById(id);
            
            // Tạo Item mới
            Item t = new Item(p, num, p.getPrice());
            
            // Thêm vào giỏ
            cart.addItem(t);
        } catch (Exception e) {
        }
        
        // Lưu lại vào session
        session.setAttribute("cart", cart);
        session.setAttribute("size", cart.getItems().size());
        
        // Quay lại trang cart để xem kết quả
        response.sendRedirect("cart");
    }
}