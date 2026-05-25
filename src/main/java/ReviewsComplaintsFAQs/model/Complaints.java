package ReviewsComplaintsFAQs.model;

import login.model.User;

public class Complaints {
    private User user;      // for submission
    private String userEmail; // for view/delete without User object
    private String content;

    // Constructor with full User (for submission)
    public Complaints(User user, String content) {
        this.user = user;
        this.content = content;
        this.userEmail = user.getEmail();
    }

    // Constructor with only email (for view/delete)
    public Complaints(String userEmail, String content) {
        this.userEmail = userEmail;
        this.content = content;
        this.user = null;
    }

    // Getter for User
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
        this.userEmail = user.getEmail();
    }

    // Getter for email (useful for view/delete)
    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
