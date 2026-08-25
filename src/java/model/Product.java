package model;

public class Product {
    private int id;
    private String name;
    private String type;
    private String rarity;
    private double price;
    private String image;
    private String description;
    private String videoId;
    
    // Thông tin Build
    private String wEngineName;
    private String wEngineImage;
    private String teammate1;
    private String teammate2;
    
    // --- HAI TRƯỜNG MỚI ĐỂ LƯU ID ĐỒNG ĐỘI ---
    private int teammate1Id; 
    private int teammate2Id;
    
    private boolean isUpcoming;

    public Product() {
    }

    // Constructor full (14 tham số - bao gồm cả các ID mới nếu cần, nhưng thường dùng Setter)
    public Product(int id, String name, String type, String rarity, double price, String image, 
                   String description, String videoId, String wEngineName, String wEngineImage, 
                   String teammate1, String teammate2, boolean isUpcoming) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.rarity = rarity;
        this.price = price;
        this.image = image;
        this.description = description;
        this.videoId = videoId;
        this.wEngineName = wEngineName;
        this.wEngineImage = wEngineImage;
        this.teammate1 = teammate1;
        this.teammate2 = teammate2;
        this.isUpcoming = isUpcoming;
    }

    // --- Getters & Setters ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getRarity() { return rarity; }
    public void setRarity(String rarity) { this.rarity = rarity; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getVideoId() { return videoId; }
    public void setVideoId(String videoId) { this.videoId = videoId; }
    public String getwEngineName() { return wEngineName; }
    public void setwEngineName(String wEngineName) { this.wEngineName = wEngineName; }
    public String getwEngineImage() { return wEngineImage; }
    public void setwEngineImage(String wEngineImage) { this.wEngineImage = wEngineImage; }
    public String getTeammate1() { return teammate1; }
    public void setTeammate1(String teammate1) { this.teammate1 = teammate1; }
    public String getTeammate2() { return teammate2; }
    public void setTeammate2(String teammate2) { this.teammate2 = teammate2; }
    public boolean isUpcoming() { return isUpcoming; }
    public void setUpcoming(boolean isUpcoming) { this.isUpcoming = isUpcoming; }

    // Getter Setter cho ID Đồng đội
    public int getTeammate1Id() { return teammate1Id; }
    public void setTeammate1Id(int teammate1Id) { this.teammate1Id = teammate1Id; }
    public int getTeammate2Id() { return teammate2Id; }
    public void setTeammate2Id(int teammate2Id) { this.teammate2Id = teammate2Id; }
}