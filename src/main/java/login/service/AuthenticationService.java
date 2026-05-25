package login.service;

import login.model.User;
import login.repository.UserRepository;

public class AuthenticationService {
    private final UserRepository userRepository;

    public AuthenticationService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public boolean register(User user, String confirmPassword) throws Exception {
        // Validate password match
        if (!user.getPassword().equals(confirmPassword)) {
            throw new Exception("Passwords do not match");
        }

        // Validate email format
        if (!user.isValidEmail()) {
            throw new Exception("Invalid email format");
        }

        // Check if user already exists
        if (userRepository.userExists(user.getEmail())) {
            throw new Exception("Email already registered");
        }

        // Validate password strength
        if (!user.isPasswordStrong()) {
            throw new Exception("Password must be at least 8 characters with uppercase, number, and special character");
        }

        userRepository.saveUser(user);
        return true;
    }

    public User login(String email, String password) throws Exception {
        // Trim and normalize email
        email = email.trim().toLowerCase();

        User user = userRepository.getUserByEmail(email);
        if (user == null) {
            throw new Exception("Invalid email or password");
        }

        if (!user.validatePassword(password)) {
            throw new Exception("Invalid email or password");
        }

        return user;  // Return the authenticated user object
    }
}