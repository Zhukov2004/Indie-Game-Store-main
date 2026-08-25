package controller;

import dal.OrderDAO;
import model.Order;
import model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "OrderHistoryServlet", urlPatterns = {"/history"})
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("acc");

        // 1. Kiểm tra đăng nhập
        if (account == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Lấy danh sách đơn hàng
        OrderDAO dao = new OrderDAO();
        List<Order> list = dao.getOrdersByUserId(account.getId());

        // 3. Gửi sang JSP
        request.setAttribute("listOrders", list);
        request.getRequestDispatcher("order_history.jsp").forward(request, response);
    }
}