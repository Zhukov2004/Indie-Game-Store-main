package controller;

import dal.TransactionDAO;
import dal.UserDAO;
import model.Transaction;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "TransactionManageServlet", urlPatterns = {"/manage-transaction"})
public class TransactionManageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check Admin
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("acc");
        if (admin == null || admin.getRole() != 1) { response.sendRedirect("home"); return; }

        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));
        
        TransactionDAO tDao = new TransactionDAO();
        UserDAO uDao = new UserDAO();
        
        // Lấy thông tin giao dịch
        Transaction t = tDao.getTransactionById(id);
        
        if (t != null && t.getStatus().equals("PENDING")) {
            if (action.equals("approve")) {
                // 1. Cập nhật trạng thái transaction -> APPROVED
                tDao.updateStatus(id, "APPROVED");
                
                // 2. Cộng tiền cho User
                User user = uDao.getUserById(t.getUserId());
                double newBalance = user.getBalance() + t.getAmount();
                uDao.updateBalance(t.getUserId(), newBalance);
                
            } else if (action.equals("reject")) {
                // Từ chối -> Chỉ cập nhật trạng thái -> REJECTED
                tDao.updateStatus(id, "REJECTED");
            }
        }
        
        response.sendRedirect("admin");
    }
}