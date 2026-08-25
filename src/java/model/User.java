package model;

public class User {
    private int id;
    private String username;
    private String password;
    private String fullName;
    private int role;       // 0: User, 1: Admin
    private double balance; // Số dư tiền
    private boolean isLocked; // <-- MỚI: Trạng thái khóa (true = bị khóa)

    public User() {
    }

    // Constructor ĐẦY ĐỦ (7 tham số)
    public User(int id, String username, String password, String fullName, int role, double balance, boolean isLocked) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.role = role;
        this.balance = balance;
        this.isLocked = isLocked;
    }

    // --- Getters & Setters ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }
    public double getBalance() { return balance; }
    public void setBalance(double balance) { this.balance = balance; }
    
    // Getter/Setter cho isLocked
    public boolean isLocked() { return isLocked; }
    public void setLocked(boolean isLocked) { this.isLocked = isLocked; }

    @Override
    public String toString() {
        return "User{" + "username=" + username + ", role=" + role + ", locked=" + isLocked + '}';
    }
}