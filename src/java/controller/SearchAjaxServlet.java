package controller;

import dal.ProductDAO;
import model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "SearchAjaxServlet", urlPatterns = {"/search-ajax"})
public class SearchAjaxServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String txt = request.getParameter("txt");
        PrintWriter out = response.getWriter();
        
        // Nếu người dùng chưa nhập gì thì không làm gì cả
        if (txt == null || txt.trim().isEmpty()) {
            return;
        }

        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.searchByName(txt);

        // Tạo đoạn mã HTML trả về cho Client
        if (!list.isEmpty()) {
            out.println("<div class='bg-zzz-card border border-gray-600 shadow-2xl rounded-b-lg overflow-hidden'>");
            for (Product p : list) {
                out.println("<a href='character-detail?id=" + p.getId() + "' class='flex items-center gap-3 p-3 hover:bg-zzz-base border-b border-gray-700 transition-colors group'>");
                
                // Ảnh nhỏ
                out.println("<img src='images/" + p.getImage() + "' class='w-10 h-10 object-cover rounded border border-gray-500 group-hover:border-zzz-accent'>");
                
                // Thông tin
                out.println("<div>");
                out.println("<div class='text-sm font-bold text-white group-hover:text-zzz-accent uppercase'>" + p.getName() + "</div>");
                out.println("<div class='text-[10px] text-gray-400'>" + p.getType() + "</div>");
                out.println("</div>");
                
                out.println("</a>");
            }
            // Nút xem tất cả nếu muốn
            out.println("<a href='home?search=" + txt + "' class='block text-center text-xs p-2 text-zzz-accent font-bold hover:underline bg-[#222]'>VIEW ALL RESULTS</a>");
            out.println("</div>");
        } else {
            // Nếu không tìm thấy
            out.println("<div class='bg-zzz-card border border-gray-600 p-4 text-center text-xs text-gray-400'>NO SIGNAL FOUND</div>");
        }
    }
}