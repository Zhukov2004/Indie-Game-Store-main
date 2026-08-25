package controller;

import dal.OrderDAO;
import dal.UserDAO;
import model.Cart;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User account = (User) session.getAttribute("acc");

        // 1. Kiểm tra đăng nhập
        if (account == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Kiểm tra giỏ hàng
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }
        
        // 3. KIỂM TRA SỐ DƯ
        double totalMoney = cart.getTotalMoney();
        if (account.getBalance() < totalMoney) {
            // Nếu thiếu tiền -> Báo lỗi và quay lại giỏ
            request.setAttribute("error", "Insufficient Balance! You need " + (totalMoney - account.getBalance()) + " more Polychrome.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }
        
        // 4. THỰC HIỆN GIAO DỊCH
        OrderDAO orderDao = new OrderDAO();
        UserDAO userDao = new UserDAO();
        
        try {
            // A. Lưu đơn hàng vào Database
            orderDao.addOrder(account, cart);
            
            // B. Trừ tiền trong Database
            double newBalance = account.getBalance() - totalMoney;
            userDao.updateBalance(account.getId(), newBalance);
            
            // C. Cập nhật lại Session User (để hiển thị số tiền mới ngay lập tức)
            account.setBalance(newBalance);
            session.setAttribute("acc", account);
            
            // D. Xóa giỏ hàng
            session.removeAttribute("cart");
            // Cập nhật lại số lượng hiển thị trên menu về 0
            session.setAttribute("size", 0); 
            
            // E. Chuyển hướng sang trang thành công
            request.getRequestDispatcher("order_success.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Checkout Failed: " + e.getMessage());
            response.sendRedirect("cart.jsp");
        }
    }
}