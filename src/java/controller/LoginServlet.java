package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String u = request.getParameter("user");
        String p = request.getParameter("pass");

        UserDAO dao = new UserDAO();
        User account = dao.checkLogin(u, p);

        if (account == null) {
            // 1. Sai tài khoản hoặc mật khẩu
            request.setAttribute("error", "Sai thông tin đăng nhập, Proxy!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // 2. KIỂM TRA KHÓA TÀI KHOẢN (Logic mới)
            if (account.isLocked()) {
                request.setAttribute("error", "ACCESS DENIED: Tài khoản này đã bị khóa do vi phạm quy tắc Hollow!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return; // Dừng lại, không cho đăng nhập
            }

            // 3. Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("acc", account);
            
            // Phân quyền (Admin hoặc Khách)
            // Ở đây cả 2 đều về home, nhưng Admin sẽ thấy nút quản lý
            response.sendRedirect("home");
        }
    }
}