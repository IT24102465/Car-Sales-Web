package admin.model;

public class Admin {
    private String adminID;
    private String name;
    private String username;
    private String password;
    private String profilePicture;

    public Admin() {
    }

    public Admin(String adminID, String name, String username, String password, String profilePicture) {
        this.adminID = adminID;
        this.name = name;
        this.username = username;
        this.password = password;
        this.profilePicture = profilePicture;
    }

    public String getAdminID() {
        return adminID;
    }

    public void setAdminID(String adminID) {
        this.adminID = adminID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

}
