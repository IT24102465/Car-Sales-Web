package filter.servlets;

import carsale.model.Car;
import filter.ds.LinkedList;
import filter.manager.SearchManager;
import filter.model.CarFilter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import filter.util.BuyNowHelper;
import java.io.IOException;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Read filter parameters from request
        String make = request.getParameter("make");
        String model = request.getParameter("model");
        String transmission = request.getParameter("transmission");
        String minYearStr = request.getParameter("minYear");
        String maxYearStr = request.getParameter("maxYear");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String sortByPriceStr = request.getParameter("sortByPrice");

        CarFilter filter = new CarFilter();

        if (make != null && !make.isEmpty()) {
            filter.setMake(make);
        }
        if (model != null && !model.isEmpty()) {
            filter.setModel(model);
        }
        if (transmission != null && !transmission.isEmpty()) {
            filter.setTransmission(transmission);
        }
        if (minYearStr != null && !minYearStr.isEmpty()) {
            try {
                filter.setMinYear(Integer.parseInt(minYearStr));
            } catch (NumberFormatException ignored) {}
        }
        if (maxYearStr != null && !maxYearStr.isEmpty()) {
            try {
                filter.setMaxYear(Integer.parseInt(maxYearStr));
            } catch (NumberFormatException ignored) {}
        }
        if (minPriceStr != null && !minPriceStr.isEmpty()) {
            try {
                filter.setMinPrice(Double.parseDouble(minPriceStr));
            } catch (NumberFormatException ignored) {}
        }
        if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
            try {
                filter.setMaxPrice(Double.parseDouble(maxPriceStr));
            } catch (NumberFormatException ignored) {}
        }

        boolean sortByPrice = "true".equalsIgnoreCase(sortByPriceStr);

        // Call the SearchManager to get filtered list
        LinkedList<Car> filteredCars = SearchManager.search(filter, sortByPrice, getServletContext());

        request.setAttribute("favoriteIds", BuyNowHelper.loadFavoriteIds(request, getServletContext()));
        request.setAttribute("cars", filteredCars);
        request.setAttribute("searched", true);
        request.getRequestDispatcher("/Buynow.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Delegate GET requests to POST handler
        doPost(request, response);
    }
} 