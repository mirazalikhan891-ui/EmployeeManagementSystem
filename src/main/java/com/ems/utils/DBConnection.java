package com.ems.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    
    public static Connection getConnection() {
        Connection con = null;
        try {
           
            Class.forName("com.mysql.cj.jdbc.Driver");
            
           
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_db", "root", "1234");
            
            System.out.println("Connection Success!");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Connection Fail!");
        }
        return con;
    }
}