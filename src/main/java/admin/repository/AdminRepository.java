package admin.repository;

import admin.model.Admin;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class AdminRepository {
    private final String filePath;
    private final String deletedFilePath;

    public AdminRepository(String filePath, String deletedFilePath) {
        this.filePath = filePath;
        this.deletedFilePath = deletedFilePath;
    }

    public void save(Admin admin) throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true));
        writer.write(admin.getAdminID()+","+ admin.getName()+","+admin.getUsername() + "," + admin.getPassword()+ "," + admin.getProfilePicture());
        writer.newLine();
        writer.close();
    }

    public List<Admin> findAll() throws IOException {
        List<Admin> admins = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return admins;

        BufferedReader reader = new BufferedReader(new FileReader(file));
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts.length == 5) {
                admins.add(new Admin(parts[0], parts[1],parts[2], parts[3],parts[4]));
            }
        }
        reader.close();
        return admins;
    }

    public List<Admin> findAllDeleted() throws IOException {
        List<Admin> admins = new ArrayList<>();
        File file = new File(deletedFilePath);
        if (!file.exists()) return admins;

        BufferedReader reader = new BufferedReader(new FileReader(deletedFilePath));
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts.length == 5) {
                admins.add(new Admin(parts[0], parts[1],parts[2], parts[3],parts[4]));
            }
        }
        reader.close();
        return admins;
    }



    public void saveAdmin(Admin admin) throws IOException {
        List<Admin> admins = findAll();
        admins.add(admin);
        saveAll(admins);
    }


    public void saveAll(List<Admin> admins) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Admin admin : admins) {
                String line = String.join(",",
                        admin.getAdminID(),
                        admin.getName(),
                        admin.getUsername(),
                        admin.getPassword(),
                        admin.getProfilePicture()
                );
                writer.write(line);
                writer.newLine();
            }
        }
    }

    public void updateUser(String email, Admin updatedAdmin) throws Exception {
        List<Admin> users = findAll();
        for (Admin user : users) {
            if (user.getUsername().equals(email)) {
                user.setName(updatedAdmin.getName());
                break;
            }
        }
        saveAll(users);
    }

    public Admin getUserByEmail(String email) throws IOException {
        List<Admin> users = findAll();

        for (Admin user : users) {
            if (user.getUsername().equals(email))
                return user;
        }

        return null;
    }

    public void changePassword(String email, String newPassword) throws IOException {
        List<Admin> users = findAll();
        for (Admin user : users) {
            if (user.getUsername().equals(email)) {
                user.setPassword(newPassword);
                break;
            }
        }
        saveAll(users);
    }

    public void changePicture(String email, String profilePicture) throws IOException {
        List<Admin> users = findAll();
        for (Admin user : users) {
            if (user.getUsername().equals(email)) {
                user.setProfilePicture(profilePicture);
                break;
            }
        }
        saveAll(users);
    }


    public void deleteUser(String email) throws IOException {
        List<Admin> users = findAll();
        List<Admin> updated = new ArrayList<>();
        Admin deletedUser = null;

        for (Admin u : users) {
            if (!u.getUsername().equals(email)) {
                updated.add(u);
            } else {
                deletedUser = u;
            }
        }

        saveAll(updated);

        if (deletedUser != null) {
            saveDeletedAdmin(deletedUser);
        }
    }

    public void saveDeletedAdmin(Admin admin) throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter(deletedFilePath, true));
        writer.write(admin.getAdminID()+","+ admin.getName()+","+admin.getUsername() + "," + admin.getPassword()+ "," + admin.getProfilePicture());
        writer.newLine();
        writer.close();
    }


    public void editAdmin(String email, String name, String password) throws IOException {
        List<Admin> admins = findAll();
        for (Admin admin : admins) {
            if (admin.getUsername().equalsIgnoreCase(email)) {
                admin.setName(name);
                admin.setPassword(password);
                break;
            }
        }
        saveAll(admins);
    }

    public void deletePicture(String email) throws IOException {
        List<Admin> users = findAll();
        String defaultPicture="adminProfilePics/profile.jpg";
        for (Admin user : users) {
            if (user.getUsername().equals(email)) {
                user.setProfilePicture(defaultPicture);
                break;
            }
        }
        saveAll(users);
    }
}