package login.repository.impl;

import login.model.User;
import login.repository.UserRepository;

import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

public class FileUserRepository implements UserRepository {
    private final String filePath;
    private final ReentrantLock fileLock = new ReentrantLock();
    private static final String FIELD_SEPARATOR = "|||";
    private static final String LINE_SEPARATOR = System.lineSeparator();

    public FileUserRepository(String filePath) {
        this.filePath = filePath;
        // Ensure parent directory exists
        new File(filePath).getParentFile().mkdirs();
    }

    @Override
    public void saveUser(User user) throws Exception {
        List<User> users = getAllUsers();
        if (userExists(user.getEmail())) {
            throw new Exception("User with this email already exists");
        }

        // Ensure avatar URL exists
        if (user.getAvatarUrl() == null || user.getAvatarUrl().isEmpty()) {
            user.setAvatarUrl(generateDefaultAvatarUrl(user));
        }

        users.add(user);
        saveAllUsers(users);
    }

    private String generateDefaultAvatarUrl(User user) {
        try {
            return "https://ui-avatars.com/api/?name=" +
                    URLEncoder.encode(user.getFullName(), "UTF-8") +
                    "&background=random";
        } catch (UnsupportedEncodingException e) {
            return "https://ui-avatars.com/api/?name=" +
                    user.getFullName().replace(" ", "+") +
                    "&background=random";
        }
    }

    @Override
    public List<User> getAllUsers() throws Exception {
        fileLock.lock();
        try {
            File file = new File(this.filePath);
            if (!file.exists()) {
                return new ArrayList<>();
            }

            List<User> users = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.trim().isEmpty()) {
                        users.add(parseUser(line));
                    }
                }
            }
            return users;
        } finally {
            fileLock.unlock();
        }
    }

    private User parseUser(String line) {
        String[] parts = line.split("\\|\\|\\|", -1); // -1 keeps empty strings
        User user = new User();
        user.setFullName(parts[0]);
        user.setEmail(parts[1]);
        user.setPhone(parts[2]);
        user.setPassword(parts[3]);
        user.setUserType(parts[4]);
        if (parts.length > 5) {
            user.setAvatarUrl(parts[5]);
        }
        return user;
    }

    @Override
    public User getUserByEmail(String email) throws Exception {
        fileLock.lock();
        try {
            List<User> users = getAllUsers();
            return users.stream()
                    .filter(u -> u.getEmail().equalsIgnoreCase(email.trim()))
                    .findFirst()
                    .orElseThrow(() -> new Exception("We couldn't find your account"));
        } finally {
            fileLock.unlock();
        }
    }

    @Override
    public boolean userExists(String email) throws Exception {
        return getAllUsers().stream()
                .anyMatch(user -> user.getEmail().equals(email));
    }

    public void updateAvatarUrl(String email, String avatarUrl) throws Exception {
        fileLock.lock();
        try {
            List<User> users = getAllUsers();
            boolean userFound = false;

            for (User user : users) {
                if (user.getEmail().equalsIgnoreCase(email)) {
                    user.setAvatarUrl(avatarUrl);
                    userFound = true;
                    break;
                }
            }

            if (!userFound) {
                throw new Exception("User not found");
            }

            saveAllUsers(users);
        } finally {
            fileLock.unlock();
        }
    }

    @Override
    public void updateUser(String email, User updatedUser) throws Exception {
        fileLock.lock();
        try {
            List<User> users = getAllUsers();
            boolean userFound = false;

            for (int i = 0; i < users.size(); i++) {
                if (users.get(i).getEmail().equalsIgnoreCase(email)) {
                    // Preserve the original password and avatar URL
                    updatedUser.setPassword(users.get(i).getPassword());
                    updatedUser.setAvatarUrl(users.get(i).getAvatarUrl());
                    users.set(i, updatedUser);
                    userFound = true;
                    break;
                }
            }

            if (!userFound) {
                throw new Exception("User with email " + email + " not found");
            }

            saveAllUsers(users);
        } finally {
            fileLock.unlock();
        }
    }

    @Override
    public void changePassword(String email, String newPassword) throws Exception {
        fileLock.lock();
        try {
            List<User> users = getAllUsers();
            boolean userFound = false;

            for (User user : users) {
                if (user.getEmail().equalsIgnoreCase(email)) {
                    user.setPassword(newPassword);
                    userFound = true;
                    break;
                }
            }

            if (!userFound) {
                throw new Exception("User not found");
            }

            saveAllUsers(users);
        } finally {
            fileLock.unlock();
        }
    }

    private void saveAllUsers(List<User> users) throws Exception {
        fileLock.lock();
        try {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(this.filePath))) {
                for (User user : users) {
                    writer.write(serializeUser(user));
                    writer.write(LINE_SEPARATOR);
                }
            }
        } finally {
            fileLock.unlock();
        }
    }

    private String serializeUser(User user) {
        return String.join(FIELD_SEPARATOR,
                user.getFullName(),
                user.getEmail(),
                user.getPhone(),
                user.getPassword(),
                user.getUserType(),
                user.getAvatarUrl() != null ? user.getAvatarUrl() : ""
        );
    }

    public boolean validateUser(String email, String password) {
        try {
            User user = getUserByEmail(email);
            return user != null && user.getPassword().equals(password);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void deleteUser(String email, String contextPath) throws Exception {
        fileLock.lock();
        try {
            List<User> users = getAllUsers();
            User userToDelete = users.stream()
                    .filter(u -> u.getEmail().equals(email))
                    .findFirst()
                    .orElseThrow(() -> new Exception("User not found"));

            // Delete avatar file if exists
            if (userToDelete.getAvatarUrl() != null && userToDelete.getAvatarUrl().contains("/uploads/avatars/")) {
                String filePath = contextPath + userToDelete.getAvatarUrl().substring(
                        userToDelete.getAvatarUrl().indexOf("/uploads/avatars/")
                );
                new File(filePath).delete();
            }

            // Remove user from list
            users.removeIf(u -> u.getEmail().equals(email));
            saveAllUsers(users);
        } finally {
            fileLock.unlock();
        }
    }
}