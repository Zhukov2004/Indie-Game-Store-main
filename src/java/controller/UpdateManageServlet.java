package controller;

import dal.UpdateDAO;
import model.GameUpdate;
import model.User;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "UpdateManageServlet", urlPatterns = {"/manage-update"})
public class UpdateManageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check Admin (Code bảo mật)
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null || u.getRole() != 1) { response.sendRedirect("home"); return; }

        String action = request.getParameter("action");
        UpdateDAO dao = new UpdateDAO();

        if (action.equals("delete")) {
            dao.deleteUpdate(Integer.parseInt(request.getParameter("id")));
            response.sendRedirect("admin");
        } else if (action.equals("edit")) {
            GameUpdate up = dao.getUpdateById(Integer.parseInt(request.getParameter("id")));
            request.setAttribute("up", up);
            request.getRequestDispatcher("update_form.jsp").forward(request, response);
        } else if (action.equals("add")) {
            request.getRequestDispatcher("update_form.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý lưu form
        String id_raw = request.getParameter("id");
        String title = request.getParameter("title");
        String type = request.getParameter("type");
        String version = request.getParameter("version");
        String date_raw = request.getParameter("date");
        String content = request.getParameter("content");
        String link = request.getParameter("link");

        UpdateDAO dao = new UpdateDAO();
        GameUpdate up = new GameUpdate(0, title, type, version, Date.valueOf(date_raw), content, link);

        if (id_raw == null || id_raw.isEmpty()) {
            dao.insertUpdate(up);
        } else {
            up.setId(Integer.parseInt(id_raw));
            dao.updateUpdate(up);
        }
        response.sendRedirect("admin");
    }
}