package controller;

import dal.OrderDAO;
import dal.ProductDAO;
import dal.TransactionDAO;
import dal.UpdateDAO;
import dal.UserDAO;
import model.GameUpdate;
import model.Order;
import model.Product;
import model.Transaction;
import model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("acc");

        // 1. BẢO MẬT: Chỉ Admin (Role = 1) mới được vào
        if (account == null || account.getRole() != 1) {
            response.sendRedirect("home"); 
            return;
        }

        // 2. KHỞI TẠO CÁC DAO
        UserDAO uDao = new UserDAO();
        OrderDAO oDao = new OrderDAO();
        ProductDAO pDao = new ProductDAO();
        UpdateDAO upDao = new UpdateDAO();
        TransactionDAO tDao = new TransactionDAO();
        
        // 3. LẤY DỮ LIỆU DANH SÁCH (List)
        List<User> listUsers = uDao.getAllUsers();
        List<Order> listOrders = oDao.getAllOrders();
        List<Product> listProducts = pDao.getAllProducts();
        List<GameUpdate> listUpdates = upDao.getAllUpdates();
        List<Transaction> listTrans = tDao.getAllTransactions();

        // 4. LẤY SỐ LIỆU THỐNG KÊ (Dashboard)
        double totalRev = oDao.getTotalRevenue();
        double todayRev = oDao.getTodayRevenue();
        int totalOrderCount = oDao.countOrders();
        int totalUserCount = listUsers.size();

        // 5. GỬI DỮ LIỆU SANG JSP
        request.setAttribute("listUsers", listUsers);
        request.setAttribute("listOrders", listOrders);
        request.setAttribute("listProducts", listProducts);
        request.setAttribute("listUpdates", listUpdates);
        request.setAttribute("listTrans", listTrans);
        
        request.setAttribute("totalRev", totalRev);
        request.setAttribute("todayRev", todayRev);
        request.setAttribute("totalOrderCount", totalOrderCount);
        request.setAttribute("totalUserCount", totalUserCount);

        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}