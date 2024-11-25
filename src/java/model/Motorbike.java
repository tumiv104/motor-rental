/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Objects;

/**
 *
 * @author hungv
 */
public class Motorbike {

    private int id;
    private int motorbikeId;
    private String model;
    private String brand;
    private int year;
    private double dailyRate;
    private String status;
    private String licensePlate;
    private MotorbikeType typeId;
    private String color;
    private String engineSize;
    private String fuelType;
    private String imageUrl;
    private int mileage;
    private String approvalStatus;
    private Users user;

    public Motorbike() {
    }

    public Motorbike(int id, int motorbikeId, String model, String brand, int year, double dailyRate, String status, String licensePlate, MotorbikeType typeId, String color, String engineSize, String fuelType, String imageUrl, int mileage, String approvalStatus) {
        this.id = id;
        this.motorbikeId = motorbikeId;
        this.model = model;
        this.brand = brand;
        this.year = year;
        this.dailyRate = dailyRate;
        this.status = status;
        this.licensePlate = licensePlate;
        this.typeId = typeId;
        this.color = color;
        this.engineSize = engineSize;
        this.fuelType = fuelType;
        this.imageUrl = imageUrl;
        this.mileage = mileage;
        this.approvalStatus = approvalStatus;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMotorbikeId() {
        return motorbikeId;
    }

    public void setMotorbikeId(int motorbikeId) {
        this.motorbikeId = motorbikeId;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public double getDailyRate() {
        return dailyRate;
    }

    public void setDailyRate(double dailyRate) {
        this.dailyRate = dailyRate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public MotorbikeType getTypeId() {
        return typeId;
    }

    public void setTypeId(MotorbikeType typeId) {
        this.typeId = typeId;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getEngineSize() {
        return engineSize;
    }

    public void setEngineSize(String engineSize) {
        this.engineSize = engineSize;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getMileage() {
        return mileage;
    }

    public void setMileage(int mileage) {
        this.mileage = mileage;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Motorbike motorbike = (Motorbike) o;
        return motorbikeId == motorbike.motorbikeId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(motorbikeId);
    }
}
