package controller;

import dal.ProductDAO;
import model.Product;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "FactionServlet", urlPatterns = {"/faction"})
public class FactionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String fCode = request.getParameter("name");
        if (fCode == null) fCode = "victoria";
        fCode = fCode.toLowerCase().trim(); // Chuẩn hóa chuỗi

        ProductDAO dao = new ProductDAO();
        List<Product> allProducts = dao.getAllProducts();
        List<Product> factionMembers = new ArrayList<>();

        for (Product p : allProducts) {
            // Chuyển hết về chữ hoa để so sánh không phân biệt hoa thường
            String name = p.getName().toUpperCase();
            String desc = (p.getDescription() != null) ? p.getDescription().toUpperCase() : "";
            
            boolean match = false;

            // LOGIC LỌC CHI TIẾT 13 PHE
            if (fCode.equals("victoria") && (desc.contains("VICTORIA") || name.contains("ELLEN") || name.contains("LYCAON") || name.contains("RINA") || name.contains("CORIN"))) match = true;
            else if (fCode.equals("hare") && (desc.contains("CUNNING") || desc.contains("HARES") || name.contains("ANBY") || name.contains("NICOLE") || name.contains("BILLY") || name.contains("NEKOMATA"))) match = true;
            else if (fCode.equals("belobog") && (desc.contains("BELOBOG") || name.contains("KOLEDA") || name.contains("BEN") || name.contains("ANTON") || name.contains("GRACE"))) match = true;
            else if (fCode.equals("neps") && (desc.contains("NEPS") || desc.contains("PUBLIC SECURITY") || name.contains("ZHU YUAN") || name.contains("QINGYI") || name.contains("JANE") || name.contains("SETH"))) match = true;
            
            // --- CÁC PHE MỚI THƯỜNG BỊ LỖI DO THIẾU DỮ LIỆU ---
            else if (fCode.equals("section6") && (desc.contains("SECTION 6") || desc.contains("H.S.O.S") || name.contains("MIYABI") || name.contains("YANAGI") || name.contains("SOUKAKU") || name.contains("HARUMASA"))) match = true;
            else if (fCode.equals("calydon") && (desc.contains("CALYDON") || desc.contains("SONS") || name.contains("CAESAR") || name.contains("LUCY") || name.contains("PIPER") || name.contains("BURNICE") || name.contains("LIGHTER"))) match = true;
            else if (fCode.equals("obol") && (desc.contains("OBOL") || name.contains("SOLDIER 11") || name.contains("TRIGGER"))) match = true;
            else if (fCode.equals("silver") && (desc.contains("SILVER") || desc.contains("DEFENSE FORCE") || name.contains("SOLDIER 0"))) match = true; // Phe Silver Squad
            else if (fCode.equals("yunkui") && (desc.contains("YUNKUI") || desc.contains("VÂN KHUY") || name.contains("YE SHUNGUANG") || name.contains("YIXUAN") || name.contains("JU FUFU"))) match = true;
            else if (fCode.equals("krampus") && (desc.contains("KRAMPUS") || name.contains("ZHAO") || name.contains("BANYUE"))) match = true;
            else if (fCode.equals("mockingbird") && (desc.contains("MOCKINGBIRD") || name.contains("VIVIAN") || name.contains("HUGO"))) match = true;
            else if (fCode.equals("lyra") && (desc.contains("LYRA") || name.contains("ASTRA") || name.contains("EVELYN"))) match = true;
            else if (fCode.equals("spook") && (desc.contains("SPOOK") || name.contains("YUZUHA") || name.contains("ALICE"))) match = true;

            if (match) {
                factionMembers.add(p);
            }
        }

        request.setAttribute("factionMembers", factionMembers);
        request.setAttribute("currentFactionStr", fCode.toUpperCase());
        request.getRequestDispatcher("faction_view.jsp").forward(request, response);
    }
}