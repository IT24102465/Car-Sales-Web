package admin.servlets;

import carsale.model.Car;
import filter.ds.LinkedList;
import filter.util.CarLoader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/viewCar")
public class ViewCarServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("identifier");
        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carListing");
            return;
        }

        LinkedList<Car> cars = CarLoader.loadCars(getServletContext());
        LinkedList<Car>.LinkedListIterator it = cars.iterator();
        while (it.hasNext()) {
            Car car = it.next();
            if (id.equals(car.getTimestamp())) {
                request.setAttribute("car", car);
                break;
            }
        }

        request.getRequestDispatcher("/viewCar.jsp").forward(request, response);
    }
}
