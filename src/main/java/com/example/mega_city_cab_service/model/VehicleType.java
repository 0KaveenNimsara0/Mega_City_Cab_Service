package com.example.mega_city_cab_service.model;

public class VehicleType {
    private int typeId;
    private String typeName;
    private double tax;
    private double perKmRate;

    // Constructors
    public VehicleType() {}

    public VehicleType(int typeId, String typeName, double tax, double perKmRate) {
        this.typeId = typeId;
        this.typeName = typeName;
        this.tax = tax;
        this.perKmRate = perKmRate;
    }

    // Getters and Setters
    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public double getTax() {
        return tax;
    }

    public void setTax(double tax) {
        this.tax = tax;
    }

    public double getPerKmRate() {
        return perKmRate;
    }

    public void setPerKmRate(double perKmRate) {
        this.perKmRate = perKmRate;
    }
}