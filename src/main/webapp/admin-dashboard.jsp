<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    /* Global Times New Roman Configuration */
    .premium-times-layout {
        font-family: 'Times New Roman', Times, serif !important;
    }

    /* Style for Top 6 Status Cards: Sharp Square with Left Heavy Border & Neon Glow */
    .top-square-card {
        background-color: #ffffff !important;
        border-left: 4px solid #06b6d4 !important;
        border-top: 1px solid rgba(6, 182, 212, 0.35) !important;
        border-right: 1px solid rgba(6, 182, 212, 0.35) !important;
        border-bottom: 1px solid rgba(6, 182, 212, 0.35) !important;
        border-radius: 0px !important; /* স্কয়ার কোণা */
        box-shadow: 0 0 15px rgba(6, 182, 212, 0.12), 0 4px 6px rgba(6, 182, 212, 0.04) !important;
        transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        /* ক্লিক ফাংশন রিমুভ করায় কার্সার পয়েন্টার বাদ দেওয়া হলো */
    }
    .top-square-card:hover {
        transform: translateY(-2px);
        border-top-color: #1e293b !important;
        border-right-color: #1e293b !important;
        border-bottom-color: #1e293b !important;
        box-shadow: 0 0 20px rgba(6, 182, 212, 0.22), 0 8px 16px rgba(15, 23, 42, 0.08) !important;
    }

    /* Style for Main Lower Cards: Premium Rounded with Cyan borders */
    .lower-rounded-card {
        background-color: #ffffff !important;
        border-left: 4px solid #06b6d4 !important;
        border-top: 1px solid rgba(6, 182, 212, 0.35) !important;
        border-right: 1px solid rgba(6, 182, 212, 0.35) !important;
        border-bottom: 1px solid rgba(6, 182, 212, 0.35) !important;
        border-radius: 1rem !important; /* মডার্ন রাউন্ডেড কোণা */
        box-shadow: 0 0 15px rgba(6, 182, 212, 0.12), 0 4px 6px rgba(6, 182, 212, 0.04) !important;
    }

    /* Sharp Square Action buttons style */
    .quick-action-btn {
        border-radius: 0px !important;
        transition: all 0.2s ease-in-out;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .quick-action-btn:active {
        transform: scale(0.99);
    }
</style>

<div class="premium-times-layout space-y-6">

    <!-- Six Metric Cards Row - Click actions completely removed, now static dynamic views -->
    <div class="grid grid-cols-2 xl:grid-cols-6 gap-5">
        
        <!-- Total Employees - Pure Dynamic Counter view only -->
        <div class="top-square-card p-5">
            <div class="flex justify-between items-start">
                <div>
                    <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">Total Employees</p>
                   <h2 class="text-3xl font-black text-slate-800 mt-2"><%= request.getAttribute("LIVE_EMP_COUNT") !=null ? request.getAttribute("LIVE_EMP_COUNT").toString() : "0" %></h2>
                </div>
                <div class="w-11 h-11 bg-purple-50 flex items-center justify-center shrink-0">
                    <svg class="w-6 h-6 text-purple-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                    </svg>
                </div>
            </div>
            <p class="mt-4 text-xs font-semibold text-slate-400">
    <span class="<%= Double.parseDouble((String)request.getAttribute("EMP_GROWTH_VAL")) >= 0 ? "text-emerald-500" : "text-rose-500" %> font-medium">
        <%= Double.parseDouble((String)request.getAttribute("EMP_GROWTH_VAL")) >= 0 ? "↑" : "↓" %> 
        <%= request.getAttribute("EMP_GROWTH_VAL") %>%
    </span> 
    from last month
</p>
        </div>

        <!-- Present Today -->
        <div class="top-square-card p-5">
            <div class="flex justify-between items-start">
                <div>
                    <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">Present Today</p>
                    <h2 class="text-3xl font-black text-slate-800 mt-2">987</h2>
                </div>
                <div class="w-11 h-11 bg-emerald-50 flex items-center justify-center shrink-0">
                    <svg class="w-6 h-6 text-emerald-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                </div>
            </div>
            <p class="mt-4 text-xs font-semibold text-emerald-600">
                ↑ 8.4% <span class="text-slate-400 font-medium">from yesterday</span>
            </p>
        </div>

        <!-- Absent Employees -->
        <div class="top-square-card p-5">
            <div class="flex justify-between items-start">
                <div>
                    <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">Absent Today</p>
                    <h2 class="text-3xl font-black text-slate-800 mt-2">261</h2>
                </div>
                <div class="w-11 h-11 bg-rose-50 flex items-center justify-center shrink-0">
                    <svg class="w-6 h-6 text-rose-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                </div>
            </div>
            <p class="mt-4 text-xs font-semibold text-rose-600">
                ↓ 4.2% <span class="text-slate-400 font-medium">from yesterday</span>
            </p>
        </div>

        <!-- Pending Leaves -->
        <div class="top-square-card p-5">
            <div class="flex justify-between items-start">
                <div>
                    <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">Pending Leaves</p>
                    <h2 class="text-3xl font-black text-slate-800 mt-2">18</h2>
                </div>
                <div class="w-11 h-11 bg-amber-50 flex items-center justify-center shrink-0">
                    <svg class="w-6 h-6 text-amber-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                    </svg>
                </div>
            </div>
            <p class="mt-4 text-xs font-semibold text-cyan-600">
                ↑ 3.1% <span class="text-slate-400 font-medium">vs target</span>
            </p>
        </div>

        <!-- New Joiners -->
        <div class="top-square-card p-5">
            <div class="flex justify-between items-start">
                <div>
                    <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">New Joiners</p>
                    <h2 class="text-3xl font-black text-slate-800 mt-2">32</h2>
                </div>
                <div class="w-11 h-11 bg-sky-50 flex items-center justify-center shrink-0">
                    <svg class="w-6 h-6 text-sky-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
                    </svg>
                </div>
            </div>
            <p class="mt-4 text-xs font-semibold text-indigo-600">
                16.7% <span class="text-slate-400 font-medium">this month</span>
            </p>
        </div>

        <!-- Monthly Salary -->
        <div class="top-square-card p-5">
            <div class="flex justify-between items-start">
                <div>
                    <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">Monthly Payroll</p>
                    <h2 class="text-3xl font-black text-slate-800 mt-2">$245K</h2>
                </div>
                <div class="w-11 h-11 bg-teal-50 flex items-center justify-center shrink-0">
                    <svg class="w-6 h-6 text-teal-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                </div>
            </div>
            <p class="mt-4 text-xs font-semibold text-emerald-600">
                ↑ 7.8% <span class="text-slate-400 font-medium">allocated</span>
            </p>
        </div>

    </div>

    <!-- Analytics Chart & Quick Actions Grid -->
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
        
        <!-- Attendance Chart Block -->
        <div class="lg:col-span-8 lower-rounded-card p-6">
            <div class="flex justify-between items-center mb-4">
                <div>
                    <h2 class="text-xl font-bold text-slate-900 tracking-wide">Attendance Metrics Overview</h2>
                    <p class="text-xs text-slate-500 font-medium">Weekly statistical database monitoring</p>
                </div>
                <select class="text-xs font-bold text-slate-600 border border-slate-200 bg-slate-50 px-3 py-2 rounded-xl focus:outline-none">
                    <option>This Operational Month</option>
                    <option>Previous Quarter</option>
                </select>
            </div>
            <div id="attendanceChart" class="w-full"></div>
        </div>

        <!-- Quick Actions Panel: Added the new custom directed href node -->
        <div class="lg:col-span-4 lower-rounded-card p-6">
            <h2 class="text-base font-bold text-slate-800 mb-1">Quick Action Blocks</h2>
            <p class="text-xs text-slate-400 font-medium mb-5">Instant macro database processes</p>
            
            <div class="space-y-3">
                <a href="add-employee.jsp" class="w-full h-12 quick-action-btn bg-gradient-to-r from-purple-500 toindigo-500 text-white
                 font-bold text-sm shadow-sm transition-transform active:scale-95 flex items-center justify-center decoration-none">
                    Add Employee
                </a>
                <button class="w-full h-12 quick-action-btn bg-gradient-to-r from-cyan-500 to-blue-500 text-white font-bold text-sm shadow-sm">
                    Create Project
                </button>
                <button class="w-full h-12 quick-action-btn bg-gradient-to-r from-green-500 to-emerald-500 text-white font-bold text-sm shadow-sm">
                    Generate Salary
                </button>
                <button class="w-full h-12 quick-action-btn bg-gradient-to-r from-orange-500 to-yellow-500 text-white font-bold text-sm shadow-sm">
                    Leave Request
                </button>
                
                <!-- NEW EXCLUSIVE DESK ACTION BUTTON: Redirects to dedicated employee details page -->
                <!-- Replace 'employee-details.jsp' with your preferred target code destination -->
               <!-- NEW EXCLUSIVE DESK ACTION BUTTON: Redirects to dedicated employee details page -->
				<a href="employee-details.jsp" class="w-full h-12 quick-action-btn bg-gradient-to-r from-slate-600/70 via-slate-400/30 to-transparent text-cyan-500 font-bold text-sm shadow-sm transition-transform active:scale-95 flex items-center justify-center decoration-none">
    				Employee Details Page
					</a>
            </div>
        </div>

    </div>

    <!-- Calendar, Activity and AI Copilot Row -->
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
        
        <!-- Operational Calendar -->
        <div class="lg:col-span-4 lower-rounded-card p-6">
            <div class="flex justify-between items-center mb-5">
                <h2 class="text-base font-bold text-slate-800">Operational Calendar</h2>
                <span class="text-xs font-bold text-slate-600 bg-slate-100 border border-slate-200 px-2.5 py-1 rounded-lg">May 2026</span>
            </div>
            
            <div class="grid grid-cols-7 gap-1.5 text-center">
                <span class="text-[11px] font-bold text-slate-400 uppercase py-1">Su</span>
                <span class="text-[11px] font-bold text-slate-400 uppercase py-1">Mo</span>
                <span class="text-[11px] font-bold text-slate-400 uppercase py-1">Tu</span>
                <span class="text-[11px] font-bold text-slate-400 uppercase py-1">We</span>
                <span class="text-[11px] font-bold text-slate-400 uppercase py-1">Th</span>
                <span class="text-[11px] font-bold text-slate-400 uppercase py-1">Fr</span>
                <span class="text-[11px] font-bold text-slate-400 uppercase py-1">Sa</span>

                <% for(int i=1; i<=12; i++) { 
                    if(i == 6) { %>
                        <div class="bg-indigo-600 text-white text-xs font-bold h-9 w-9 rounded-xl flex items-center justify-center mx-auto shadow-md relative">
                            <%= i %>
                        </div>
                    <% } else { %>
                        <button class="text-xs font-semibold text-slate-600 hover:bg-slate-100 h-9 w-9 rounded-xl flex items-center justify-center mx-auto transition-colors">
                            <%= i %>
                        </button>
                    <% }
                } %>
            </div>
        </div>

        <!-- Live Activity Logger -->
        <div class="lg:col-span-4 lower-rounded-card p-6">
            <h2 class="text-base font-bold text-slate-800 mb-1">Live Activity Stream</h2>
            <p class="text-xs text-slate-400 font-medium mb-4">Real-time system logs</p>
            
            <div class="space-y-3">
                <div class="p-3 rounded-xl bg-slate-50 border border-slate-200 flex gap-3 items-start">
                    <span class="w-2 h-2 bg-amber-500 rounded-full mt-1.5 shrink-0"></span>
                    <div>
                        <p class="text-xs font-semibold text-slate-700">Leave request submitted by Ayesha Khan</p>
                        <span class="text-[10px] text-slate-400 font-medium">12 mins ago</span>
                    </div>
                </div>
                <div class="p-3 rounded-xl bg-slate-50 border border-slate-200 flex gap-3 items-start">
                    <span class="w-2 h-2 bg-emerald-500 rounded-full mt-1.5 shrink-0"></span>
                    <div>
                        <p class="text-xs font-semibold text-slate-700">Salary transaction finalized for May Session</p>
                        <span class="text-[10px] text-slate-400 font-medium">1 hour ago</span>
                    </div>
                </div>
                <div class="p-3 rounded-xl bg-slate-50 border border-slate-200 flex gap-3 items-start">
                    <span class="w-2 h-2 bg-cyan-500 rounded-full mt-1.5 shrink-0"></span>
                    <div>
                        <p class="text-xs font-semibold text-slate-700">Project sync assembly schedule set at 3:00 PM</p>
                        <span class="text-[10px] text-slate-400 font-medium">3 hours ago</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Corporate AI Assistant Terminal -->
        <div class="lg:col-span-4 rounded-2xl p-6 bg-gradient-to-br from-slate-900 to-slate-950 shadow-xl flex flex-col justify-between text-white relative overflow-hidden">
            <div>
                <div class="flex items-center gap-2">
                    <div class="w-2 h-2 bg-indigo-400 rounded-full animate-ping"></div>
                    <h2 class="text-sm font-bold tracking-wider uppercase text-slate-400">Enterprise AI Copilot</h2>
                </div>
                <p class="mt-2 text-base font-semibold text-white">Hello System Executive,</p>
                <p class="text-xs text-slate-400 font-normal mt-0.5">How can I optimize your workflow today?</p>
                
                <div class="grid grid-cols-2 gap-2 mt-4">
                    <button class="py-2 px-3 rounded-lg bg-white/5 border border-white/10 text-xs font-semibold hover:bg-white/10 transition-colors text-left flex items-center justify-between">
                        <span>Summarize Logs</span> <i class="fa-solid fa-sparkles text-[10px] text-slate-400"></i>
                    </button>
                    <button class="py-2 px-3 rounded-lg bg-white/5 border border-white/10 text-xs font-semibold hover:bg-white/10 transition-colors text-left flex items-center justify-between">
                        <span>Leave Report</span> <i class="fa-solid fa-chart-pie text-[10px] text-slate-400"></i>
                    </button>
                </div>
            </div>

            <div class="mt-4 relative">
                <input 
                    type="text" 
                    placeholder="Query system database using AI..." 
                    class="w-full h-10 rounded-xl bg-white/10 border border-white/5 px-4 pr-10 outline-none text-xs text-white placeholder:text-slate-500 focus:border-slate-500 transition-colors">
                <i class="fa-solid fa-paper-plane absolute right-3 top-1/2 -translate-y-1/2 text-xs text-slate-400 cursor-pointer hover:text-white transition-colors"></i>
            </div>
        </div>

    </div>
</div>

<script>
// ApexCharts Engine Mounting Layout
var options = {
    chart: {
        type: 'area',
        height: 280,
        toolbar: { show: false },
        fontFamily: 'Times New Roman, Times, serif',
        background: '#ffffff'
    },
    series: [
        { name: 'Present', data: [200, 700, 650, 900, 720, 950, 780] },
        { name: 'Absent', data: [100, 300, 250, 400, 350, 420, 300] }
    ],
    colors: ['#06b6d4', '#f43f5e'], 
    stroke: { curve: 'smooth', width: 3 },
    fill: {
        type: 'gradient',
        gradient: { shadeIntensity: 1, opacityFrom: 0.15, opacityTo: 0.01, stops: [0, 90, 100] }
    },
    grid: { borderColor: '#e2e8f0' },
    xaxis: {
        categories: ['1 May', '8 May', '15 May', '22 May', '29 May'],
        labels: { style: { colors: '#334155', fontWeight: 600, fontSize: '13px' } },
        axisBorder: { show: false },
        axisTicks: { show: false }
    },
    yaxis: {
        labels: { style: { colors: '#334155', fontWeight: 600, fontSize: '13px' } }
    },
    legend: {
        position: 'top',
        horizontalAlign: 'right',
        labels: { colors: '#1e293b' }
    }
};

var chartElement = document.querySelector("#attendanceChart");
if(chartElement) {
    chartElement.innerHTML = "";
    new ApexCharts(chartElement, options).render();
}
</script>