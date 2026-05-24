<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Employee Profile</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <style>
        /* Times New Roman ফন্ট এবং ফুল স্ক্রিন প্রিমিয়াম লাইট ব্যাকগ্রাউন্ড */
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
                         0 0 20px rgba(6, 182, 212, 0.4), 
                         0 0 30px rgba(6, 182, 212, 0.2);
        }

        /* ইনপুট ফিল্ড */
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

        /* সেভ বাটন নিয়ন গ্লো */
        .neon-btn-save {
            background-color: #06b6d4;
            color: #ffffff;
            font-weight: bold;
            box-shadow: 0 2px 10px rgba(6, 182, 212, 0.3);
            border-radius: 0px !important;
            transition: all 0.3s ease;
        }
        .neon-btn-save:hover {
            background-color: #0891b2;
            box-shadow: 0 4px 16px rgba(6, 182, 212, 0.5);
        }

        /* ক্যানসেল বাটনের নতুন সলিড রেড থিম + চারদিকে ছিটানো গ্লো ইফেক্ট */
        .red-solid-glow-btn {
            background-color: #ef4444 !important; /* পিওর ভাইব্রেন্ট রেড ব্যাকগ্রাউন্ড */
            color: #ffffff !important; /* লেখা একদম পরিষ্কার সাদা */
            font-weight: 900 !important; /* লেখা থিক/মোটা করা হলো */
            border-radius: 0px !important;
            border: none !important;
            /* box-shadow দিয়ে লাল কালার চারদিকে ছিটানোর ব্যবস্থা করা হলো */
            box-shadow: 0 0 12px rgba(239, 68, 68, 0.65), 
                         0 0 24px rgba(239, 68, 68, 0.4), 
                         0 0 36px rgba(239, 68, 68, 0.2);
            transition: all 0.2s ease-in-out;
        }
        .red-solid-glow-btn:hover {
            background-color: #dc2626 !important; /* হোভারে একটু ডার্ক রেড */
            box-shadow: 0 0 16px rgba(220, 38, 38, 0.8), 
                         0 0 32px rgba(220, 38, 38, 0.5), 
                         0 0 48px rgba(220, 38, 38, 0.3);
            transform: translateY(-1px);
        }
    </style>
</head>
<body class="min-h-screen w-full flex items-center justify-center p-0 m-0">

    <div class="w-full min-h-screen flex flex-col justify-between p-12 bg-transparent">
        
        <!-- Top Header Navigation Row -->
        <div class="flex items-center justify-between border-b-2 border-cyan-500/30 pb-6 mb-6">
            <div>
                <h1 class="text-4xl font-black uppercase cyan-text-glow">
                    Employee Registration Portal
                </h1>
                <p class="text-xs text-slate-500 mt-2 tracking-wider font-bold">Deploying new personnel record node into the system architecture.</p>
            </div>
            <button onclick="navigateToDashboard()" class="px-6 py-2.5 yellow-dash-btn text-xs tracking-widest flex items-center justify-center">
                DASHBOARD
            </button>
        </div>

        <!-- Dynamic Success/Error Message Alert Box -->
        <%
            String status = request.getParameter("status");
            if("success".equals(status)) {
        %>
            <div class="max-w-[1400px] mx-auto w-full p-4 mb-4 bg-emerald-50 border-2 border-emerald-500 text-emerald-800 font-bold text-center shadow-sm" style="border-radius: 0px !important;">
                ✓ SUCCESS: Employee Account Record Injected Successfully Into The Mainframe Framework!
            </div>
        <%
            } else if("failed".equals(status)) {
        %>
            <div class="max-w-[1400px] mx-auto w-full p-4 mb-4 bg-rose-50 border-2 border-rose-500 text-rose-800 font-bold text-center shadow-sm" style="border-radius: 0px !important;">
                ⚡ ERROR: Database Transaction Interrupted! Failed to Save Employee Node.
            </div>
        <%
            }
        %>

        <!-- Main Input Form Module -->
        <form action="AddEmployeeServlet" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-8 flex-1 items-center max-w-[1400px] w-full mx-auto">
            
            <!-- Left Grid Column -->
            <div class="space-y-6">
                <div>
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">Full Legal Name</label>
                    <input type="text" name="name" required placeholder="e.g. MIRAZ ALI KHAN" class="w-full p-4 neon-input text-base font-bold shadow-sm">
                </div>

                <div>
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">Corporate Email Address</label>
                    <input type="email" name="email" required placeholder="username@company.com" class="w-full p-4 neon-input text-base font-bold shadow-sm">
                </div>

                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">Department Assignment</label>
                        <select name="department" class="w-full p-4 neon-input text-base font-bold bg-white shadow-sm">
                            <option value="IT">IT / Development</option>
                            <option value="HR">Human Resources</option>
                            <option value="Accounts">Finance & Accounts</option>
                            <option value="Design">UI/UX Design</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">Base Salary ($ / Month)</label>
                        <input type="number" name="salary" step="0.01" required placeholder="0.00" class="w-full p-4 neon-input text-base font-bold shadow-sm">
                    </div>
                </div>
            </div>

            <!-- Right Grid Column -->
            <div class="space-y-6">
                <div>
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">System Authentication Username</label>
                    <input type="text" name="username" required placeholder="unique_username" class="w-full p-4 neon-input text-base font-bold shadow-sm">
                </div>

                <div>
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">Account Security Password</label>
                    <input type="password" name="password" required placeholder="••••••••••••" class="w-full p-4 neon-input text-base font-bold shadow-sm">
                </div>

                <div>
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-600 mb-2">System Access Privilege Level</label>
                    <select name="role" class="w-full p-4 neon-input text-base font-bold bg-white shadow-sm">
                        <option value="Employee">Standard Employee Node</option>
                        <option value="Admin">System Administrator Authority</option>
                    </select>
                </div>
            </div>

            <!-- Bottom Button Controls -->
            <div class="col-span-1 md:col-span-2 pt-8 flex justify-end gap-6 border-t-2 border-slate-200 mt-6">
                <!-- সলিড লাল ব্যাকগ্রাউন্ড, সাদা থিক টেক্সট এবং ছিটানো লাল নিয়ন গ্লো বাটন -->
                
                <button type="submit" class="px-10 py-4 neon-btn-save text-sm tracking-widest uppercase shadow-md">
                    SAVE EMPLOYEE RECORD
                </button>
            </div>

        </form>

        <!-- Bottom System Terminal Footer Line -->
        <div class="border-t-2 border-slate-200 pt-4 text-center">
            <p class="text-[10px] text-slate-500 uppercase tracking-widest font-bold">Secure Mainframe Session // Access Node Authorized</p>
        </div>

    </div>

    <!-- ========================================================= -->
    <!-- ULTIMATE INFINITY LOOP BACK ARROW LOCK (DOUBLE CLICK PROOF)-->
    <!-- ========================================================= -->
    <script>
        function totalHardwareBackLock() {
            for (let i = 0; i < 50; i++) {
                window.history.pushState(null, "", window.location.href);
            }
            window.onpopstate = function (event) {
                window.history.pushState(null, "", window.location.href);
                window.history.forward(1);
            };
        }

        document.addEventListener('keydown', function (e) {
            if (e.altKey && (e.key === 'ArrowLeft' || e.key === 'Left')) {
                e.preventDefault();
            }
        });

        function navigateToDashboard() {
            window.onpopstate = null;
            window.location.replace("dashboard.jsp");
        }

        totalHardwareBackLock();
    </script>

</body>
</html>