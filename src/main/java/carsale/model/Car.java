package carsale.model;

import login.model.User;

import java.io.Serializable;
import java.util.List;

public class Car implements Serializable {
    private static final long serialVersionUID = 1L;
    private String make;
    private String model;
    private String year;
    private String mileage;
    private String condition;
    private String transmission;
    private List<String> features;
    private String description;
    private String name;
    private String email;
    private String phone;
    private String price;
    private String location;
    private String timestamp;
    private String username;
    private String images;
    private User user; // New field to store User object

    // Existing constructor
    public Car(String make, String model, String year, String mileage, String condition,
               String transmission, List<String> features, String description,
               String name, String email, String phone, String location,
               String timestamp, String username, String images, String price) {
        this.make = make;
        this.model = model;
        this.year = year;
        this.mileage = mileage;
        this.condition = condition;
        this.transmission = transmission;
        this.features = features;
        this.description = description;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.price = price;
        this.location = location;
        this.timestamp = timestamp;
        this.username = username;
        this.images = images;
        this.user = null; // Initialize user as null
    }

    // New constructor with User object
    public Car(String make, String model, String year, String mileage, String condition,
               String transmission, List<String> features, String description,
               String name, String email, String phone, String location,
               String timestamp, User user, String images, String price) {
        this.make = make;
        this.model = model;
        this.year = year;
        this.mileage = mileage;
        this.condition = condition;
        this.transmission = transmission;
        this.features = features;
        this.description = description;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.price = price;
        this.location = location;
        this.timestamp = timestamp;
        this.user = user;
        this.username = user != null && user.getFullName() != null ? user.getFullName().trim() : null;
        this.images = images;
    }

    // Existing getters and setters
    public String getMake() {
        return make;
    }
    public void setMake(String make) {
        this.make = make;
    }
    public String getModel() {
        return model;
    }
    public void setModel(String model) {
        this.model = model;
    }
    public String getYear() {
        return year;
    }
    public void setYear(String year) {
        this.year = year;
    }
    public String getMileage() {
        return mileage;
    }
    public void setMileage(String mileage) {
        this.mileage = mileage;
    }
    public String getCondition() {
        return condition;
    }
    public void setCondition(String condition) {
        this.condition = condition;
    }
    public String getTransmission() {
        return transmission;
    }
    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }
    public List<String> getFeatures() {
        return features;
    }
    public void setFeatures(List<String> features) {
        this.features = features;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getPrice() {
        return price;
    }
    public void setPrice(String price) {
        this.price = price;
    }
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public String getTimestamp() {
        return timestamp;
    }
    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
    public String getUsername() {
        // Return user.getFullName() if user exists, otherwise fall back to username
        return user != null && user.getFullName() != null ? user.getFullName().trim() : username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getImages() {
        return images;
    }
    public void setImages(String images) {
        this.images = images;
    }

    // New getter and setter for User
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
        // Update username to maintain consistency
        this.username = user != null && user.getFullName() != null ? user.getFullName().trim() : this.username;
    }
}