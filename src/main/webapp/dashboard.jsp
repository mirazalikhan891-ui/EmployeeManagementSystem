<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.ems.dao.EmployeeDAO" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard - Employee List</title>

<style>

table{
    width:80%;
    margin:20px auto;
    border-collapse:collapse;
    font-family:Arial, sans-serif;
}

table tr:nth-child(even){
    background-color:#f2f2f2;
}

th{
    background-color:#28a745;
    color:white;
}

th, td{
    border:1px solid #ddd;
    padding:12px;
    text-align:left;
}

a{
    text-decoration:none;
}

</style>

</head>
<body>

<h2 style="text-align:center;">
    Welcome to Employee Management System
</h2>

<div style="text-align:center; margin-bottom:15px;">

    <a href="add-employee.jsp"
       style="padding:10px 15px;
       background:#007bff;
       color:white;
       border-radius:4px;
       font-weight:bold;">

       + Add New Employee
    </a>

</div>

<%

// Current Page
int pageId = 1;

if(request.getParameter("page") != null){

    pageId = Integer.parseInt(request.getParameter("page"));

}

// Pagination Settings
int totalRecordPerPage = 3;

int startRecord = (pageId - 1) * totalRecordPerPage;

// DAO Object
EmployeeDAO dao = new EmployeeDAO();

// Employee List
List<Employee> list =
dao.getEmployeesByPage(startRecord, totalRecordPerPage);

// Serial Number
int serial = startRecord + 1;

%>

<table>

<thead>

<tr>

<th>Serial No</th>
<th>Name</th>
<th>Email</th>
<th>Department</th>
<th>Salary</th>
<th>Role</th>
<th>Action</th>

</tr>

</thead>

<tbody>

<%

if(list != null && !list.isEmpty()){

    for(Employee e : list){

%>

<tr>

<td><%= serial++ %></td>

<td><%= e.getName() %></td>

<td><%= e.getEmail() %></td>

<td><%= e.getDepartment() %></td>

<td><%= e.getSalary() %></td>

<td><%= e.getRole() %></td>

<td>

<a href="edit-employee.jsp?id=<%= e.getId() %>"
   style="color:#007bff; font-weight:bold; margin-right:10px;">

   Edit

</a>

<a href="DeleteEmployeeServlet?id=<%= e.getId() %>"
   onclick="return confirm('Are you sure you want to delete this employee?')"
   style="color:red; font-weight:bold;">

   Delete

</a>

</td>

</tr>

<%

    }

}else{

%>

<tr>

<td colspan="7"
    style="text-align:center; padding:20px; color:#666;">

    No Records Found!

</td>

</tr>

<%

}

%>

</tbody>

</table>


<!-- Pagination -->

<div style="width:80%;
margin:20px auto;
text-align:center;
font-family:Arial, sans-serif;">

<%

int totalRows =  dao.getEmployeeCount();

int totalPages =
(int)Math.ceil((double)totalRows / totalRecordPerPage);

%>


<!-- Previous Button -->

<%

if(pageId > 1){

%>

<a href="dashboard.jsp?page=<%= pageId - 1 %>"
   style="padding:8px 12px;
   margin:0 4px;
   border:1px solid #ccc;
   background:#fff;
   color:#333;">

   Previous

</a>

<%

}

%>


<!-- Page Numbers -->

<%

for(int i = 1; i <= totalPages; i++){

    if(i == pageId){

%>

<span style="padding:8px 12px;
margin:0 4px;
background:#28a745;
color:white;
font-weight:bold;
border-radius:4px;
border:1px solid #28a745;">

<%= i %>

</span>

<%

    }else{

%>

<a href="dashboard.jsp?page=<%= i %>"
   style="padding:8px 12px;
   margin:0 4px;
   border:1px solid #ccc;
   background:#fff;
   color:#333;">

   <%= i %>

</a>

<%

    }

}

%>


<!-- Next Button -->

<%

if(pageId < totalPages){

%>

<a href="dashboard.jsp?page=<%= pageId + 1 %>"
   style="padding:8px 12px;
   margin:0 4px;
   border:1px solid #ccc;
   background:#fff;
   color:#333;">

   Next

</a>

<%

}

%>

</div>

</body>
</html>