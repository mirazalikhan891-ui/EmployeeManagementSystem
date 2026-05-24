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

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // form data নেওয়া
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // DAO object
        EmployeeDAO dao = new EmployeeDAO();

        // login check
        Employee emp = dao.login(user, pass);

        if (emp != null) {

            // session create
            HttpSession session = request.getSession();

            session.setAttribute("username", emp.getName());
            session.setAttribute("role", emp.getRole());
            session.setAttribute("user", emp);

            // dashboard এ পাঠানো
            response.sendRedirect("dashboard.jsp");

        } else {

            // login fail
            response.sendRedirect("login.jsp?msg=invalid");
        }
    }
}