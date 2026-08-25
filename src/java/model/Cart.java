package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<Item> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public List<Item> getItems() {
        return items;
    }

    // 1. Lấy item theo ID sản phẩm
    private Item getItemById(int id) {
        for (Item i : items) {
            if (i.getProduct().getId() == id) {
                return i;
            }
        }
        return null;
    }

    // 2. Thêm sản phẩm vào giỏ
    public void addItem(Item t) {
        // Nếu sản phẩm đã có -> Tăng số lượng
        if (getItemById(t.getProduct().getId()) != null) {
            Item i = getItemById(t.getProduct().getId());
            i.setQuantity(i.getQuantity() + t.getQuantity());
        } else {
            // Nếu chưa có -> Thêm mới
            items.add(t);
        }
    }

    // 3. Xóa sản phẩm
    public void removeItem(int id) {
        if (getItemById(id) != null) {
            items.remove(getItemById(id));
        }
    }

    // 4. Tính tổng tiền cả giỏ
    public double getTotalMoney() {
        double t = 0;
        for (Item i : items) {
            t += i.getTotalPrice();
        }
        return t;
    }
    
    // 5. Đếm tổng số lượng sản phẩm (để hiện lên icon giỏ hàng)
    public int getTotalQuantity() {
    int total = 0;
    for (Item i : items) {
        total += i.getQuantity(); // Cộng dồn số lượng của từng món
    }
    return total;
}
}