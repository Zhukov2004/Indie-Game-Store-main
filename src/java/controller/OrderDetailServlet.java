package controller;

import dal.OrderDAO;
import model.Item;
import model.Order;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/order-detail"})
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        if (session.getAttribute("acc") == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            OrderDAO dao = new OrderDAO();
            
            // 1. Lấy thông tin chung đơn hàng (Ngày, Tổng tiền)
            Order order = dao.getOrderById(orderId);
            
            // 2. Lấy danh sách sản phẩm trong đơn đó
            List<Item> details = dao.getOrderDetail(orderId);
            
            request.setAttribute("order", order);
            request.setAttribute("details", details);
            
            request.getRequestDispatcher("order_detail.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("history"); // Lỗi thì quay về lịch sử
        }
    }
}