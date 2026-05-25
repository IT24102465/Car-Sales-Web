package admin.servlets;

import carsale.model.Car;
import filter.util.CarLoader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/carListing")
public class CarListingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Car> cars = CarLoader.loadCarsAsList(getServletContext());
        request.setAttribute("carList", cars);
        request.getRequestDispatcher("/carListing.jsp").forward(request, response);
    }
}
