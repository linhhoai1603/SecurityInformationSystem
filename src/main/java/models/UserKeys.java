package models;

import com.google.gson.annotations.Expose;

import java.io.Serializable;
import java.time.LocalDateTime;

public class UserKeys implements Serializable {
    @Expose
    private int id;
    @Expose
    private User user;
    @Expose
    private String publicKey;
    @Expose
    private LocalDateTime create_at;

    public UserKeys(User user, String publicKey) {
        this.user = user;
        this.publicKey = publicKey;
        this.create_at = LocalDateTime.now();
    }

    public UserKeys() {

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

    @Override
    public String toString() {
        return "UserKeys{" +
                "id=" + id +
                ", user=" + user +
                ", publicKey='" + publicKey + '\'' +
                ", create_at=" + create_at +
                '}';
    }
}
