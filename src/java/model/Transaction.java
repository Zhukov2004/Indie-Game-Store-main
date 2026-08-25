package model;
import java.sql.Timestamp;

public class Transaction {
    private int id;
    private int userId;
    private double amount;
    private String status;
    private Timestamp createdAt;
    private String userName; // Để hiển thị tên người nạp cho Admin

    public Transaction() {}

    public Transaction(int id, int userId, double amount, String status, Timestamp createdAt) {
        this.id = id;
        this.userId = userId;
        this.amount = amount;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Getters & Setters
    public int getId() { return id; } public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; } public void setUserId(int userId) { this.userId = userId; }
    public double getAmount() { return amount; } public void setAmount(double amount) { this.amount = amount; }
    public String getStatus() { return status; } public void setStatus(String status) { this.status = status; }
    public Timestamp getCreatedAt() { return createdAt; } public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getUserName() { return userName; } public void setUserName(String userName) { this.userName = userName; }
}