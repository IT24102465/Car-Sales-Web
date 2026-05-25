package admin.service;

import admin.model.Admin;
import admin.repository.AdminRepository;

import java.io.IOException;

public class AdminService {
    private AdminRepository repository;

    public AdminService(String filePath, String deletedFilePath) {
        this.repository = new AdminRepository(filePath, deletedFilePath);
    }

    public void registerAdmin(String adminID, String name,String username, String password, String profilePicture) throws IOException {
        Admin admin = new Admin(adminID,name,username, password, profilePicture);
        repository.save(admin);
    }
}