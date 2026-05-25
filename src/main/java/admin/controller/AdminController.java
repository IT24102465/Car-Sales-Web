package admin.controller;

import admin.service.AdminService;

import java.io.IOException;

public class AdminController {
    private AdminService service;

    public AdminController(String filePath, String deletedFilePath) {
        this.service = new AdminService(filePath, deletedFilePath);
    }

    public void registerAdmin(String adminID, String name, String username, String password, String profilePicture) throws IOException {
        service.registerAdmin(adminID, name, username, password, profilePicture);
    }
}