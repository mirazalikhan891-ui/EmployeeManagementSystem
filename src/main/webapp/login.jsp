<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>EMS - Login</title>
    <style>
        body { font-family: Arial; display: flex; justify-content: center; margin-top: 50px; }
        .login-card { border: 1px solid #ccc; padding: 20px; border-radius: 8px; width: 300px; }
        input { width: 90%; margin-bottom: 10px; padding: 8px; }
        button { width: 100%; padding: 10px; background: #28a745; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <div class="login-card">
        <h2>Employee Login</h2>
        <form action="LoginServlet" method="post">
            <label> Username: </label><input type="text" name="username" required>
          <label> Password: </label> <input type="password" name="password" required>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>