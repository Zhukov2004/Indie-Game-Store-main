package controller;

import dal.ProductDAO;
import dal.UpdateDAO;
import model.GameUpdate;
import model.Product;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy dữ liệu Sản phẩm
        ProductDAO pDao = new ProductDAO();
        List<Product> allProducts = pDao.getAllProducts();
        
        List<Product> listUpcoming = new ArrayList<>();
        List<Product> listAgents = new ArrayList<>();   // Danh sách Nhân vật
        List<Product> listWEngines = new ArrayList<>(); // Danh sách W-Engine
        
        // PHÂN LOẠI SẢN PHẨM
        for (Product p : allProducts) {
            if (p.isUpcoming()) {
                listUpcoming.add(p);
            } else {
                // Kiểm tra loại để chia nhóm (Dựa vào chuỗi 'W-Engine' hoặc 'W-ENGINE' trong DB)
                String typeUpper = (p.getType() != null) ? p.getType().toUpperCase() : "";
                
                if (typeUpper.contains("W-ENGINE") || typeUpper.contains("WEAPON")) {
                    listWEngines.add(p);
                } else {
                    listAgents.add(p);
                }
            }
        }
        
        // 2. Lấy tin tức
        UpdateDAO uDao = new UpdateDAO();
        List<GameUpdate> listNews = uDao.getLatestUpdates();
        
        // 3. Gửi dữ liệu sang JSP
        request.setAttribute("listUpcoming", listUpcoming);
        request.setAttribute("listAgents", listAgents);     // Gửi list Nhân vật
        request.setAttribute("listWEngines", listWEngines); // Gửi list Vũ khí
        request.setAttribute("listNews", listNews);
        
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}