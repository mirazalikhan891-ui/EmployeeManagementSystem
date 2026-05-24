<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registered Employee Master Database Log</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <style>
        body {
            font-family: 'Times New Roman', Times, serif !important;
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
        }

        /* সায়ান কালার চারদিকে ছিটানো গ্লো */
        .cyan-text-glow {
            color: #0e7490; 
            font-weight: 900 !important; 
            letter-spacing: 2px;
            text-shadow: 0 0 10px rgba(6, 182, 212, 0.6), 
                         0 0 20px rgba(6, 182, 212, 0.4);
        }

        /* প্রিমিয়াম হলুদ বাটন */
        .yellow-dash-btn {
            background-color: #eab308; 
            color: #0f172a; 
            border: 2px solid #ca8a04;
            font-weight: bold;
            border-radius: 0px !important;
            box-shadow: 0 2px 8px rgba(234, 179, 8, 0.3);
            transition: all 0.2s ease-in-out;
            cursor: pointer;
        }
        .yellow-dash-btn:hover {
            background-color: #facc15;
            box-shadow: 0 4px 14px rgba(234, 179, 8, 0.5);
            transform: translateY(-1px);
        }

        /* কাস্টম ডাটা গ্রিড টেবিল স্টাইল - চারকোণা এবং সলিড বর্ডার */
        .custom-table th {
            background-color: #0891b2 !important;
            color: #ffffff !important;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 1px;
            border: 2px solid #06b6d4;
        }
        .custom-table td {
            border: 2px solid #e2e8f0;
            font-size: 14px;
            /* লেখাগুলোকে একদম ডিপ ব্ল্যাক এবং থিক (বোল্ড) করার জন্য */
            color: #000000 !important;
            font-weight: bold !important;
            padding: 12px 12px;
        }
        .custom-table tr:nth-child(even) {
            background-color: #f8fafc;
        }
        .custom-table tr:hover {
            background-color: #ecfeff;
        }

        /* মেসেজ বক্সটি স্মুথলি গায়েব হওয়ার ট্রানজিশন অ্যানিমেশন */
        .fade-out-msg {
            transition: opacity 0.5s ease, transform 0.5s ease;
        }
    </style>
