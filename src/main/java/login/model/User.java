package login.model;

import java.io.Serializable;

public class User implements Serializable {

    private static final long serialVersionUID = 1L;
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private String userType;

    // Constructors
    public User() {}

    public User(String fullName, String email, String phone, String password, String userType) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.userType = userType;
    }

    // Getters and Setters
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public static boolean isPasswordStrong(String password) {
        return password != null &&
                password.length() >= 8 &&
                password.matches(".*[A-Z].*") && // Uppercase
                password.matches(".*\\d.*") &&   // Digit
                password.matches(".*[!@#$%^&*].*"); // Special char
    }

    // Validation methods
    public boolean validatePassword(String confirmPassword) {
        return this.password.equals(confirmPassword);
    }

    public boolean isValidEmail() {
        return email != null && email.matches("^[\\w-_.+]*[\\w-_.]@([\\w]+\\.)+[\\w]+[\\w]$");
    }
    public boolean isPasswordStrong() {  // Remove the parameter
        return this.password != null &&
                this.password.length() >= 8 &&
                this.password.matches(".*[A-Z].*") && // at least one uppercase
                this.password.matches(".*\\d.*") &&   // at least one digit
                this.password.matches(".*[!@#$%^&*].*"); // at least one special char
    }
    private String avatarUrl; // Add this new field

    // Existing constructors and methods

    // Add these new methods
    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

}