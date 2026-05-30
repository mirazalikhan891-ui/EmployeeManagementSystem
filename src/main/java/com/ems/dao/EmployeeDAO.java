package com.ems.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.ems.model.Employee;
import com.ems.utils.DBConnection;

public class EmployeeDAO {
    
    // Method 1: Login
    public Employee login(String username, String password) {
        Employee emp = null;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM employees WHERE username=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                emp = new Employee();
                emp.setId(rs.getInt("id"));
                emp.setName(rs.getString("name"));
                emp.setRole(rs.getString("role"));
                emp.setUsername(rs.getString("username"));
                emp.setImagePath(rs.getString("image_path"));
                emp.setDepartment(rs.getString("department"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emp;
    } 

    // Method 2: Get All Employees
    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM employees"; 
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Employee emp = new Employee();
                emp.setId(rs.getInt("id"));
                emp.setName(rs.getString("name"));
                emp.setEmail(rs.getString("email"));
                emp.setDepartment(rs.getString("department"));
                emp.setSalary(rs.getDouble("salary"));
                emp.setRole(rs.getString("role"));
                emp.setImagePath(rs.getString("image_path"));
                list.add(emp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    } 
    
    
    public int getLastMonthEmployeeCount() {
        int count = 0;
        try {
            Connection con = DBConnection.getConnection();
            // কুয়েরি: যেই এমপ্লয়িরা গত মাসে জয়েন করেছে তাদের গুনবে
            String query = "SELECT COUNT(*) FROM employees WHERE MONTH(joining_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)";
            java.sql.PreparedStatement ps = con.prepareStatement(query);
            java.sql.ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return count;
    }

    public List<Employee> getEmployeesByPage(int start, int total) {
        List<Employee> list = new ArrayList<>(); 
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM employees LIMIT ?, ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, start);
            ps.setInt(2, total);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Employee emp = new Employee();
                emp.setId(rs.getInt("id"));
                emp.setName(rs.getString("name"));
                emp.setEmail(rs.getString("email"));
                emp.setDepartment(rs.getString("department"));
                emp.setSalary(rs.getDouble("salary"));
                emp.setRole(rs.getString("role"));
                list.add(emp);
            }
        } catch (Exception e) { 
            System.out.println("!!! EMS PAGINATION ERROR !!! -> " + e.getMessage());
            e.printStackTrace(); 
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e){}
            try { if(ps != null) ps.close(); } catch(Exception e){}
            try { if(con != null) con.close(); } catch(Exception e){}
        }
        return list;
    }

    public int getEmployeeCount() {

        int count = 0;

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT COUNT(*) FROM employees";

            ps = con.prepareStatement(query);

            rs = ps.executeQuery();

            if(rs.next()) {

                count = rs.getInt(1);

            }

        } catch(Exception e) {

            e.printStackTrace();

        } finally {

            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}

        }

        return count;
    }
public boolean addEmployee(Employee emp) {
    boolean status = false;
    try {
        Connection con = DBConnection.getConnection();
        String query = "INSERT INTO employees (name, email, department, salary, username, password, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, emp.getName());
        ps.setString(2, emp.getEmail());
        ps.setString(3, emp.getDepartment());
        ps.setDouble(4, emp.getSalary());
        ps.setString(5, emp.getUsername());
        ps.setString(6, emp.getPassword());
        ps.setString(7, emp.getRole());
        
        int i = ps.executeUpdate();
        if (i > 0) {
            status = true;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return status;
}

public Employee getEmployeeById(int id) {

    Employee emp = null;

    try {

        Connection con = DBConnection.getConnection();

        String sql = "SELECT * FROM employees WHERE id=?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            emp = new Employee();

            emp.setId(rs.getInt("id"));
            emp.setName(rs.getString("name"));
            emp.setEmail(rs.getString("email"));
            emp.setDepartment(rs.getString("department"));
            emp.setSalary(rs.getDouble("salary"));
            emp.setRole(rs.getString("role"));
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return emp;
}
public boolean deleteEmployee(int id) {

    boolean status = false;

    try {

        Connection con = DBConnection.getConnection();

        String sql = "DELETE FROM employees WHERE id=?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, id);

        System.out.println("Deleting from DB ID = " + id);

        int rowsDeleted = ps.executeUpdate();

        System.out.println("Rows Deleted = " + rowsDeleted);

        if (rowsDeleted > 0) {
            status = true;
        }

        ps.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return status;
}

//UPDATE EMPLOYEE
public boolean updateEmployee(Employee emp) {

 boolean status = false;

 try {

     Connection con = DBConnection.getConnection();

     String sql = "UPDATE employees SET name=?, email=?, department=?, salary=?, role=? WHERE id=?";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setString(1, emp.getName());
     ps.setString(2, emp.getEmail());
     ps.setString(3, emp.getDepartment());
     ps.setDouble(4, emp.getSalary());
     ps.setString(5, emp.getRole());
     ps.setInt(6, emp.getId());

     int row = ps.executeUpdate();

     if (row > 0) {
         status = true;
     }

     ps.close();
     con.close();

 } catch (Exception e) {
     e.printStackTrace();
 }

 return status;
}



}



				

