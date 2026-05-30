<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<%
    // সেশন থেকে ইউজারনেম এবং রোল গেট করা
    String navUsername = (session.getAttribute("username") != null) ? (String)session.getAttribute("username") : "User";
    String navRole = (session.getAttribute("role") != null) ? (String)session.getAttribute("role") : "Employee";
    
    com.ems.model.Employee navEmp = (com.ems.model.Employee) session.getAttribute("user");
    String navImg = (navEmp != null && navEmp.getImagePath() !=null)
    		? request.getContextPath() + "/" + navEmp.getImagePath()
    		:"https://i.pravatar.cc/300?img=12";
    
    // ১. ডাইনামিক রোল টেক্সট নির্ধারণ (Admin নাকি Employee)
    String displayRoleName = "Employee";
    if (navRole.equalsIgnoreCase("Admin")) {
        displayRoleName = "Admin";
    }
    
    String displayName = (String) session.getAttribute("displayName");
    if(displayName == null){
    	displayName = (String) session.getAttribute("username");
    }

    // ২. সার্ভার টাইম ট্র্যাকিং এবং ডাইনামিক গ্রিটিংস (Time-Based Greeting Engine)
    Calendar cal = Calendar.getInstance();
    int hour = cal.get(Calendar.HOUR_OF_DAY);
    String timeGreeting = "Good Morning"; // Default

    if (hour >= 12 && hour < 16) {
        timeGreeting = "Good Afternoon";
    } else if (hour >= 16 && hour < 20) {
        timeGreeting = "Good Afternoon"; 
    } else if (hour >= 20 || hour < 4) {
        timeGreeting = "Good Night";
    } else if (hour >= 4 && hour < 12) {
        timeGreeting = "Good Morning";
    }

    // ৩. রোলের ওপর ভিত্তি করে ডাইনামিক সার্চ প্লেসহোল্ডার টেক্সট
    String searchPlaceholder = "Search tasks, metrics, workspace reports...";
    if (navRole.equalsIgnoreCase("Admin")) {
        searchPlaceholder = "Search employees, system metrics, reports...";
    }
    
    // ডিসপ্লে রোল ট্র্যাকার ম্যাপিং
    String subTitleRole = navRole.equalsIgnoreCase("Admin") ? "SYSTEM DIRECTOR" : "TEAM MEMBER";
%>

<!-- MODERN RESPONSIVE FLEX LAYOUT CONTEXT NAVBAR WRAPPER -->
<header class="w-full bg-[#ffffff] border-b border-slate-200/80 px-4 py-2.5 flex items-center justify-between gap-4 select-none relative z-50 premium-times-layout">
    
    <!-- LEFT UNIT: DYNAMIC ROLE GREETING & LIVE DIGITAL TICKER -->
    <div class="flex items-center gap-3 shrink-0">
        <div class="w-10 h-10 bg-blue-600 flex items-center justify-center rounded-xl text-white font-black text-sm shadow-md shadow-blue-600/10">
            <%= displayRoleName.substring(0, 1).toUpperCase() %>
        </div>
        <div class="flex flex-col text-left">
            <!-- LIVE DYNAMIC GREETING -->
            <h1 class="text-sm sm:text-base font-black text-slate-800 flex items-center gap-1.5 leading-tight">
                <%= timeGreeting %>, <%= displayRoleName %> <span class="text-base sm:text-lg">👋</span>
            </h1>
            <p class="text-[10px] sm:text-xs text-slate-400 font-bold flex items-center gap-1 mt-0.5">
                Here's your operational status for today. 
                <!-- 🚨 LIVE DIGITAL CLOCK TERMINAL BLOCK: Seconds automatically tik-tik korbe -->
                <span id="liveNavbarClock" class="text-emerald-600 bg-emerald-50 px-1.5 py-0.5 rounded font-mono font-bold border border-emerald-100 hidden sm:inline-block">
                    Loading Time...
                </span>
            </p>
        </div>
    </div>

    <!-- CENTER UNIT: DYNAMIC SEARCH BAR -->
    <div class="hidden lg:flex items-center relative w-full max-w-md mx-4">
        <i class="fa-solid fa-magnifying-glass absolute left-3.5 text-slate-400 text-xs"></i>
        <input type="text" placeholder="<%= searchPlaceholder %>" 
               class="w-full h-9 bg-slate-50 border border-slate-200 rounded-xl pl-9 pr-4 text-xs font-medium text-slate-700 placeholder:text-slate-400 focus:outline-none focus:border-amber-500/40 focus:bg-white transition-all">
    </div>

    <!-- RIGHT UNIT: USER LIVE CONFIGURATION PROFILE -->
    <div class="flex items-center gap-2 sm:gap-3 shrink-0 ml-auto">
        
        <button class="w-9 h-9 bg-slate-50 hover:bg-slate-100 border border-slate-200 flex items-center justify-center rounded-xl text-slate-500 relative transition-transform active:scale-95">
            <i class="fa-solid fa-bell text-xs"></i>
            <span class="absolute top-2 right-2.5 w-1.5 h-1.5 bg-rose-500 rounded-full"></span>
        </button>

        <div class="flex items-center gap-2 pl-1.5 border-l border-slate-200/80">
            <img src="<%= navImg %>" alt="Nav Avatar picture tools" 
                 class="w-8 h-8 rounded-full border border-amber-400/30 object-cover shadow-sm">
            
            <div class="hidden md:flex flex-col text-left max-w-[120px]">
                <h4 class="text-xs font-black text-slate-800 truncate leading-tight uppercase tracking-wide"><%= displayName %></h4>
                <p class="text-[9px] font-bold text-slate-400 uppercase tracking-widest mt-0.5 truncate"><%= subTitleRole %></p>
            </div>
        </div>

        <!-- LOGOUT LINK BUTTON CONTAINER -->
        <a href="login.jsp" 
           class="h-9 px-3 rounded-xl bg-gradient-to-r from-rose-50 to-rose-100/60 hover:from-rose-100 hover:to-rose-200/50 border border-rose-200/60 text-rose-600 font-bold text-xs flex items-center justify-center gap-2 shadow-sm transition-all active:scale-95"
           title="Secure Sign Out Session">
            <i class="fa-solid fa-right-from-bracket text-xs"></i>
            <span class="hidden sm:inline">Logout</span>
        </a>

    </div>
</header>

<!-- 🚨 REAL-TIME LIVE CLOCK ENGINE JAVASCRIPT INJECTION 🚨 -->
<script>
    function runLiveNavbarClock() {
        const timeBox = document.getElementById("liveNavbarClock");
        if (!timeBox) return;

        setInterval(() => {
            const now = new Date();
            let hours = now.getHours();
            let minutes = now.getMinutes();
            let seconds = now.getSeconds();
            const ampm = hours >= 12 ? 'PM' : 'AM';

            // Convert to 12-hour format standard cleanly
            hours = hours % 12;
            hours = hours ? hours : 12; 
            
            // Padding configuration tracking leading zero mapping
            hours = hours < 10 ? '0' + hours : hours;
            minutes = minutes < 10 ? '0' + minutes : minutes;
            seconds = seconds < 10 ? '0' + seconds : seconds;

            // Strict rendering matching premium framework UI
            timeBox.textContent = hours + ":" + minutes + ":" + seconds + " " + ampm;
        }, 1000); // 1-second dynamic frequency updater interval loop
    }

    // Initialize clock worker node safely after window thread compilation
    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", runLiveNavbarClock);
    } else {
        runLiveNavbarClock();
    }
</script>