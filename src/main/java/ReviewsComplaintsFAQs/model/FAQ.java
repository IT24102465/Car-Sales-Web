package ReviewsComplaintsFAQs.model;

import login.model.User;

public class FAQ {
    private User user;
    private String userEmail;
    private String question;

    // Constructor for submission (with User object)
    public FAQ(User user, String question) {
        this.user = user;
        this.userEmail = user != null ? user.getEmail() : null;
        this.question = question;
    }

    // Constructor for view/delete (with just email and question)
    public FAQ(String userEmail, String question) {
        this.userEmail = userEmail;
        this.question = question;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }
}
