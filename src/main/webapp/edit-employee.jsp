<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.dao.EmployeeDAO, com.ems.model.Employee" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    EmployeeDAO dao = new EmployeeDAO();
    Employee emp = dao.getEmployeeById(id);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Employee</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 20px; }
        .form-container { width: 400px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px #ccc; }
        input, select { width: 100%; padding: 8px; margin: 10px 0; box-sizing: border-box; }
        button { width: 100%; padding: 10px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .back-link { display: block; text-align: center; margin-top: 15px; color: #555; text-decoration: none; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Edit Employee Details</h2>
        <% if (emp != null) { %>
        <form action="UpdateEmployeeServlet" method="post">
            <input type="hidden" name="id" value="<%= emp.getId() %>">
            
            Name: <input type="text" name="name" value="<%= emp.getName() %>" required>
            Email: <input type="email" name="email" value="<%= emp.getEmail() %>" required>
            
            Department: 
            <select name="department">
                <option value="IT" <%= "IT".equals(emp.getDepartment()) ? "selected" : "" %>>IT</option>
                <option value="HR" <%= "HR".equals(emp.getDepartment()) ? "selected" : "" %>>HR</option>
                <option value="Accounts" <%= "Accounts".equals(emp.getDepartment()) ? "selected" : "" %>>Accounts</option>
            </select>
            
            Salary: <input type="number" step="0.01" name="salary" value="<%= emp.getSalary() %>" required>
            
            Role: 
            <select name="role">
                <option value="Employee" <%= "Employee".equals(emp.getRole()) ? "selected" : "" %>>Employee</option>
                <option value="Admin" <%= "Admin".equals(emp.getRole()) ? "selected" : "" %>>Admin</option>
            </select>
            
            <button type="submit">Update Employee</button>
        </form>
        <% } else { %>
            <p style="color: red; text-align: center;">Employee Data Not Found!</p>
        <% } %>
        <a href="dashboard.jsp" class="back-link">← Cancel</a>
    </div>
</body>
</html>