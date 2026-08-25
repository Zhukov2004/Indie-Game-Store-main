package controller;
import dal.ProductDAO;
import model.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "CharacterDetailServlet", urlPatterns = {"/character-detail"})
public class CharacterDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductDAO dao = new ProductDAO();
            Product p = dao.getProductById(id);
            
            request.setAttribute("charDetail", p);
            request.getRequestDispatcher("character_detail.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("home"); // Lỗi thì về trang chủ
        }
    }
}