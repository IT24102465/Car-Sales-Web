package ReviewsComplaintsFAQs.model;

import login.model.User;

public class Reviews {
    private User user;
    private String userEmail; // for view/delete without User object
    private int rating;
    private String content;

    // Constructor with full User (for submission)
    public Reviews(User user, int rating, String content) {
        this.user = user;
        this.rating = rating;
        this.content = content;
        this.userEmail = user.getEmail();
    }

    // Constructor with only userEmail (for view/delete)
    public Reviews(String userEmail, int rating, String content) {
        this.userEmail = userEmail;
        this.rating = rating;
        this.content = content;
        this.user = null;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
        this.userEmail = user.getEmail();
    }

    // Getter and setter for userEmail
    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
