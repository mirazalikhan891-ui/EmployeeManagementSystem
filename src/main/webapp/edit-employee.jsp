<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- জাভা মডেল ও ডাও ইম্পোর্ট করা হলো ডেটা রিড করার জন্য --%>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="com.ems.dao.EmployeeDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Employee Node Profile</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <style>
        /* বাকি পেজগুলোর মতো সেম Times New Roman ফন্ট এবং ফুল স্ক্রিন প্রিমিয়াম ব্যাকগ্রাউন্ড */
        body {
            font-family: 'Times New Roman', Times, serif !important;
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
        }

        /* সায়ান কালার চারদিকে ছিটানো গ্লো ইফেক্ট */
        .cyan-text-glow {
            color: #0e7490; 
            font-weight: 900 !important; 
            letter-spacing: 2px;
            text-shadow: 0 0 10px rgba(6, 182, 212, 0.6), 
                         0 0 20px rgba(6, 182, 212, 0.4), 
                         0 0 30px rgba(6, 182, 212, 0.2);
        }

        /* ইনপুট ফিল্ড ও বর্ডারের প্রফেশনাল আর্কিটেকচার লুক */
        .neon-input {
            background-color: #ffffff !important;
            border: 2px solid rgba(6, 182, 212, 0.6); 
            color: #0f172a;
            border-radius: 0px !important;
            transition: all 0.3s ease;
        }

        .neon-input:focus {
            border-color: #06b6d4;
            box-shadow: 0 0 14px rgba(6, 182, 212, 0.5);
            outline: none;
        }

        /* রাইট টপ হলুদ ড্যাশবোর্ড বাটন */
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

        /* আপডেট বাটন (সায়ান গ্লো) */
        .neon-btn-update {
            background-color: #06b6d4;
            color: #ffffff;
            font-weight: bold;
            box-shadow: 0 2px 10px rgba(6, 182, 212, 0.3);
            border-radius: 0px !important;
            transition: all 0.3s ease;
        }
        .neon-btn-update:hover {
            background-color: #0891b2;
            box-shadow: 0 4px 16px rgba(6, 182, 212, 0.5);
        }

        /* ক্যানসেল বাটনের সলিড রেড ছিটানো গ্লো থিম */
        .red-solid-glow-btn {
            background-color: #ef4444 !important; 
            color: #ffffff !important; 
            font-weight: 900 !important; 
            border-radius: 0px !important;
            border: none !important;
            box-shadow: 0 0 12px rgba(239, 68, 68, 0.65), 
                         0 0 24px rgba(239, 68, 68, 0.4);
            transition: all 0.2s ease-in-out;
        }
        .red-solid-glow-btn:hover {
            background-color: #dc2626 !important; 
            box-shadow: 0 0 16px rgba(220, 38, 38, 0.8);
            transform: translateY(-1px);
        }
    </style>
