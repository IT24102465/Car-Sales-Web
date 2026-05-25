package login.service;

import login.model.User;
import login.repository.UserRepository;
import login.repository.impl.FileUserRepository;

import java.util.List;

public class ProfileService {
    private final UserRepository userRepository;

    public ProfileService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void updateProfile(String email, User updatedUser) throws Exception {
        if (updatedUser.getFullName() == null || updatedUser.getFullName().isEmpty()) {
            throw new Exception("Full name is required");
        }
        userRepository.updateUser(email, updatedUser);
    }

    public void changePassword(String email, String currentPassword,
                               String newPassword, String confirmPassword) throws Exception {
        User user = userRepository.getUserByEmail(email);

        if (!user.getPassword().equals(currentPassword)) {
            throw new Exception("Current password is incorrect");
        }
        if (!newPassword.equals(confirmPassword)) {
            throw new Exception("New passwords don't match");
        }
        if (!User.isPasswordStrong(newPassword)) {
            throw new Exception("Password must be 8+ chars with uppercase, number, and special char");
        }

        userRepository.changePassword(email, newPassword);
    }
    // Add these methods to your existing ProfileService class

    // New method to handle avatar updates
    public void updateAvatar(String email, String avatarUrl) throws Exception {
        if (userRepository instanceof FileUserRepository) {
            ((FileUserRepository) userRepository).updateAvatarUrl(email, avatarUrl);
        } else {
            // Fallback for other repository implementations
            User user = userRepository.getUserByEmail(email);
            user.setAvatarUrl(avatarUrl);
            userRepository.updateUser(email, user);
        }
    }
    public void deleteAccount(String email, String contextPath) throws Exception {
        // Delete user from repository
        userRepository.deleteUser(email, contextPath);

        // Add any other cleanup operations here if needed
    }

}