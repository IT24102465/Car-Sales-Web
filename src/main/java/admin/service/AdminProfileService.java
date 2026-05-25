package admin.service;

import admin.model.Admin;
import admin.repository.AdminRepository;

import java.io.IOException;
import java.util.List;

public class AdminProfileService {
    private final AdminRepository adminRepository;

    public AdminProfileService(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }

    public List<Admin> getAllAdmins() throws IOException {
        return adminRepository.findAll();
    }

    public List<Admin> getAllDeletedAdmins() throws IOException {
        return adminRepository.findAllDeleted();
    }

    public void saveAdmins(List<Admin> admins) throws IOException {
        adminRepository.saveAll(admins);
    }



    public void updateProfile(String email, Admin updatedAdmin) throws Exception {
        if (updatedAdmin.getName() == null || updatedAdmin.getName().isEmpty()) {
            throw new Exception("Full name is required");
        }
        adminRepository.updateUser(email, updatedAdmin);
    }

    public boolean isPasswordStrong(String password) {  // Remove the parameter
        return password != null &&
                password.length() >= 8 &&
                password.matches(".*[A-Z].*") && // at least one uppercase
               password.matches(".*\\d.*") &&   // at least one digit
                password.matches(".*[!@#$%^&*].*"); // at least one special char
    }

    public void changePassword(String email, String currentPassword,
                               String newPassword, String confirmPassword) throws Exception {
        Admin user = adminRepository.getUserByEmail(email);

        if (user == null) {
            throw new Exception("User not found");
        }


        if (!user.getPassword().equals(currentPassword)) {
            throw new Exception("Current password is incorrect");
        }
        if (!newPassword.equals(confirmPassword)) {
            throw new Exception("New passwords don't match");
        }
        if (!isPasswordStrong(newPassword)) {
            throw new Exception("Password must be 8+ chars with uppercase, number, and special char");
        }

        adminRepository.changePassword(email, newPassword);
    }

    public void updateProfilePicture(String email, String profilePicture) throws Exception {
        Admin user = adminRepository.getUserByEmail(email);
        if (user == null) {
            throw new Exception("User not found");
        }
        adminRepository.changePicture(email, profilePicture);
    }


    public void deleteAccount(String email) throws Exception {
        // Delete user from repository
        adminRepository.deleteUser(email);

        // Add any other cleanup operations here if needed
    }


    public void registerAdmin(Admin admin) throws IOException {
        adminRepository.saveAdmin(admin);
    }


    public Admin getUserByEmail(String email) throws IOException {
        return adminRepository.getUserByEmail(email);
    }

    public void editAdmin(String email, String name, String password) throws IOException {
        adminRepository.editAdmin(email, name, password);
    }


    public void deletePicture(String email) throws IOException {
        adminRepository.deletePicture(email);
    }
}
