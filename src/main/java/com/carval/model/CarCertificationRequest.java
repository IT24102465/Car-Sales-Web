package com.carval.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CarCertificationRequest {
    private String brand;
    private String model;
    private int year;
    private int mileage;
    private double price;
    private String location;
    private String ownerContact;
    private String damages;
    private String status;
    private LocalDateTime submissionDate;

    // Constructor
    public CarCertificationRequest(String brand, String model, int year, 
                                  int mileage, double price, String location, 
                                  String ownerContact, String damages) {
        this.brand = brand;
        this.model = model;
        this.year = year;
        this.mileage = mileage;
        this.price = price;
        this.location = location;
        this.ownerContact = ownerContact;
        this.damages = damages;
        this.status = "Pending Approval";
        this.submissionDate = LocalDateTime.now();
    }

    // Getters and setters
    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMileage() {
        return mileage;
    }

    public void setMileage(int mileage) {
        this.mileage = mileage;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getOwnerContact() {
        return ownerContact;
    }

    public void setOwnerContact(String ownerContact) {
        this.ownerContact = ownerContact;
    }

    public String getDamages() {
        return damages;
    }

    public void setDamages(String damages) {
        this.damages = damages;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(LocalDateTime submissionDate) {
        this.submissionDate = submissionDate;
    }

    // Method to format data for writing to text file
    public String toStringFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return "Brand: " + brand + "\n" +
               "Model: " + model + "\n" +
               "Year: " + year + "\n" +
               "Mileage: " + mileage + "\n" +
               "Price: $" + String.format("%.2f", price) + "\n" +
               "Location: " + location + "\n" +
               "Owner Contact: " + ownerContact + "\n" +
               "Damages: " + damages + "\n" +
               "Status: " + status + "\n" +
               "Submission Date: " + submissionDate.format(formatter) + "\n" +
               "---\n";
    }
}