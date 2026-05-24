<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // সেশন চেক
    String currentRole = (String) session.getAttribute("role");

    String currentUsername = (String) session.getAttribute("username");
    if (currentRole == null || currentUsername == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int totalEmployeesCount = 0;
    int lastMonthTotal = 0; 
    double growthPercent = 0.0;
    
    // DAO অবজেক্ট তৈরি
    com.ems.dao.EmployeeDAO countDao = new com.ems.dao.EmployeeDAO();
    
    try {
        // বর্তমান এমপ্লয়ি সংখ্যা
        java.util.List<com.ems.model.Employee> listForCount = countDao.getAllEmployees();
        if (listForCount != null) {
            totalEmployeesCount = listForCount.size();
        }
        
        // গত মাসের এমপ্লয়ি সংখ্যা (ডাটাবেজ থেকে)
        lastMonthTotal = countDao.getLastMonthEmployeeCount();
        
        // গ্রোথ ক্যালকুলেশন
        if (lastMonthTotal > 0) {
            growthPercent = ((double)(totalEmployeesCount - lastMonthTotal) / lastMonthTotal) * 100;
        } else if (totalEmployeesCount > 0) {
            // যদি গত মাসে ০ থাকে কিন্তু এই মাসে এমপ্লয়ি থাকে, তবে ১০০% গ্রোথ
            growthPercent = 100.0;
        }
        
    } catch(Exception e) {
        e.printStackTrace();
    }
    
    // রিকোয়েস্ট স্কোপে ডেটা সেট করা
    request.setAttribute("LIVE_EMP_COUNT", totalEmployeesCount);
    request.setAttribute("EMP_GROWTH_VAL", String.format("%.1f", growthPercent));
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Enterprise Management System</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <!-- ApexCharts CDN -->
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f1f5f9 !important;
        }
    </style>
</head>
<body class="bg-[#f1f5f9] text-slate-800 min-h-screen overflow-x-hidden antialiased">

<div class="relative z-10">
   
    <%@ include file="components/navbar.jsp" %>

   
    <main class="p-6 max-w-[1700px] mx-auto">
        <%
        // রোলের ওপর ভিত্তি করে নিখুঁত ড্যাশবোর্ড লোড হবে, রিফ্রেশ করলেও চেঞ্জ হবে না
        if (currentRole.equalsIgnoreCase("Admin")) {
        %>
            <jsp:include page="admin-dashboard.jsp" />
        <%
        } else {
        %>
            <jsp:include page="employee-dashboard.jsp" />
        <%
        }
        %>
    </main>
</div>

</body>
</html>