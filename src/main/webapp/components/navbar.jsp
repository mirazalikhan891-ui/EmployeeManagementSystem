<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   
    if (currentUsername == null || currentUsername.trim().isEmpty()) {
        currentUsername = "System User";
    }
    if (currentRole == null || currentRole.trim().isEmpty()) {
        currentRole = "Staff Member";
    }
%>
<nav class="flex items-center justify-between px-8 py-5 bg-white border-b border-slate-200 sticky top-0 z-50 shadow-sm" style="font-family: 'Times New Roman', Times, serif !important;">

    <!-- Left Brand & Welcome Message with Dynamic Greeting Title -->
    <div class="flex items-center gap-4 shrink-0">
        <div class="w-12 h-12 rounded-2xl bg-indigo-600 flex items-center justify-center text-white text-xl font-bold shadow-md shadow-indigo-100">
            <%= currentUsername.substring(0, 1).toUpperCase() %>
        </div>
        <div>
            <h1 class="text-xl font-bold text-slate-900 tracking-tight flex items-center gap-2">
                Good Morning, <%= currentRole %> 👋
            </h1>
            <p class="text-xs font-medium text-slate-400 mt-0.5 flex items-center gap-2">
                <span>Here's your operational status for today.</span>
                <span class="text-slate-300">|</span>
                <!-- Real-Time Digital Clock Container -->
                <span id="liveClockDisplay" class="text-emerald-700 font-bold bg-emerald-50 px-2 py-0.5 rounded border border-emerald-100/50"></span>
            </p>
        </div>
    </div>

    <!-- Center Section: Empty Space Keeper to balance layout -->
    <div class="flex-1"></div>

    <!-- Right Interaction Suite -->
    <div class="flex items-center gap-6 shrink-0">
        
        <!-- Premium Minimal Search Bar -->
        <div class="w-[360px] h-11 rounded-xl bg-slate-50 border border-slate-200 flex items-center px-4">
            <span class="text-slate-400 mr-2 shrink-0">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
            </span>
            <input 
                type="text" 
                placeholder="Search employees, system metrics, reports..." 
                class="bg-transparent outline-none w-full text-sm text-slate-700 placeholder:text-slate-400">
        </div>

        <!-- Notification Bell -->
        <button class="w-11 h-11 rounded-xl bg-white border border-slate-200 flex items-center justify-center relative shadow-sm text-slate-500 hover:text-slate-800 transition-colors">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
            </svg>
            <span class="absolute top-2.5 right-2.5 w-2 h-2 bg-rose-500 rounded-full ring-2 ring-white"></span>
        </button>

        <!-- Dynamic Profile Card Group -->
        <div class="flex items-center gap-3 border-l border-slate-200/80 pl-6">
            <img src="https://i.pravatar.cc/150?img=12" class="w-11 h-11 rounded-full border border-slate-200 shadow-sm object-cover">
            <div>
                <h3 class="text-sm font-bold text-slate-800 leading-none">
                    <%= currentUsername %>
                </h3>
                <p class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider mt-1">
                    <%= currentRole.equalsIgnoreCase("Admin") ? "System Director" : "Team Member" %>
                </p>
            </div>
        </div>

        
        <button onclick="executeSecureLogout()" title="Terminate Session" class="w-11 h-11 border border-rose-200 bg-rose-50/50 hover:bg-rose-100 text-rose-600 active:scale-95 transition-all flex items-center justify-center rounded-xl shadow-sm" style="border-radius: 12px !important;">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
            </svg>
        </button>

    </div>
</nav>

<!-- JavaScript Engine for Live Clock & Safe Redirect Logout -->
<script>
    
    
    function executeSecureLogout() {
       
        window.location.replace("login.jsp");
    }

    function startLiveDashboardClock() {
        const clockElement = document.getElementById('liveClockDisplay');
        if (!clockElement) return;

        function updateClock() {
            const now = new Date();
            let options = { 
                hour: '2-digit', 
                minute: '2-digit', 
                second: '2-digit', 
                hour12: true 
            };
            clockElement.innerText = now.toLocaleTimeString('en-US', options);
        }

        updateClock();
        setInterval(updateClock, 1000);
    }

    document.addEventListener('DOMContentLoaded', startLiveDashboardClock);
    if (document.readyState === "complete" || document.readyState === "interactive") {
        startLiveDashboardClock();
    }
</script>