</head>
<body class="min-h-screen w-full flex items-center justify-center p-0 m-0">

    <%
        // ইউআরএল থেকে পাঠানো আইডি রিসিভ করা হচ্ছে
        String idParam = request.getParameter("id");
        Employee emp = null;
        
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                EmployeeDAO dao = new EmployeeDAO();
                // নোট: ডাটাবেজ থেকে আইডি দিয়ে সিঙ্গেল অবজেক্ট খোঁজার মেথড (যেমন getEmployeeById) কল করা হলো
                // যদি তোমার মেথডের নাম আলাদা হয়, তবে সেই নামটা এখানে বসাবে।
                emp = dao.getEmployeeById(id); 
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // যদি কোনো কারণে অবজেক্ট খুঁজে না পায়, সেফটির জন্য ব্ল্যাঙ্ক অবজেক্ট ইনিশিয়েট করা হলো যাতে এরর না আসে
        if (emp == null) {
            emp = new Employee();
        }
    %>

    <div class="w-full min-h-screen flex flex-col justify-between p-12 bg-transparent">
        
        <!-- Top Header Navigation Row (পুরো স্ক্রিন জুড়ে চওড়া) -->
        <div class="flex items-center justify-between border-b-2 border-cyan-500/30 pb-6 mb-6">
            <div>
                <h1 class="text-4xl font-black uppercase cyan-text-glow">
                    Edit Employee Configuration
                </h1>
                <p class="text-xs text-slate-500 mt-2 tracking-wider font-bold">Modifying existing runtime personnel node data within the system frame.</p>
            </div>
           
        </div>

        <!-- Main Input Form Module (২ কলামের ফুল চওড়া গ্রিড লেআউট) -->
        <form action="UpdateEmployeeServlet" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-8 flex-1 items-center max-w-[1400px] w-full mx-auto">
            
            <!-- হিডেন ফিল্ড হিসেবে আইডি পাস করা হচ্ছে যাতে ব্যাক-এন্ড বুঝতে পারে কাকে আপডেট করতে হবে -->
            <input type="hidden" name="id" value="<%= emp.getId() %>">

            <!-- Left Grid Column -->
            <div class="space-y-6">
                <div>
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">Full Legal Name</label>
                    <input type="text" name="name" required value="<%= emp.getName() != null ? emp.getName() : "" %>" class="w-full p-4 neon-input text-base font-bold shadow-sm">
                </div>

                <div>
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">Corporate Email Address</label>
                    <input type="email" name="email" required value="<%= emp.getEmail() != null ? emp.getEmail() : "" %>" class="w-full p-4 neon-input text-base font-bold shadow-sm">
                </div>

                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">Department Assignment</label>
                        <select name="department" class="w-full p-4 neon-input text-base font-bold bg-white shadow-sm">
                            <option value="IT" <%= "IT".equalsIgnoreCase(emp.getDepartment()) ? "selected" : "" %>>IT / Development</option>
                            <option value="HR" <%= "HR".equalsIgnoreCase(emp.getDepartment()) ? "selected" : "" %>>Human Resources</option>
                            <option value="Accounts" <%= "Accounts".equalsIgnoreCase(emp.getDepartment()) ? "selected" : "" %>>Finance & Accounts</option>
                            <option value="Design" <%= "Design".equalsIgnoreCase(emp.getDepartment()) ? "selected" : "" %>>UI/UX Design</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">Base Salary ($ / Month)</label>
                        <input type="number" name="salary" step="0.01" required value="<%= emp.getSalary() %>" class="w-full p-4 neon-input text-base font-bold shadow-sm">
                    </div>
                </div>
            </div>

            <!-- Right Grid Column -->
            <div class="space-y-6">
                <div>
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">System Access Privilege Level</label>
                    <select name="role" class="w-full p-4 neon-input text-base font-bold bg-white shadow-sm">
                        <option value="Employee" <%= "Employee".equalsIgnoreCase(emp.getRole()) ? "selected" : "" %>>Standard Employee Node</option>
                        <option value="Admin" <%= "Admin".equalsIgnoreCase(emp.getRole()) ? "selected" : "" %>>System Administrator Authority</option>
                    </select>
                </div>
                
                <!-- সৌন্দর্য্য ও ব্যালেন্স বজায় রাখার জন্য একটি প্রফেশনাল ইনফো নোটিস বক্স -->
                <div class="p-6 bg-cyan-50/50 border-2 border-dashed border-cyan-500/30 font-bold text-slate-600 text-xs space-y-2">
                    <p class="text-cyan-800 uppercase font-black">⚠️ Administrative Override Security Notice</p>
                    <p>You are performing a runtime modifications process on a secure database entity block. Ensure all legal names and salary structures comply with corporate smart contracts prior to applying final batch commits.</p>
                </div>
            </div>

            <!-- Bottom Button Controls (পুরো নিচে চওড়া বর্ডারের সাথে ফিক্সড) -->
            <div class="col-span-1 md:col-span-2 pt-8 flex justify-end gap-6 border-t-2 border-slate-200 mt-6">
                <!-- ক্যানসেল বাটন: সলিড লাল ছিটানো নিয়ন আলো থিম, যা ক্লিক করলে এমপ্লয়ি লিস্ট পেজে ফেরত যাবে -->
                <button type="button" onclick="window.location.href='employee-details.jsp'" class="px-8 py-4 red-solid-glow-btn text-sm tracking-widest flex items-center justify-center">
                    ABORT CHANGES
                </button>
                <button type="submit" class="px-10 py-4 neon-btn-update text-sm tracking-widest uppercase shadow-md">
                    UPDATE EMPLOYEE NODE
                </button>
            </div>

        </form>

        <!-- Bottom System Terminal Footer Line -->
        <div class="border-t-2 border-slate-200 pt-4 text-center">
            <p class="text-[10px] text-slate-500 uppercase tracking-widest font-bold">Secure Mainframe Session // Access Node Authorized</p>
        </div>

    </div>

</body>
</html>