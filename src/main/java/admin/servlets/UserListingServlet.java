package admin.servlets;

import login.model.User;
import login.repository.impl.FileUserRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/userListing")
public class UserListingServlet extends HttpServlet {
    private FileUserRepository fileUserRepository;



    public void init() {
        String filePath = getServletContext().getRealPath("/users.txt");
        this.fileUserRepository=new FileUserRepository(filePath);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = null;
        try {
            users = fileUserRepository.getAllUsers();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("userList",users);
        request.getRequestDispatcher("/userListing.jsp").forward(request, response);
    }
}
