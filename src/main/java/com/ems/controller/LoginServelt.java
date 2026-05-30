package com.ems.controller;

import java.io.IOException;

import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServelt extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ১. Form theke username ar password nibe
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        EmployeeDAO dao = new EmployeeDAO();
        // ২. Database-e check korbe
        Employee emp = dao.login(user, pass);

        if (emp != null) {
            // ৩. Session e username ar display name set korbe
            HttpSession session = request.getSession();
            session.setAttribute("username", user);       // Query korar jonno
            session.setAttribute("displayName", emp.getName()); // UI-e dekhano-r jonno
            session.setAttribute("role", emp.getRole());
            session.setAttribute("user", emp);
            session.setAttribute("id", emp.getId());
            
            System.out.println("Login Success for: " + user); // Console-e debug korar jonno
            response.sendRedirect("dashboard.jsp");
        } else {
            // ৪. Login fail hole
            response.sendRedirect("login.jsp?msg=invalid");
        }
    }
}