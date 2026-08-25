package controller;

import dal.TransactionDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "DepositServlet", urlPatterns = {"/deposit"})
public class DepositServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("deposit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        
        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            double amount = Double.parseDouble(request.getParameter("amount"));
            
            // 1. Tạo giao dịch PENDING
            TransactionDAO dao = new TransactionDAO();
            dao.createTransaction(u.getId(), amount);
            
            // 2. Chuyển sang trang QR Code để thanh toán
            request.setAttribute("amount", amount);
            request.getRequestDispatcher("deposit_qr.jsp").forward(request, response);
            
        } catch (Exception e) {
            response.sendRedirect("deposit.jsp");
        }
    }
}