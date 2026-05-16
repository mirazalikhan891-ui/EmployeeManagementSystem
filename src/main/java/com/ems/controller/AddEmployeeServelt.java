package com.ems.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;

@WebServlet("/AddEmployeeServlet")
public class AddEmployeeServelt extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Form theke data gulo collect kora
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String dept = request.getParameter("department");
        double salary = Double.parseDouble(request.getParameter("salary"));
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String role = request.getParameter("role");

        // Employee object-e data set kora
        Employee emp = new Employee();
        emp.setName(name);
        emp.setEmail(email);
        emp.setDepartment(dept);
        emp.setSalary(salary);
        emp.setUsername(user);
        emp.setPassword(pass);
        emp.setRole(role);

        // DAO class call kore database-e pathano
        EmployeeDAO dao = new EmployeeDAO();
        boolean success = dao.addEmployee(emp);

        if (success) {
            // Insert successful hole list page-e ferot pathao
            response.sendRedirect("dashboard.jsp");
        } else {
            // Fail hole error message
            response.sendRedirect("add-employee.jsp?error=failed");
        }
    }
}