</head>
<body class="min-h-screen w-full flex flex-col items-center justify-between p-12 m-0 antialiased">

    <div class="w-full flex flex-col justify-between max-w-[1400px] mx-auto flex-1 w-full">
        
        <!-- Top Header Navigation Row -->
        <div class="flex items-center justify-between border-b-2 border-cyan-500/30 pb-6 mb-8">
            <div>
                <h1 class="text-4xl font-black uppercase cyan-text-glow">
                    Employee Details Registry
                </h1>
                <p class="text-xs text-slate-600 mt-2 tracking-wider font-bold">Displaying active personnel record nodes fetched from core infrastructure.</p>
            </div>
            
            <button onclick="window.location.href='dashboard.jsp'" class="px-6 py-2.5 yellow-dash-btn text-xs tracking-widest flex items-center justify-center">
                DASHBOARD
            </button>
        </div>

        <!-- Dynamic Success/Error Message Alert Box -->
        <%
            String status = request.getParameter("status");
            if("deleted".equals(status)) {
        %>
            <div id="alertNotificationBox" class="w-full p-4 mb-6 bg-rose-50 border-2 border-rose-500 text-rose-800 font-bold text-center shadow-md fade-out-msg" style="border-radius: 0px !important;">
                ✓ SUCCESS: Employee Personnel Record Node Completely Purged From Mainframe Stack!
            </div>
        <%
            } else if("updated".equals(status)) {
        %>
            <div id="alertNotificationBox" class="w-full p-4 mb-6 bg-emerald-50 border-2 border-emerald-500 text-emerald-800 font-bold text-center shadow-md fade-out-msg" style="border-radius: 0px !important;">
                ✓ SUCCESS: Employee Runtime Node Configurations Updated Successfully!
            </div>
        <%
            } else if("failed".equals(status)) {
        %>
            <div id="alertNotificationBox" class="w-full p-4 mb-6 bg-rose-100 border-2 border-rose-600 text-rose-900 font-bold text-center shadow-md fade-out-msg" style="border-radius: 0px !important;">
                ⚡ ERROR: Transaction Aborted! Processing failed.
            </div>
        <%
            }
        %>

        <!-- LIVE EMPLOYEE DETAILS SHOWCASE TABLE MODULE -->
        <div class="w-full flex-1">
            <div class="overflow-x-auto w-full shadow-md border border-slate-200">
                <table class="w-full text-left border-collapse custom-table">
                    <thead>
                        <tr>
                            <th class="p-4">Full Legal Name</th>
                            <th class="p-4">Corporate Email</th>
                            <th class="p-4">Department</th>
                            <th class="p-4">Base Salary</th>
                            <th class="p-4">Privilege Level</th>
                            <th class="p-4 text-center">System Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                com.ems.dao.EmployeeDAO dao = new com.ems.dao.EmployeeDAO();
                                List<com.ems.model.Employee> empList = dao.getAllEmployees(); 
                                
                                if(empList != null && !empList.isEmpty()) {
                                    for(com.ems.model.Employee emp : empList) {
                                        int identifier = emp.getId(); 
                        %>
                                        <tr>
                                            <!-- text-black এবং font-bold দিয়ে লিখাগুলো একদম খাস্তা কালো করা হলো -->
                                            <td class="p-4 font-bold text-black"><%= emp.getName() %></td>
                                            <td class="p-4 font-bold text-black"><%= emp.getEmail() %></td>
                                            <td class="p-4 font-bold text-black"><%= emp.getDepartment() %></td>
                                            <td class="p-4 font-mono font-bold text-black">$<%= String.format("%.2f", emp.getSalary()) %></td>
                                            <td class="p-4">
                                                <span class="px-3 py-1 text-xs uppercase font-black <%= "Admin".equalsIgnoreCase(emp.getRole()) ? "bg-amber-100 text-amber-900 border border-amber-400" : "bg-slate-200 text-slate-900 border border-slate-400" %>">
                                                    <%= emp.getRole() %>
                                                </span>
                                            </td>
                                            <td class="p-4 text-center">
                                                <div class="flex items-center justify-center gap-3">
                                                    <!-- এডিট বাটন (চারকোণা এমারেল্ড গ্রিন) -->
                                                    <a href="edit-employee.jsp?id=<%= identifier %>" class="px-3 py-1.5 bg-emerald-600 text-white font-bold text-xs uppercase tracking-wider hover:bg-emerald-700 transition-all shadow-sm hover:shadow-md" style="border-radius: 0px !important;">
                                                        EDIT
                                                    </a>
                                                    <!-- ডিলিট বাটন -->
                                                    <a href="DeleteEmployeeServlet?id=<%= identifier %>" onclick="return confirm('Are you sure you want to completely purge this record node?');" class="px-3 py-1.5 bg-rose-600 text-white font-bold text-xs uppercase tracking-wider hover:bg-rose-700 transition-all shadow-md shadow-rose-100" style="border-radius: 0px !important;">
                                                        DELETE
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                        <%
                                    }
                                } else {
                        %>
                                    <tr>
                                        <td colspan="6" class="p-8 text-center text-black font-bold uppercase tracking-widest">No Active Personnel Records Found in Mainframe.</td>
                                    </tr>
                        <%
                                }
                            } catch(Exception e) {
                                e.printStackTrace();
                        %>
                                <tr>
                                    <td colspan="6" class="p-8 text-center text-rose-600 font-bold uppercase">Database Pipeline Error: Connection Refused.</td>
                                </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Bottom System Terminal Footer Line -->
        <div class="border-t-2 border-slate-200 pt-4 text-center mt-12">
            <p class="text-[10px] text-slate-600 uppercase tracking-widest font-bold">Secure Mainframe Session // Access Node Authorized</p>
        </div>

    </div>

    <!-- ===================================================================== -->
    <!-- AUTOMATIC DISMISSAL & HARD DOUBLE-CLICK BACK ARROW LOCK ENGINE         -->
    <!-- ===================================================================== -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // ১. ৩ সেকেন্ডের সাকসেস মেসেজ ডিসমিসাল কোড
            const alertBox = document.getElementById("alertNotificationBox");
            if (alertBox) {
                setTimeout(function() {
                    alertBox.style.opacity = "0";
                    alertBox.style.transform = "translateY(-10px)";
                    setTimeout(function() {
                        alertBox.style.display = "none";
                        const cleanUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
                        window.history.replaceState({path: cleanUrl}, '', cleanUrl);
                    }, 500);
                }, 3000); 
            }

            // ২. HARD ULTIMATE INFINITY BACK ARROW LOCK CODE
            window.history.pushState(null, null, window.location.href);
            
            window.addEventListener('popstate', function (event) {
                window.history.pushState(null, null, window.location.href);
                window.location.reload();
            });
        });
    </script>

</body>
</html>