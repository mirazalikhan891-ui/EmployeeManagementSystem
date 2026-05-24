<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="w-64 bg-white border-r border-slate-200/80 p-6 min-h-screen flex flex-col justify-between hidden md:flex">
    
    <div>
        <div class="flex items-center gap-3 px-2 py-3 border-b border-slate-100 pb-5">
            <div class="w-9 h-9 rounded-xl bg-indigo-600 flex items-center justify-center text-white font-bold text-lg shadow-sm">
                T
            </div>
            <span class="font-bold text-lg tracking-tight text-slate-800">TIMT Platform</span>
        </div>
        
        <nav class="mt-6 space-y-1">
            <a href="dashboard.jsp" class="flex items-center justify-between px-4 py-3 bg-indigo-50/60 text-indigo-600 font-bold text-xs rounded-xl transition-all">
                <div class="flex items-center gap-3">
                    <i class="fa-solid fa-chart-pie text-sm"></i>
                    <span>Operations Console</span>
                </div>
                <i class="fa-solid fa-chevron-right text-[10px] opacity-70"></i>
            </a>

            <a href="manage-employees.jsp" class="flex items-center justify-between px-4 py-3 text-slate-500 hover:text-slate-800 hover:bg-slate-50 font-semibold text-xs rounded-xl transition-all">
                <div class="flex items-center gap-3">
                    <i class="fa-solid fa-users text-sm"></i>
                    <span>Roster Database</span>
                </div>
            </a>

            <a href="payroll.jsp" class="flex items-center justify-between px-4 py-3 text-slate-500 hover:text-slate-800 hover:bg-slate-50 font-semibold text-xs rounded-xl transition-all">
                <div class="flex items-center gap-3">
                    <i class="fa-solid fa-wallet text-sm"></i>
                    <span>Financial Center</span>
                </div>
            </a>
        </nav>
    </div>

    <div class="pt-4 border-t border-slate-100">
        <a href="logout.jsp" class="flex items-center gap-3 px-4 py-3 text-slate-400 hover:text-rose-600 font-bold text-xs rounded-xl transition-colors w-full">
            <i class="fa-solid fa-arrow-right-from-bracket text-sm"></i>
            <span>Terminate Session</span>
        </a>
    </div>

</aside>