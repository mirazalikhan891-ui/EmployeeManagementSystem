<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Fetch user context inside scope securely 
    String empName = (session.getAttribute("username") != null) ? (String)session.getAttribute("username") : "Employee User";
    String empRole = (session.getAttribute("role") != null) ? (String)session.getAttribute("role") : "Team Member";
%>
<style>
    /* Global Times New Roman Configuration matching Admin Core Layout */
    .premium-times-layout {
        font-family: 'Times New Roman', Times, serif !important;
    }

    /* Style for Top Status Cards: Square with Left Heavy Border & BIG AREA GOLD RADIATION */
    .top-square-card {
        background-color: #ffffff !important;
        border-left: 4px solid #D4AF37 !important; /* Perfect High-Contrast Metallic Gold Base */
        border-top: 1px solid rgba(212, 175, 55, 0.4) !important;
        border-right: 1px solid rgba(212, 175, 55, 0.4) !important;
        border-bottom: 1px solid rgba(212, 175, 55, 0.4) !important;
        border-radius: 0px !important; /* Square Corners */
        box-shadow: 0 0 32px rgba(212, 175, 55, 0.28), 0 6px 14px rgba(212, 175, 55, 0.12) !important;
        transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
    }
    .top-square-card:hover {
        transform: translateY(-2px);
        border-top-color: #1e293b !important;
        border-right-color: #1e293b !important;
        border-bottom-color: #1e293b !important;
        box-shadow: 0 0 40px rgba(212, 175, 55, 0.42), 0 10px 20px rgba(15, 23, 42, 0.12) !important;
    }

    /* Style for Main Lower Cards: Premium Rounded with Left Gold Border & BIG AREA GEOMETRIC SHADOW */
    .lower-rounded-card {
        background-color: #ffffff !important;
        border-left: 4px solid #D4AF37 !important;
        border-top: 1px solid rgba(212, 175, 55, 0.4) !important;
        border-right: 1px solid rgba(212, 175, 55, 0.4) !important;
        border-bottom: 1px solid rgba(212, 175, 55, 0.4) !important;
        border-radius: 1rem !important; /* Premium rounded edge layout */
        box-shadow: 0 0 30px rgba(212, 175, 55, 0.22), 0 6px 12px rgba(212, 175, 55, 0.08) !important;
        transition: all 0.25s ease-in-out;
    }
    .lower-rounded-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 0 38px rgba(212, 175, 55, 0.38), 0 10px 20px rgba(15, 23, 42, 0.1) !important;
    }

    /* Action triggers button layout properties */
    .quick-action-btn {
        border-radius: 0.75rem !important;
        transition: all 0.2s ease-in-out;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .quick-action-btn:active {
        transform: scale(0.98);
    }
    
    /* Compact Square Action Button for Small Cards */
    .compact-square-btn {
        border-radius: 0px !important;
        transition: all 0.2s ease-in-out;
    }

    /* 🚨 LIVE HORIZONTAL SCROLL TICKER WINDOW PROPERTIES */
    .horizontal-ticker-container {
        background: #ffffff !important;
        border: 1px solid rgba(212, 175, 55, 0.4) !important;
        box-shadow: 0 0 25px rgba(212, 175, 55, 0.15) !important;
        display: flex;
        align-items: center;
        overflow: hidden;
        height: 44px;
        width: 100%;
    }
    .ticker-header-tag {
        background: linear-gradient(135deg, #1e293b, #0f172a);
        border-right: 3px solid #D4AF37;
        color: #DFBA4A;
        height: 100%;
        display: flex;
        align-items: center;
        padding: 0 16px;
        font-size: 11px;
        font-weight: 900;
        letter-spacing: 1.5px;
        white-space: nowrap;
        z-index: 10;
    }
    .marquee-window {
        display: flex;
        width: 100%;
        overflow: hidden;
    }
    .marquee-track {
        display: flex;
        gap: 60px;
        white-space: nowrap;
        animation: linear-scroll-stream 25s linear infinite;
    }
    .marquee-track:hover {
        animation-play-state: paused; /* User control check on mouse hover */
    }
    @keyframes linear-scroll-stream {
        0% { transform: translateX(100%); }
        100% { transform: translateX(-100%); }
    }
</style>

<div class="premium-times-layout space-y-6">

    <!-- MAIN GRID ARCHITECTURE FOR UPPER SECTIONS -->
    <div class="grid grid-cols-12 gap-5 items-start">
        
        <!-- 1. MY PROFILE CARD (Stays tall naturally) -->
        <div class="col-span-12 lg:col-span-3 lower-rounded-card p-5 flex flex-col justify-between self-stretch">
            <div class="flex justify-between items-center">
                <span class="text-xs font-bold text-slate-400 uppercase tracking-wider">My Profile</span>
                <span class="px-3 py-1 rounded-full bg-emerald-50 border border-emerald-200 text-emerald-600 text-xs font-bold animate-pulse">
                    Online Status
                </span>
            </div>
            
            <div class="flex flex-col items-center my-4">
                <img src="https://i.pravatar.cc/300?img=12" alt="Avatar profile" class="w-24 h-24 rounded-full border-4 border-amber-400/30 shadow-sm object-cover">
                <h2 class="text-2xl font-black text-slate-800 mt-4 text-center"><%= empName %></h2>
                <p class="text-slate-500 font-semibold text-xs mt-0.5"><%= empRole %></p>
                <div class="w-full h-[1px] bg-slate-100 my-4"></div>
                <div class="space-y-1.5 text-center text-xs font-bold text-slate-500">
                    <p><i class="fa-solid fa-briefcase mr-2 text-[#D4AF37]"></i>Core Workspace Department</p>
                    <p class="font-mono text-slate-400">ID: EMP-2026-SYS-NODE</p>
                </div>
            </div>
					<a href="view-profile.jsp" class="w-full h-11 rounded-xl bg-slate-800 text-white font-bold text-xs flex items-center justify-center transition-transform active:scale-95 hover:bg-slate-900">
    View Full Profile 
</a>
        </div>

        <!-- 2. COMPACT SQUARE STATS CARDS BLOCK -->
        <div class="col-span-12 lg:col-span-9 grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-5">
            
            <!-- CARD A: TODAY ATTENDANCE -->
            <div class="top-square-card p-5 flex flex-col justify-between aspect-square">
                <div class="flex justify-between items-start">
                    <div>
                        <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">Today Attendance</p>
                        <p class="text-emerald-500 text-[11px] font-bold mt-1 tracking-wide"><i class="fa-solid fa-bolt mr-0.5"></i> Checked In</p>
                    </div>
                    <div class="w-10 h-10 bg-emerald-50 flex items-center justify-center border border-emerald-100">
                        <i class="fa-solid fa-circle-check text-emerald-500 text-base"></i>
                    </div>
                </div>
                
                <div class="my-2">
                    <h2 class="text-3xl font-black text-slate-800 tracking-tight">09:15</h2>
                    <p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mt-0.5">AM Session</p>
                </div>

                <button class="w-full h-9 compact-square-btn bg-rose-50 border border-rose-100 text-rose-600 font-bold text-xs hover:bg-rose-100/70">
                    Check Out
                </button>
            </div>

            <!-- CARD B: LEAVE BALANCE -->
            <div class="top-square-card p-5 flex flex-col justify-between aspect-square">
                <div class="flex justify-between items-start">
                    <div>
                        <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">Leave Balance</p>
                        <p class="text-slate-400 text-[10px] font-semibold mt-1">Total Allocated: 20 Days</p>
                    </div>
                    <div class="w-10 h-10 bg-amber-50 flex items-center justify-center border border-amber-100">
                        <i class="fa-solid fa-user-clock text-amber-500 text-base"></i>
                    </div>
                </div>

                <div class="my-2">
                    <h2 class="text-3xl font-black text-slate-800 tracking-tight">12 Days</h2>
                    <p class="text-[10px] font-bold text-amber-600 bg-amber-50 inline-block px-1.5 py-0.5 mt-0.5">Remaining</p>
                </div>

                <button class="w-full h-9 compact-square-btn bg-slate-50 border border-slate-200 text-slate-700 font-bold text-xs hover:bg-slate-100">
                    View Details
                </button>
            </div>

            <!-- CARD C: PENDING TASKS -->
            <div class="top-square-card p-5 flex flex-col justify-between aspect-square">
                <div class="flex justify-between items-start">
                    <div>
                        <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">Pending Tasks</p>
                        <p class="text-slate-400 text-[10px] font-semibold mt-1">Current Active Stack</p>
                    </div>
                    <div class="w-10 h-10 bg-blue-50 flex items-center justify-center border border-blue-100">
                        <i class="fa-solid fa-list-check text-blue-500 text-base"></i>
                    </div>
                </div>

                <div class="my-2">
                    <h2 class="text-3xl font-black text-slate-800 tracking-tight">8 Tasks</h2>
                    <p class="text-[10px] font-bold text-blue-600 bg-blue-50 inline-block px-1.5 py-0.5 mt-0.5">Action Priority</p>
                </div>

                <button class="w-full h-9 compact-square-btn bg-slate-800 text-white font-bold text-xs shadow-sm hover:opacity-90">
                    View Tasks
                </button>
            </div>

            <!-- CARD D: SALARY STATUS -->
            <div class="top-square-card p-5 flex flex-col justify-between aspect-square">
                <div class="flex justify-between items-start">
                    <div>
                        <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">Salary Status</p>
                        <h4 class="text-sm font-black text-emerald-600 mt-0.5">Disbursed</h4>
                    </div>
                    <div class="w-10 h-10 bg-purple-50 flex items-center justify-center border border-purple-100">
                        <i class="fa-solid fa-wallet text-purple-500 text-base"></i>
                    </div>
                </div>

                <div class="my-1">
                    <h3 class="text-base font-bold text-slate-800">May Session</h3>
                    <p class="text-[10px] font-medium text-slate-400 mt-0.5 flex items-center gap-1">
                        <span class="w-1.5 h-1.5 bg-emerald-500 rounded-full inline-block"></span> Credited to bank
                    </p>
                </div>

                <button class="w-full h-9 compact-square-btn bg-amber-50 border border-amber-200 text-amber-700 font-bold text-xs hover:bg-amber-100/70">
                    View Payslip
                </button>
            </div>

        </div>

    </div>

    <!-- 🚨 CRITICAL VISUAL FIX: NEW HORIZONTAL LIVE UPCOMING PROJECT STREAM TICKER BANNER BAR -->
    <!-- This bar completely utilizes the huge empty space between rows seen in image ae122c62-a187-4cd7-b428-96e854b846cc -->
    <div class="horizontal-ticker-container rounded-xl">
        <div class="ticker-header-tag">
            <i class="fa-solid fa-satellite-dish mr-1.5 animate-pulse"></i> LIVE PROJECT STREAMS
        </div>
        <div class="marquee-window">
            <div class="marquee-track text-xs font-bold text-slate-700">
                <span class="flex items-center gap-1.5 text-amber-600"><i class="fa-solid fa-circle text-[6px] animate-ping"></i> [Live Init] Online Exam Panel Portal System Setup</span>
                <span class="flex items-center gap-1.5 text-blue-600"><i class="fa-solid fa-square text-[6px]"></i> [Upcoming Deployment] Custom Student Admission Portal Dashboard V2</span>
                <span class="flex items-center gap-1.5 text-purple-600"><i class="fa-solid fa-circle-nodes text-[6px]"></i> [Active Pipeline] MERN Stack E-Commerce Network Integration</span>
                <span class="flex items-center gap-1.5 text-emerald-600"><i class="fa-solid fa-shield-halved text-[6px]"></i> [Core Infrastructure] Secure Multi-Role Authentication Database</span>
            </div>
        </div>
    </div>

    <!-- SECOND BLOCK LAYER: ATTENDANCE TRACK, PIPELINE PROGRESSION, ANALYTICAL CHART -->
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-5">

        <!-- ATTENDANCE SUMMARY STATUS LOG -->
        <div class="lg:col-span-4 lower-rounded-card p-5 flex flex-col justify-between">
            <div class="flex justify-between items-center border-b border-slate-100 pb-3">
                <h2 class="text-base font-bold text-slate-800">My Attendance Track</h2>
                <button class="text-[#D4AF37] font-bold text-xs hover:underline">View Calendar →</button>
            </div>

            <div class="flex justify-between items-center my-4">
                <button class="p-1.5 hover:bg-slate-100 rounded-lg text-slate-400 hover:text-slate-700 transition-colors"><i class="fa-solid fa-chevron-left text-xs"></i></button>
                <h3 class="text-sm font-bold text-slate-700">Current Session: May 2026</h3>
                <button class="p-1.5 hover:bg-slate-100 rounded-lg text-slate-400 hover:text-slate-700 transition-colors"><i class="fa-solid fa-chevron-right text-xs"></i></button>
            </div>

            <div class="grid grid-cols-7 gap-2 text-center items-center justify-center py-2">
                <div class="w-10 h-10 rounded-xl bg-emerald-50 border border-emerald-200 flex items-center justify-center mx-auto"><i class="fa-solid fa-check text-emerald-500 text-sm"></i></div>
                <div class="w-10 h-10 rounded-xl bg-emerald-50 border border-emerald-200 flex items-center justify-center mx-auto"><i class="fa-solid fa-check text-emerald-500 text-sm"></i></div>
                <div class="w-10 h-10 rounded-xl bg-emerald-50 border border-emerald-200 flex items-center justify-center mx-auto"><i class="fa-solid fa-check text-emerald-500 text-sm"></i></div>
                <div class="w-10 h-10 rounded-xl bg-emerald-50 border border-emerald-200 flex items-center justify-center mx-auto"><i class="fa-solid fa-check text-emerald-500 text-sm"></i></div>
                <div class="w-10 h-10 rounded-xl bg-amber-600 text-white text-xs font-bold flex items-center justify-center mx-auto shadow-sm">25</div>
                <div class="w-10 h-10 rounded-xl bg-amber-50 border border-amber-200 flex items-center justify-center mx-auto"><i class="fa-solid fa-clock text-amber-500 text-sm"></i></div>
                <div class="w-10 h-10 rounded-xl bg-slate-50 border border-slate-200 text-slate-300 flex items-center justify-center mx-auto text-xs font-bold">-</div>
            </div>
            <p class="text-[11px] text-slate-400 font-semibold text-center mt-2">Continuous attendance compliance rating metric optimized</p>
        </div>

        <!-- ACTIVE APPLICATION PIPELINE STATUSES -->
        <div class="lg:col-span-4 lower-rounded-card p-5">
            <div class="flex justify-between items-center border-b border-slate-100 pb-3 mb-4">
                <h2 class="text-base font-bold text-slate-800">My System Tasks</h2>
                <button class="text-[#D4AF37] font-bold text-xs hover:underline">View All Tasks →</button>
            </div>

            <div class="space-y-3.5">
                <div>
                    <div class="flex justify-between text-xs font-bold text-slate-600">
                        <span>Dashboard UI Optimization</span>
                        <span class="text-amber-600 font-mono">75%</span>
                    </div>
                    <div class="w-full h-2 bg-slate-100 rounded-full mt-1.5 overflow-hidden">
                        <div class="w-[75%] h-full bg-gradient-to-r from-amber-400 to-amber-500 rounded-full"></div>
                    </div>
                </div>
                <div>
                    <div class="flex justify-between text-xs font-bold text-slate-600">
                        <span>API Integration Layer</span>
                        <span class="text-purple-600 font-mono">50%</span>
                    </div>
                    <div class="w-full h-2 bg-slate-100 rounded-full mt-1.5 overflow-hidden">
                        <div class="w-[50%] h-full bg-gradient-to-r from-purple-500 to-indigo-500 rounded-full"></div>
                    </div>
                </div>
                <div>
                    <div class="flex justify-between text-xs font-bold text-slate-600">
                        <span>Bug Fixing Assembly</span>
                        <span class="text-cyan-600 font-mono">30%</span>
                    </div>
                    <div class="w-full h-2 bg-slate-100 rounded-full mt-1.5 overflow-hidden">
                        <div class="w-[30%] h-full bg-gradient-to-r from-cyan-400 to-blue-500 rounded-full"></div>
                    </div>
                </div>
                <div>
                    <div class="flex justify-between text-xs font-bold text-slate-600">
                        <span>User Testing Validation</span>
                        <span class="text-emerald-600 font-mono">100%</span>
                    </div>
                    <div class="w-full h-2 bg-slate-100 rounded-full mt-1.5 overflow-hidden">
                        <div class="w-full h-full bg-gradient-to-r from-emerald-400 to-teal-500 rounded-full"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ANALYTICAL DONUT CHART CONTAINER -->
        <div class="lg:col-span-4 lower-rounded-card p-5">
            <div class="flex justify-between items-center border-b border-slate-100 pb-3 mb-2">
                <h2 class="text-base font-bold text-slate-800">Leave Balance Summary</h2>
                <button class="text-[#D4AF37] font-bold text-xs hover:underline">Full Analytics</button>
            </div>
            <div id="leaveDonutChart" class="w-full flex items-center justify-center"></div>
        </div>

    </div>

    <!-- THIRD ROW LAYER: EVENTS, DOCUMENT REPOSITORY, AI COGNITIVE Assistant -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-5">

        <!-- WORKSPACE UPCOMING MEETINGS/EVENTS -->
        <div class="lg:col-span-3 lower-rounded-card p-5 flex flex-col justify-between">
            <div class="border-b border-slate-100 pb-3 mb-3">
                <h2 class="text-base font-bold text-slate-800">Upcoming System Events</h2>
            </div>
            
            <div class="space-y-3.5">
                <div class="flex gap-3 items-center">
                    <div class="w-10 h-10 bg-amber-50 rounded-xl border border-amber-100 flex items-center justify-center shrink-0"><i class="fa-solid fa-video text-amber-600 text-sm"></i></div>
                    <div>
                        <h4 class="text-xs font-bold text-slate-800">Project Strategy Assembly</h4>
                        <p class="text-[11px] font-semibold text-slate-400 mt-0.5">Today, 10:00 AM</p>
                    </div>
                </div>
                <div class="flex gap-3 items-center">
                    <div class="w-10 h-10 bg-blue-50 rounded-xl border border-blue-100 flex items-center justify-center shrink-0"><i class="fa-solid fa-briefcase text-blue-500 text-sm"></i></div>
                    <div>
                        <h4 class="text-xs font-bold text-slate-800">UI Architecture Evaluation</h4>
                        <p class="text-[11px] font-semibold text-slate-400 mt-0.5">Tomorrow, 11:00 AM</p>
                    </div>
                </div>
                <div class="flex gap-3 items-center">
                    <div class="w-10 h-10 bg-rose-50 rounded-xl border border-rose-100 flex items-center justify-center shrink-0"><i class="fa-solid fa-users text-rose-500 text-sm"></i></div>
                    <div>
                        <h4 class="text-xs font-bold text-slate-800">Weekly Performance Sprint</h4>
                        <p class="text-[11px] font-semibold text-slate-400 mt-0.5">May 28, 10:00 AM</p>
                    </div>
                </div>
            </div>
            <div class="pt-2"></div>
        </div>

        <!-- CORPORATE PAYSLIP QUICK DOWNLOAD DISPLAY -->
        <div class="lg:col-span-3 lower-rounded-card p-5 flex flex-col justify-between">
            <div class="border-b border-slate-100 pb-3">
                <h2 class="text-base font-bold text-slate-800">My Latest Payslip</h2>
            </div>

            <div class="bg-slate-50 border border-slate-200/60 rounded-xl p-4 my-3 text-center">
                <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">Salary Disbursed (May)</p>
                <h2 class="text-3xl font-black text-slate-800 tracking-tight mt-1">$3,250</h2>
                <span class="inline-block mt-2 px-2 py-0.5 bg-emerald-50 text-emerald-600 border border-emerald-200 text-[10px] font-bold rounded-md">Paid Track verified</span>
            </div>

            <button class="w-full h-11 quick-action-btn bg-slate-800 hover:bg-slate-900 text-white font-bold text-xs shadow-sm flex items-center justify-center gap-2">
                <i class="fa-solid fa-file-arrow-down"></i> Download Document PDF
            </button>
        </div>

        <!-- SYSTEM DOCUMENT VAULT VERIFICATION -->
        <div class="lg:col-span-3 lower-rounded-card p-5 flex flex-col justify-between">
            <div class="border-b border-slate-100 pb-3 mb-3">
                <h2 class="text-base font-bold text-slate-800">My Corporate Documents</h2>
            </div>

            <div class="space-y-3">
                <div class="flex justify-between items-center bg-slate-50 p-2 border border-slate-100 rounded-xl">
                    <div class="flex items-center gap-2.5">
                        <div class="w-9 h-9 bg-rose-50 rounded-lg flex items-center justify-center text-rose-500 border border-rose-100"><i class="fa-solid fa-file-pdf text-sm"></i></div>
                        <div>
                            <h4 class="text-xs font-bold text-slate-700">Offer Letter Block</h4>
                            <p class="text-[10px] font-mono text-slate-400">PDF Storage</p>
                        </div>
                    </div>
                    <i class="fa-solid fa-ellipsis-vertical text-slate-400 cursor-pointer p-1"></i>
                </div>

                <div class="flex justify-between items-center bg-slate-50 p-2 border border-slate-100 rounded-xl">
                    <div class="flex items-center gap-2.5">
                        <div class="w-9 h-9 bg-blue-50 rounded-lg flex items-center justify-center text-blue-500 border border-blue-100"><i class="fa-solid fa-id-card text-sm"></i></div>
                        <div>
                            <h4 class="text-xs font-bold text-slate-700">Identity Proof Vault</h4>
                            <p class="text-[10px] font-mono text-slate-400">JPG Verified</p>
                        </div>
                    </div>
                    <i class="fa-solid fa-ellipsis-vertical text-slate-400 cursor-pointer p-1"></i>
                </div>

                <div class="flex justify-between items-center bg-slate-50 p-2 border border-slate-100 rounded-xl">
                    <div class="flex items-center gap-2.5">
                        <div class="w-9 h-9 bg-amber-50 rounded-lg flex items-center justify-center text-[#D4AF37] border border-amber-100"><i class="fa-solid fa-file text-sm"></i></div>
                        <div>
                            <h4 class="text-xs font-bold text-slate-700">Curriculum Vitae Repository</h4>
                            <p class="text-[10px] font-mono text-slate-400">PDF Updated</p>
                        </div>
                    </div>
                    <i class="fa-solid fa-ellipsis-vertical text-slate-400 cursor-pointer p-1"></i>
                </div>
            </div>
        </div>

        <!-- CORPORATE AI ASSISTANT TERMINAL -->
        <div class="lg:col-span-3 rounded-2xl p-5 bg-gradient-to-br from-slate-900 to-slate-950 shadow-xl flex flex-col justify-between text-white relative overflow-hidden">
            <div>
                <div class="flex items-center gap-2">
                    <div class="w-2 h-2 bg-amber-500 rounded-full animate-ping"></div>
                    <h2 class="text-[11px] font-bold tracking-wider uppercase text-slate-400">HR Copilot Terminal</h2>
                </div>
                <p class="mt-3 text-lg font-bold text-white">Hi, <%= empName %> 👋</p>
                <p class="text-[11px] text-slate-400 font-normal mt-0.5">Need help with salary logs or leaves?</p>
                
                <div class="grid grid-cols-2 gap-2 mt-4">
                    <button class="py-2 px-2.5 rounded-xl bg-white/5 border border-white/10 text-[11px] font-bold hover:bg-white/10 transition-colors text-left truncate">
                        Apply System Leave
                    </button>
                    <button class="py-2 px-2.5 rounded-xl bg-white/5 border border-white/10 text-[11px] font-bold hover:bg-white/10 transition-colors text-left truncate">
                        Attendance Logs
                    </button>
                </div>
            </div>

            <div class="mt-4 relative">
                <input type="text" placeholder="Query corporate database..." class="w-full h-10 rounded-xl bg-white/10 border border-white/5 px-3 pr-9 outline-none text-xs text-white placeholder:text-slate-500 focus:border-slate-500 transition-colors">
                <i class="fa-solid fa-paper-plane absolute right-3 top-1/2 -translate-y-1/2 text-xs text-slate-400 cursor-pointer hover:text-white transition-colors"></i>
            </div>
        </div>

    </div>

</div>

<!-- SCRIPT INITIALIZATION BLOCK FOR APEX CHARTS -->
<script>
var leaveDonutOptions = {
    chart: {
        type: 'donut',
        height: 180,
        fontFamily: 'Times New Roman, Times, serif',
        background: 'transparent'
    },
    series: [8, 6, 6],
    labels: ['Casual Leave', 'Sick Leave', 'Paid Leave'],
    colors: ['#D4AF37', '#3b82f6', '#10b981'], 
    stroke: { show: false },
    legend: {
        position: 'bottom',
        fontSize: '11px',
        fontWeight: 600,
        labels: { colors: '#475569' },
        itemMargin: { horizontal: 8, vertical: 4 },
        markers: { radius: 4 }
    },
    dataLabels: {
        enabled: false
    },
    plotOptions: {
        pie: {
            donut: {
                size: '70%',
                labels: {
                    show: true,
                    total: {
                        show: true,
                        label: 'Remaining',
                        fontSize: '11px',
                        color: '#64748b',
                        formatter: function (w) {
                            return "12 Days";
                        }
                    }
                }
            }
        }
    }
};

var targetContainer = document.querySelector("#leaveDonutChart");
if(targetContainer) {
    targetContainer.innerHTML = "";
    new ApexCharts(targetContainer, leaveDonutOptions).render();
}
</script>