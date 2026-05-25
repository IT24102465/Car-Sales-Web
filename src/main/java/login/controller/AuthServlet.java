package login.controller;

import login.model.User;
import login.repository.UserRepository;
import login.repository.impl.FileUserRepository;
import login.service.AuthenticationService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private AuthenticationService authService;

    @Override
    public void init() throws ServletException {
        // Get the webapp root path
        String filePath = getServletContext().getRealPath("/users.txt");
        UserRepository userRepository = new FileUserRepository(filePath);
        this.authService = new AuthenticationService(userRepository);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("login".equals(action)) {
                handleLogin(request, response);
            } else if ("register".equals(action)) {
                handleRegistration(request, response);
            } else {
                response.sendRedirect("error.jsp?message=Invalid action");
            }
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws Exception, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Use the updated login() method that returns User
            User user = authService.login(email, password);

            // Store user in session
            request.getSession().setAttribute("user", user);

            // Redirect to success page
            response.sendRedirect(request.getContextPath() + "/front.jsp");

        } catch (Exception e) {
            // Handle login failure
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/signin.jsp").forward(request, response);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String userType = request.getParameter("userType");

            User newUser = new User(fullName, email, phone, password, userType);
            authService.register(newUser, confirmPassword);

            request.setAttribute("success", "Registration successful! Please sign in.");
            request.getRequestDispatcher("signin.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("originalFullName", request.getParameter("fullName"));
            request.setAttribute("originalEmail", request.getParameter("email"));
            request.setAttribute("originalPhone", request.getParameter("phone"));
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}