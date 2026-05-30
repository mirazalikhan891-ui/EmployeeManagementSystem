package com.ems.model;

public class Employee {
    private int id;
    private String name;
    private String email;
    private String department;
    private double salary;
    private String username;
    private String password;
    private String role;
    private String image_path;
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    public double getSalary() { return salary; }
    public void setSalary(double salary) { this.salary = salary; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getImagePath() {
    	return image_path;
    }
    public void setImagePath(String image_path) {
    	this.image_path = image_path;
    }
}