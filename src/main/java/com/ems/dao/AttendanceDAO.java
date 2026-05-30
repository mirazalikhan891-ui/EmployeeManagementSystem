package com.ems.dao;

import java.sql.*;

import java.sql.ResultSet;
import com.ems.utils.DBConnection;

import java.util.List;
import java.util.ArrayList;

public class AttendanceDAO {

    // আজকের তারিখের জন্য চেক-ইন করার মেথড
    public static boolean markAttendance(int empId) {
    	if(isCheckedIn(empId)) {
    		return false;
    	}
        boolean status = false;
        String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

        try (Connection con = DBConnection.getConnection()) {
            // ডাটাবেসে আজকের তারিখে চেক-ইন ইনসার্ট করছি
            String query = "INSERT INTO attendance (emp_id, attendance_date, status, check_in_time) VALUES (?, ?, 'present', NOW())";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, empId);
            ps.setString(2, today);
            
            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    // আজকের দিনে ইউজার অলরেডি চেক-ইন করেছে কি না তা চেক করার মেথড
    public static boolean isCheckedIn(int empId) {
        boolean present = false;
        String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
        
        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT * FROM attendance WHERE emp_id=? AND attendance_date=CURDATE()";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, empId);
            ps.setString(2, today);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                present = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return present;
    }


    public static boolean markCheckout(int empId) {

        boolean status = false;

        String today =
            new java.text.SimpleDateFormat("yyyy-MM-dd")
            .format(new java.util.Date());

        try (Connection con = DBConnection.getConnection()) {

            String query =
                "UPDATE attendance " +
                "SET check_out_time = NOW() " +
                "WHERE emp_id = ? " +
               
                "AND attendance_date = CURDATE()";

            PreparedStatement ps =
                con.prepareStatement(query);

            ps.setInt(1, empId);
            

            int rows = ps.executeUpdate();

            System.out.println("Rows Updated = " + rows);

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    public static String getTodayCheckInTime(int empId) {

        String time = "--";

        try(Connection con = DBConnection.getConnection()) {

            String query =
                "SELECT check_in_time FROM attendance " +
                "WHERE emp_id=? AND attendance_date = CURDATE()";

            PreparedStatement ps =
                con.prepareStatement(query);

            ps.setInt(1, empId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                time = rs.getString("check_in_time");

                if(time == null){
                    time = "--";
                }
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return time;
    }



    public static String getTodayCheckOutTime(int empId) {

        String time = "--";

        try(Connection con = DBConnection.getConnection()) {

            String query =
                "SELECT check_out_time FROM attendance " +
                "WHERE emp_id=? AND attendance_date = CURDATE()";

            PreparedStatement ps =
                con.prepareStatement(query);

            ps.setInt(1, empId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                time = rs.getString("check_out_time");

                if(time == null){
                    time = "--";
                }
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return time;
    }
    
    public static List<Integer> getPresentDays(int empId) {

        List<Integer> days = new ArrayList<>();

        try(Connection con = DBConnection.getConnection()) {

            String sql =
            "SELECT DAY(attendance_date) day " +
            "FROM attendance " +
            "WHERE emp_id=? AND status='present'";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setInt(1, empId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                days.add(rs.getInt("day"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return days;
    }
}
