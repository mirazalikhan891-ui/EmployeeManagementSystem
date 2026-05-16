<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Employee</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 20px; }
        .form-container { width: 400px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px #ccc; }
        input, select { width: 100%; padding: 8px; margin: 10px 0; box-sizing: border-box; }
        button { width: 100%; padding: 10px; background: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Add New Employee</h2>
        <form action="AddEmployeeServlet" method="post">
            Name: <input type="text" name="name" required>
            Email: <input type="email" name="email" required>
            Department: 
            <select name="department">
                <option value="IT">IT</option>
                <option value="HR">HR</option>
                <option value="Accounts">Accounts</option>
            </select>
            Salary: <input type="number" step="0.01" name="salary" required>
            Username: <input type="text" name="username" required>
            Password: <input type="password" name="password" required>
            Role: 
            <select name="role">
                <option value="Employee">Employee</option>
                <option value="Admin">Admin</option>
            </select>
            <button type="submit">Save Employee</button>
        </form>
    </div>
</body>
</html>