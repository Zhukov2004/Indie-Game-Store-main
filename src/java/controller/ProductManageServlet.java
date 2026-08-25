package controller;

import dal.ProductDAO;
import model.Product;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "ProductManageServlet", urlPatterns = {"/manage-product"})
public class ProductManageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check Admin
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null || u.getRole() != 1) {
            response.sendRedirect("home");
            return;
        }

        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();

        if (action == null) {
            response.sendRedirect("admin");
        } 
        // XÓA SẢN PHẨM
        else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteProduct(id);
            response.sendRedirect("admin");
        } 
        // CHUYỂN ĐẾN TRANG SỬA
        else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product p = dao.getProductById(id);
            request.setAttribute("detail", p);
            request.getRequestDispatcher("product_form.jsp").forward(request, response);
        } 
        // CHUYỂN ĐẾN TRANG THÊM MỚI
        else if (action.equals("add")) {
            request.getRequestDispatcher("product_form.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // LẤY DỮ LIỆU TỪ FORM
        String id_raw = request.getParameter("id"); // Nếu có id là Sửa, không có là Thêm
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String rarity = request.getParameter("rarity");
        double price = Double.parseDouble(request.getParameter("price"));
        String image = request.getParameter("image");
        String desc = request.getParameter("description");
        String videoId = request.getParameter("videoId");
        boolean isUpcoming = request.getParameter("isUpcoming") != null;

        ProductDAO dao = new ProductDAO();
        
        // Tạo đối tượng (Các trường build tạm để null hoặc mặc định)
        Product p = new Product(0, name, type, rarity, price, image, desc, videoId, 
                                "Unknown", "w_default.png", "no-image.png", "no-image.png", isUpcoming);

        if (id_raw == null || id_raw.isEmpty()) {
            // THÊM MỚI
            dao.insertProduct(p);
        } else {
            // CẬP NHẬT
            p.setId(Integer.parseInt(id_raw));
            dao.updateProduct(p);
        }
        
        response.sendRedirect("admin");
    }
}