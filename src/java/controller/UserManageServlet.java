package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "UserManageServlet", urlPatterns = {"/manage-user"})
public class UserManageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("acc");
        if (admin == null || admin.getRole() != 1) {
            response.sendRedirect("home"); return;
        }

        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));
        UserDAO dao = new UserDAO();

        if (action.equals("lock")) {
            dao.lockUser(id, true); // Khóa
        } else if (action.equals("unlock")) {
            dao.lockUser(id, false); // Mở
        }
        
        response.sendRedirect("admin");
    }
}