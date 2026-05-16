package com.ems.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;

@WebServlet("/LoginServlet")
public class LoginServelt extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        
        EmployeeDAO dao = new EmployeeDAO();
        Employee emp = dao.login(user, pass);
        
        if (emp != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", emp);
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?msg=invalid");
        }
    }
}