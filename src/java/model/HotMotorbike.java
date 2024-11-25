/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author hungv
 */
public class HotMotorbike {
    private int motorbikeId;
    private String brand;
    private String model;
    private String color;
    private double dailyRate;
    private int bookingCount;
    private String imageUrl;

    public HotMotorbike() {
    }

    public HotMotorbike(int motorbikeId, String brand, String model, String color, double dailyRate, int bookingCount, String imageUrl) {
        this.motorbikeId = motorbikeId;
        this.brand = brand;
        this.model = model;
        this.color = color;
        this.dailyRate = dailyRate;
        this.bookingCount = bookingCount;
        this.imageUrl = imageUrl;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    
    public int getMotorbikeId() {
        return motorbikeId;
    }

    public void setMotorbikeId(int motorbikeId) {
        this.motorbikeId = motorbikeId;
    }

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

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getDailyRate() {
        return dailyRate;
    }

    public void setDailyRate(double dailyRate) {
        this.dailyRate = dailyRate;
    }

    public int getBookingCount() {
        return bookingCount;
    }

    public void setBookingCount(int bookingCount) {
        this.bookingCount = bookingCount;
    }
    
    
    
}
