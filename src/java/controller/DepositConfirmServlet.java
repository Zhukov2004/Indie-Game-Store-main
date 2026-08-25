package controller;

import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "DepositConfirmServlet", urlPatterns = {"/deposit-confirm"})
public class DepositConfirmServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        
        // Kiểm tra đăng nhập
        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Lấy số tiền người dùng chọn
            double amount = Double.parseDouble(request.getParameter("amount"));
            
            // Gửi sang trang xác nhận
            request.setAttribute("amount", amount);
            request.getRequestDispatcher("deposit_confirm.jsp").forward(request, response);
            
        } catch (Exception e) {
            response.sendRedirect("deposit.jsp");
        }
    }
}