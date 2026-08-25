package model;
import java.sql.Date;

public class GameUpdate {
    private int id;
    private String title;
    private String type;
    private String version;
    private Date date;
    private String content;
    private String link; // <-- MỚI

    public GameUpdate() {}

    // Constructor đầy đủ
    public GameUpdate(int id, String title, String type, String version, Date date, String content, String link) {
        this.id = id;
        this.title = title;
        this.type = type;
        this.version = version;
        this.date = date;
        this.content = content;
        this.link = link;
    }

    // Getter & Setter mới
    public String getLink() { return link; }
    public void setLink(String link) { this.link = link; }

    // ... (Các Getter/Setter cũ giữ nguyên) ...
    public int getId() { return id; } public void setId(int id) { this.id = id; }
    public String getTitle() { return title; } public void setTitle(String title) { this.title = title; }
    public String getType() { return type; } public void setType(String type) { this.type = type; }
    public String getVersion() { return version; } public void setVersion(String version) { this.version = version; }
    public Date getDate() { return date; } public void setDate(Date date) { this.date = date; }
    public String getContent() { return content; } public void setContent(String content) { this.content = content; }
}