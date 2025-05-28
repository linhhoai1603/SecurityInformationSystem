package models;

import java.io.Serializable;
import java.time.LocalDateTime;

public class UserKeys implements Serializable {
    private int id;
    private User user;
    private String publicKey;
    private LocalDateTime create_at;

    public UserKeys(int id, User user, String publicKey, LocalDateTime create_at) {
        this.id = id;
        this.user = user;
        this.publicKey = publicKey;
        this.create_at = create_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public LocalDateTime getCreate_at() {
        return create_at;
    }

    public void setCreate_at(LocalDateTime create_at) {
        this.create_at = create_at;
    }
}
