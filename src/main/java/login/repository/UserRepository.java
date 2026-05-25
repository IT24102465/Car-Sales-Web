package login.repository;

import login.model.User;
import java.util.List;

public interface UserRepository {
    void saveUser(User user) throws Exception;
    List<User> getAllUsers() throws Exception;
    User getUserByEmail(String email) throws Exception;
    boolean userExists(String email) throws Exception;

    void updateUser(String email, User updatedUser) throws Exception;
    void changePassword(String email, String newPassword) throws Exception;
    void deleteUser(String email, String contextPath) throws Exception;
}