package model;

import java.sql.Date;

public class Order {
    private int id;
    private int userId;
    private Date date;
    private double totalMoney;

    // Thuộc tính mới để hiển thị tên người mua (cho Admin xem)
    private String userName;
    
    public Order() {
    }

    public Order(int id, int userId, Date date, double totalMoney) {
        this.id = id;
        this.userId = userId;
        this.date = date;
        this.totalMoney = totalMoney;
    }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    public double getTotalMoney() { return totalMoney; }
    public void setTotalMoney(double totalMoney) { this.totalMoney = totalMoney; }
}