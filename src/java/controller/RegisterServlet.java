package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String u = request.getParameter("user");
        String p = request.getParameter("pass");
        String re_p = request.getParameter("repass");
        String fullname = request.getParameter("fullname");

        if (!p.equals(re_p)) {
            request.setAttribute("error", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            UserDAO dao = new UserDAO();
            if (dao.checkUserExist(u)) {
                request.setAttribute("error", "Tài khoản này đã có người dùng!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                // Đăng ký thành công
                dao.signup(u, p, fullname);
                // Chuyển về trang login
                response.sendRedirect("login");
            }
        }
    }
}