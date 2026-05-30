<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.ems.utils.DBConnection, com.ems.model.Employee" %>
<%@ page import="com.ems.dao.EmployeeDAO, com.ems.dao.AttendanceDAO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.List" %>
	<% 
    // সেশন চেক এবং রোল ভ্যালিডেশন
    String currentRole = (String) session.getAttribute("role");
    String currentUsername = (String) session.getAttribute("username");
    String empDept = "Not Assigned";
    String empId= "N/A";
    
    if (currentRole == null || currentUsername == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
   
    String profileImg = "";
    String empName = "Unknown";
    Object userObj = session.getAttribute("user");
    
    
    if(userObj != null && userObj instanceof com.ems.model.Employee) {
        com.ems.model.Employee empObj = (com.ems.model.Employee) userObj;
        empName = empObj.getName();
        profileImg = empObj.getImagePath(); 
        empDept = empObj.getDepartment();
        empId = String.valueOf(empObj.getId());
    }
    String displayImg = (profileImg != null && !profileImg.isEmpty()) ? request.getContextPath() + "/" + profileImg : "https://i.pravatar.cc/300?img=12";
    String timeStamp = String.valueOf(System.currentTimeMillis());

   
    

    int totalEmployeesCount = 0;
    int lastMonthTotal = 0; 
    double growthPercent = 0.0;
    
    com.ems.dao.EmployeeDAO countDao = new com.ems.dao.EmployeeDAO();
    
    try {
        java.util.List<com.ems.model.Employee> listForCount = countDao.getAllEmployees();
        if (listForCount != null) { totalEmployeesCount = listForCount.size(); }
        lastMonthTotal = countDao.getLastMonthEmployeeCount();
        if (lastMonthTotal > 0) {
            growthPercent = ((double)(totalEmployeesCount - lastMonthTotal) / lastMonthTotal) * 100;
        } else if (totalEmployeesCount > 0) {
            growthPercent = 100.0;
        }
    } catch(Exception e) { e.printStackTrace(); }
    
    request.setAttribute("LIVE_EMP_COUNT", totalEmployeesCount);
    request.setAttribute("EMP_GROWTH_VAL", String.format("%.1f", growthPercent));
    

    String empRole = (currentRole != null) ? (currentRole.equalsIgnoreCase("Admin") ? "System Director" : "Team Member") : "Team Member";
   
    Integer attendanceEmpId =
    	    (Integer) session.getAttribute("id");

    	String checkInTime = "--";
    	String checkOutTime = "--";

    	if(attendanceEmpId != null){

    	    checkInTime =
    	        AttendanceDAO.getTodayCheckInTime(attendanceEmpId);

    	    checkOutTime =
    	        AttendanceDAO.getTodayCheckOutTime(attendanceEmpId);
    	}
    	boolean attendanceCompleted = !checkOutTime.equals("--");
    	boolean alreadyCheckedIn = !checkOutTime.equals("--");
    	
    	
    	List<Integer> presentDays =
    	AttendanceDAO.getPresentDays(attendanceEmpId);
    	
    	java.time.LocalDate currentDate = java.time.LocalDate.now();

    	int today = currentDate.getDayOfMonth();
    	int currentYear = currentDate.getYear();
    	int currentMonth = currentDate.getMonthValue();

    	java.time.YearMonth ym =
    	        java.time.YearMonth.of(currentYear, currentMonth);

    	int daysInMonth = ym.lengthOfMonth();

    	java.time.LocalDate firstDay =
    	        java.time.LocalDate.of(currentYear, currentMonth, 1);

    	int startDay =
    	        firstDay.getDayOfWeek().getValue() % 7;
    	
%>
<!DOCTYPE html>
<html lang="en" class="w-full overflow-x-hidden">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Enterprise Management System</title>
    
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

    <style>
        /* 🚨 TIMES NEW ROMAN FONT LOOK HELD INTACT ALWAYS */
        .premium-times-layout {
            font-family: 'Times New Roman', Times, serif !important;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        
        body {
            background-color: #f1f5f9 !important;
            margin: 0 !important;
            padding: 0 !important;
            width: 100% !important;
            max-width: 100% !important;
            overflow-x: hidden !important;
        }

        /* Metric Tile Cards styling controls with dynamic gold neon shadows */
        .top-square-card {
            background-color: #ffffff !important;
            border-left: 4px solid #D4AF37 !important; 
            border-top: 1px solid rgba(223, 186, 74, 0.35) !important;
            border-right: 1px solid rgba(223, 186, 74, 0.35) !important;
            border-bottom: 1px solid rgba(223, 186, 74, 0.35) !important;
            border-radius: 0px !important; 
            box-shadow: 0 0 32px rgba(223, 186, 74, 0.28), 0 6px 14px rgba(223, 186, 74, 0.12) !important;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .top-square-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 40px rgba(223, 186, 74, 0.42), 0 10px 20px rgba(15, 23, 42, 0.15) !important;
        }

        .lower-rounded-card {
            background-color: #ffffff !important;
            border-left: 4px solid #D4AF37 !important;
            border-top: 1px solid rgba(223, 186, 74, 0.35) !important;
            border-right: 1px solid rgba(223, 186, 74, 0.35) !important;
            border-bottom: 1px solid rgba(223, 186, 74, 0.35) !important;
            border-radius: 1rem !important; 
            box-shadow: 0 0 30px rgba(223, 186, 74, 0.22), 0 6px 12px rgba(223, 186, 74, 0.08) !important;
        }

        /* Marquee horizontal stream logic layout lines */
        .sleek-inline-ticker {
            width: 100%;
            overflow: hidden;
            white-space: nowrap;
            display: flex;
            align-items: center;
            padding: 6px 10px;
        }
        .inline-marquee-track {
            display: flex;
            gap: 80px;
            animation: inline-scroll 32s linear infinite;
        }
        @keyframes inline-scroll {
            0% { transform: translateX(15%); }
            100% { transform: translateX(-100%); }
        }
    </style>
</head>
<body class="bg-[#f1f5f9] text-slate-800 min-h-screen overflow-x-hidden antialiased premium-times-layout">

<div class="w-full relative z-10 overflow-x-hidden">
   
    <%@ include file="components/navbar.jsp" %>

    <main class="w-full max-w-[1700px] mx-auto p-4 sm:p-6 space-y-6">
        
        <% if (currentRole.equalsIgnoreCase("Admin")) { %>
            <jsp:include page="admin-dashboard.jsp" />
        <% } else { %>
            
            <div class="grid grid-cols-12 gap-5 items-start w-full">
                
                <div class="col-span-12 lg:col-span-3 lower-rounded-card p-5 flex flex-col justify-between lg:self-stretch">
                    <div class="flex justify-between items-center w-full">
                        <span class="text-xs font-bold text-slate-400 uppercase tracking-wider">My Profile</span>
                        <span class="px-3 py-1 rounded-full bg-emerald-50 border border-emerald-200 text-emerald-600 text-xs font-bold animate-pulse">
                            Active Status
                        </span>
                    </div>
                    
                    <div class="flex flex-col items-center my-4 w-full">
                        <img src="<%=displayImg %>?v=<%= timeStamp %>" alt="Profile avatar framework image" class="w-24 h-24 rounded-full border-4 border-amber-400/20 shadow-sm object-cover">
                        <h2 class="text-2xl font-black text-slate-800 mt-4 text-center "><%= empName %></h2>
                        <p class="text-slate-500 font-bold text-sm mt-0.5"><%= empRole %></p>
                        <div class="w-full h-[1px] bg-slate-100 my-4"></div>
                        <div class="space-y-1.5 text-center text-sm font-bold text-slate-500 w-full">
                            <p class="flex items-center justify-center gap-1"><i class="fa-solid fa-briefcase text-[#D4AF37]"></i><%= empDept %></p>
                            <p class="font-mono text-slate-400 text-xs">ID: EMP-<%=empId %></p>
                        </div>
                    </div>

                  <div class="mt-4">
    <a href="view-profile.jsp" class="block w-full bg-gradient-to-r from-cyan-600 to-amber-500 text-white font-bold py-3 rounded-xl hover:from-cyan-700 hover:to-amber-600
     transition-all duration-300 text-center shadow-lg">
        View Full Profile 
    </a>
</div>
                </div>
						<div class="col-span-12 lg:col-span-9 grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-5">
            
       <!-- TODAY ATTENDANCE কার্ড -->
<div class="top-square-card p-4 sm:p-5 flex flex-col justify-between aspect-square w-full">
    <div class="flex justify-between items-start w-full">
        <div class="text-left">
            <p class="text-[11px] sm:text-xs font-bold text-slate-400 uppercase tracking-wider">Today Attendance</p>
            <p class="text-slate-400 text-[9px] sm:text-[10px] font-semibold mt-1">
                <% if (alreadyCheckedIn) { %> Checked In <% } else { %> Ready for Check In <% } %>
            </p>
        </div>
        <div class="w-8 h-8 sm:w-10 sm:h-10 bg-emerald-50 flex items-center justify-center rounded-lg border border-emerald-100 shrink-0">
            <i class="fa-solid fa-circle-check text-emerald-500 text-sm sm:text-base"></i>
        </div>
    </div>

    <div class="my-1 text-left">
   <%
String displayTime = attendanceCompleted ? checkOutTime : checkInTime;
String sessionLabel = "";

if(displayTime != null && !displayTime.equals("--")){

    int displayhour = Integer.parseInt(displayTime.split(":")[0]);

    sessionLabel = (displayhour < 12) ? "AM Session" : "PM Session";

    if(displayhour > 12){
    	displayhour = displayhour - 12;
    }

    if(displayhour == 0){
    	displayhour = 12;
    }

    displayTime = String.format(
        "%02d: %s",
        displayhour,
        displayTime.substring(3,8)
        
    );
}
%>
        <h2 class="text-2xl sm:text-3xl font-black text-slate-800 tracking-tight"> <%=displayTime %></h2>
        <p class="text-[10px] font-bold text-emerald-600 bg-emerald-50 inline-block px-1.5 py-0.5 mt-0.5"><%=sessionLabel%></p>
    </div>






<% if(attendanceCompleted){ %>

    <div class="text-center text-emerald-600 font-semibold mt-4">

        Attendance Completed

    </div>

<% } else { %>

    <form action="AttendanceServlet" method="POST">

        <% if(checkInTime.equals("--")){ %>

            <input type="hidden"
                   name="action"
                   value="checkin">

            <button type="submit"
                class="w-full h-8 rounded-none bg-emerald-600 text-white">

                Check In

            </button>

        <% } else { %>

            <input type="hidden"
                   name="action"
                   value="checkout">

            <button type="submit"
                class="w-full h-8 rounded-none bg-rose-50 text-rose-600 border border-rose-200">

                Check Out

            </button>

        <% } %>

    </form>

<% } %>
</div>
						
                    <div class="top-square-card p-4 sm:p-5 flex flex-col justify-between aspect-square w-full">
                        <div class="flex justify-between items-start w-full">
                            <div class="text-left">
                                <p class="text-[11px] sm:text-xs font-bold text-slate-400 uppercase tracking-wider">Leave Balance</p>
                                <p class="text-slate-400 text-[9px] sm:text-[10px] font-semibold mt-1">Total: 20 Days</p>
                            </div>
                            <div class="w-8 h-8 sm:w-10 sm:h-10 bg-amber-50 flex items-center justify-center rounded-lg border border-amber-100 shrink-0">
                                <i class="fa-solid fa-user-clock text-amber-500 text-sm sm:text-base"></i>
                            </div>
                        </div>

                        <div class="my-1 text-left">
                            <h2 class="text-2xl sm:text-3xl font-black text-slate-800 tracking-tight">12 Days</h2>
                            <p class="text-[10px] font-bold text-amber-600 bg-amber-50 inline-block px-1.5 py-0.5 mt-0.5">Remaining</p>
                        </div>

                        <button class="w-full h-8 rounded-none bg-slate-50 border border-slate-200 text-slate-700 font-bold text-xs transition-transform active:scale-95 hover:bg-slate-100">
                            View Details
                        </button>
                    </div>

                    <div class="top-square-card p-4 sm:p-5 flex flex-col justify-between aspect-square w-full">
                        <div class="flex justify-between items-start w-full">
                            <div class="text-left">
                                <p class="text-[11px] sm:text-xs font-bold text-slate-400 uppercase tracking-wider">Pending Tasks</p>
                                <p class="text-slate-400 text-[9px] sm:text-[10px] font-semibold mt-1">Active Stack</p>
                            </div>
                            <div class="w-8 h-8 sm:w-10 sm:h-10 bg-blue-50 flex items-center justify-center rounded-lg border border-blue-100 shrink-0">
                                <i class="fa-solid fa-list-check text-blue-500 text-sm sm:text-base"></i>
                            </div>
                        </div>

                        <div class="my-1 text-left">
                            <h2 class="text-2xl sm:text-3xl font-black text-slate-800 tracking-tight">8 Tasks</h2>
                            <p class="text-[10px] font-bold text-blue-600 bg-blue-50 inline-block px-1.5 py-0.5 mt-0.5">Priority</p>
                        </div>

                        <button class="w-full h-8 rounded-none bg-slate-800 text-white font-bold text-xs transition-transform active:scale-95 hover:opacity-90">
                            View Tasks
                        </button>
                    </div>

                    <div class="top-square-card p-4 sm:p-5 flex flex-col justify-between aspect-square w-full">
                        <div class="flex justify-between items-start w-full">
                            <div class="text-left">
                                <p class="text-[11px] sm:text-xs font-bold text-slate-400 uppercase tracking-wider">Salary Status</p>
                                <h4 class="text-sm font-black text-emerald-600 mt-0.5">Disbursed</h4>
                            </div>
                            <div class="w-8 h-8 sm:w-10 sm:h-10 bg-purple-50 flex items-center justify-center rounded-lg border border-purple-100 shrink-0">
                                <i class="fa-solid fa-wallet text-purple-500 text-sm sm:text-base"></i>
                            </div>
                        </div>

                        <div class="my-1 text-left">
                            <h3 class="text-base font-bold text-slate-800">May Session</h3>
                            <p class="text-[10px] font-medium text-slate-400 mt-0.5 flex items-center gap-1">
                                <span class="w-1.5 h-1.5 bg-emerald-500 rounded-full inline-block"></span> Credited
                            </p>
                        </div>

                        <button class="w-full h-8 rounded-none bg-amber-50 border border-amber-200 text-amber-700 font-bold text-xs transition-transform active:scale-95 hover:bg-amber-100/60">
                            Payslip
                        </button>
                    </div>

                </div>

            </div>

            <div class="sleek-inline-ticker flex items-center justify-end my-2 w-full">
                <div class="marquee-window w-full">
                    <div class="inline-marquee-track text-xs sm:text-[14px] font-bold tracking-wide text-slate-600">
                        <span class="text-amber-600"><i class="fa-solid fa-circle text-[5px] mr-1.5 inline-block align-middle"></i> [Live Init] Online Exam Panel Portal System Setup</span>
                        <span class="text-blue-600"><i class="fa-solid fa-circle text-[5px] mr-1.5 inline-block align-middle"></i> [Upcoming Deployment] Custom Student Admission Portal Dashboard V2</span>
                        <span class="text-purple-600"><i class="fa-solid fa-circle text-[5px] mr-1.5 inline-block align-middle"></i> [Active Pipeline] MERN Stack E-Commerce Network Integration</span>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-12 gap-5 w-full">
                
                <div class="lg:col-span-4 lower-rounded-card p-5 flex flex-col justify-between">
                    <div class="flex justify-between items-center border-b border-slate-100 pb-3 w-full">
                        <h2 class="text-base font-bold text-slate-800">My Attendance Track</h2>
                        <button class="text-amber-700 font-bold text-xs hover:underline">View Calendar →</button>
                    </div>

                    <div class="flex justify-between items-center my-4 w-full">
                        <button class="p-1.5 hover:bg-slate-100 rounded-lg text-slate-400"><i class="fa-solid fa-chevron-left text-xs"></i></button>
                        <h3 class="text-sm font-bold text-slate-700">Current Session: <%= currentDate.getMonth() %> <%=currentYear %></h3>
                        <button class="p-1.5 hover:bg-slate-100 rounded-lg text-slate-400"><i class="fa-solid fa-chevron-right text-xs"></i></button>
                    </div>
					  <div class="grid grid-cols-7 gap-2 text-center text-xs font-bold text-slate-500 mb-2">
					    <div>Sun</div>
					    <div>Mon</div>
					    <div>Tue</div>
					    <div>Wed</div>
					    <div>Thu</div>
					    <div>Fri</div>
					    <div>Sat</div>
					</div>
						<div class="grid grid-cols-7 gap-2 text-center items-center px-1 w-full">
			          		<%
								for(int i=0; i<startDay; i++){
								%>
								    <div></div>
								<%
								}
								%>
							
							<%
							for(int day=1; day<=daysInMonth; day++) {
								java.time.LocalDate date = java.time.LocalDate.of(currentYear, currentMonth, day);
								
								boolean isSunday = date.getDayOfWeek() == java.time.DayOfWeek.SUNDAY;
							
							    boolean present =
							    presentDays.contains(day);
							
							    String color ;
							     if (present) {
							    	 color ="bg-green-500 text-white";
							     }
							     
							     else if(isSunday){
							    	 color = "bg-amber-400 text-black";
							     }
							     else if(day>today){
							    	 color = "bg-slate-300 text-black";
							    	 
							     }
							     else{
							    	 color ="bg-red-500 text-white";
							     }
							     %>
							  
							
							<div class="w-9 h-9 rounded-xl flex items-center justify-center <%= color %>">
							    <%= day %>
							</div>
							
							<%
							}
							%>
							
							</div>
							
			 <p class="text-[11px] text-slate-400 text-center mt-2 w-full">Continuous attendance compliance rating metric optimized</p>
                </div>

                <div class="lg:col-span-4 lower-rounded-card p-5 w-full">
                    <div class="flex justify-between items-center border-b border-slate-100 pb-3 mb-4 w-full">
                        <h2 class="text-base font-bold text-slate-800">My System Tasks</h2>
                        <button class="text-amber-700 font-bold text-xs hover:underline">View All Tasks →</button>
                    </div>

                    <div class="space-y-3.5 w-full">
                        <div>
                            <div class="flex justify-between text-xs font-bold text-slate-600 w-full">
                                <span>Dashboard UI Optimization</span>
                                <span class="text-amber-600 font-mono">75%</span>
                            </div>
                            <div class="w-full h-2 bg-slate-100 rounded-full mt-1.5 overflow-hidden">
                                <div class="w-[75%] h-full bg-gradient-to-r from-amber-400 to-amber-500 rounded-full"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between text-xs font-bold text-slate-600 w-full">
                                <span>API Integration Layer</span>
                                <span class="text-purple-600 font-mono">50%</span>
                            </div>
                            <div class="w-full h-2 bg-slate-100 rounded-full mt-1.5 overflow-hidden">
                                <div class="w-[50%] h-full bg-gradient-to-r from-purple-500 to-indigo-500 rounded-full"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between text-xs font-bold text-slate-600 w-full">
                                <span>Bug Fixing Assembly</span>
                                <span class="text-cyan-600 font-mono">30%</span>
                            </div>
                            <div class="w-full h-2 bg-slate-100 rounded-full mt-1.5 overflow-hidden">
                                <div class="w-[30%] h-full bg-gradient-to-r from-cyan-400 to-blue-500 rounded-full"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="lg:col-span-4 lower-rounded-card p-5 w-full">
                    <div class="flex justify-between items-center border-b border-slate-100 pb-3 mb-2 w-full">
                        <h2 class="text-base font-bold text-slate-800">Leave Balance Summary</h2>
                        <button class="text-amber-700 font-bold text-xs hover:underline">Full Analytics</button>
                    </div>
                    <div id="leaveDonutChart" class="w-full flex items-center justify-center mx-auto"></div>
                </div>

            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-5 w-full">
                
                <div class="lg:col-span-3 lower-rounded-card p-5 flex flex-col justify-between w-full">
                    <div class="border-b border-slate-100 pb-3 mb-3 w-full">
                        <h2 class="text-base font-bold text-slate-800">Upcoming System Events</h2>
                    </div>
                    <div class="space-y-3.5 w-full">
                        <div class="flex gap-3 items-center w-full">
                            <div class="w-10 h-10 bg-amber-50 rounded-xl border border-amber-100 flex items-center justify-center shrink-0"><i class="fa-solid fa-video text-amber-600 text-sm"></i></div>
                            <div class="text-left">
                                <h4 class="text-xs font-bold text-slate-800">Project Strategy Assembly</h4>
                                <p class="text-[11px] font-semibold text-slate-400 mt-0.5">Today, 10:00 AM</p>
                            </div>
                        </div>
                        <div class="flex gap-3 items-center w-full">
                            <div class="w-10 h-10 bg-blue-50 rounded-xl border border-blue-100 flex items-center justify-center shrink-0"><i class="fa-solid fa-briefcase text-blue-500 text-sm"></i></div>
                            <div class="text-left">
                                <h4 class="text-xs font-bold text-slate-800">UI Architecture Evaluation</h4>
                                <p class="text-[11px] font-semibold text-slate-400 mt-0.5">Tomorrow, 11:00 AM</p>
                            </div>
                        </div>
                        <div class="flex gap-3 items-center w-full">
                            <div class="w-10 h-10 bg-rose-50 rounded-xl border border-rose-100 flex items-center justify-center shrink-0"><i class="fa-solid fa-users text-rose-500 text-sm"></i></div>
                            <div class="text-left">
                                <h4 class="text-xs font-bold text-slate-800">Weekly Performance Sprint</h4>
                                <p class="text-[11px] font-semibold text-slate-400 mt-0.5">May 28, 10:00 AM</p>
                            </div>
                        </div>
                    </div>
                    <div class="pt-2"></div>
                </div>

                <div class="lg:col-span-3 lower-rounded-card p-5 flex flex-col justify-between w-full">
                    <div class="border-b border-slate-100 pb-3 w-full">
                        <h2 class="text-base font-bold text-slate-800">My Latest Payslip</h2>
                    </div>
                    <div class="bg-slate-50 border border-slate-200/60 rounded-xl p-4 my-3 text-center w-full">
                        <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">Salary Disbursed (May)</p>
                        <h2 class="text-3xl font-black text-slate-800 tracking-tight mt-1">$3,250</h2>
                        <span class="inline-block mt-2 px-2 py-0.5 bg-emerald-50 text-emerald-600 border border-emerald-200 text-[10px] font-bold rounded-md">Paid Track verified</span>
                    </div>
                    <button class="w-full h-11 rounded-xl bg-slate-800 hover:bg-slate-900 text-white font-bold text-xs shadow-sm flex items-center justify-center gap-2">
                        <i class="fa-solid fa-file-arrow-down"></i> Download Document PDF
                    </button>
                </div>

                <div class="lg:col-span-3 lower-rounded-card p-5 flex flex-col justify-between w-full">
                    <div class="border-b border-slate-100 pb-3 mb-3 w-full">
                        <h2 class="text-base font-bold text-slate-800">My Corporate Documents</h2>
                    </div>
                    <div class="space-y-3 w-full">
                        <div class="flex justify-between items-center bg-slate-50 p-2 border border-slate-100 rounded-xl w-full">
                            <div class="flex items-center gap-2.5">
                                <div class="w-9 h-9 bg-rose-50 rounded-lg flex items-center justify-center text-rose-500 border border-rose-100"><i class="fa-solid fa-file-pdf text-sm"></i></div>
                                <div class="text-left">
                                    <h4 class="text-xs font-bold text-slate-700">Offer Letter Block</h4>
                                    <p class="text-[10px] font-mono text-slate-400">PDF Storage</p>
                                </div>
                            </div>
                            <i class="fa-solid fa-ellipsis-vertical text-slate-400 cursor-pointer p-1"></i>
                        </div>
                        <div class="flex justify-between items-center bg-slate-50 p-2 border border-slate-100 rounded-xl w-full">
                            <div class="flex items-center gap-2.5">
                                <div class="w-9 h-9 bg-blue-50 rounded-lg flex items-center justify-center text-blue-500 border border-blue-100"><i class="fa-solid fa-id-card text-sm"></i></div>
                                <div class="text-left">
                                    <h4 class="text-xs font-bold text-slate-700">Identity Proof Vault</h4>
                                    <p class="text-[10px] font-mono text-slate-400">JPG Verified</p>
                                </div>
                            </div>
                            <i class="fa-solid fa-ellipsis-vertical text-slate-400 cursor-pointer p-1"></i>
                        </div>
                        <div class="flex justify-between items-center bg-slate-50 p-2 border border-slate-100 rounded-xl w-full">
                            <div class="flex items-center gap-2.5">
                                <div class="w-9 h-9 bg-amber-50 rounded-lg flex items-center justify-center text-[#D4AF37] border border-amber-100"><i class="fa-solid fa-file text-sm"></i></div>
                                <div class="text-left">
                                    <h4 class="text-xs font-bold text-slate-700">Curriculum Vitae</h4>
                                    <p class="text-[10px] font-mono text-slate-400">PDF Updated</p>
                                </div>
                            </div>
                            <i class="fa-solid fa-ellipsis-vertical text-slate-400 cursor-pointer p-1"></i>
                        </div>
                    </div>
                </div>

                <div class="lg:col-span-3 rounded-2xl p-5 bg-gradient-to-br from-slate-900 to-slate-950 shadow-xl flex flex-col justify-between text-white relative overflow-hidden w-full">
                    <div class="text-left w-full">
                        <div class="flex items-center gap-2 w-full">
                            <div class="w-2 h-2 bg-amber-500 rounded-full animate-ping"></div>
                            <h2 class="text-[11px] font-bold tracking-wider uppercase text-slate-400">HR Copilot Terminal</h2>
                        </div>
                        <p class="mt-3 text-lg font-bold text-white">Hi, <%= empName %> 👋</p>
                        <p class="text-[11px] text-slate-400 font-normal mt-0.5">Need help with system logs or leaves?</p>
                        <div class="grid grid-cols-2 gap-2 mt-4 w-full">
                            <button class="py-2 px-2.5 rounded-xl bg-white/5 border border-white/10 text-[11px] font-bold hover:bg-white/10 transition-colors text-left truncate">Apply System Leave</button>
                            <button class="py-2 px-2.5 rounded-xl bg-white/5 border border-white/10 text-[11px] font-bold hover:bg-white/10 transition-colors text-left truncate">Attendance Logs</button>
                        </div>
                    </div>
                    <div class="mt-4 relative w-full">
                        <input type="text" placeholder="Query corporate database..." class="w-full h-10 rounded-xl bg-white/10 border border-white/5 px-3 pr-9 outline-none text-xs text-white placeholder:text-slate-500 focus:border-slate-500 transition-colors">
                        <i class="fa-solid fa-paper-plane absolute right-3 top-1/2 -translate-y-1/2 text-xs text-slate-400 cursor-pointer hover:text-white transition-colors"></i>
                    </div>
                </div>

            </div>

        <% } %>

    </main>
</div>

<script>
// Leave Summary Donut Graph Settings Model
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
        itemMargin: { horizontal: 8, vertical: 4 }
    },
    dataLabels: { enabled: false },
    plotOptions: {
        pie: {
            donut: {
                size: '72%',
                labels: {
                    show: true, total: { show: true, label: 'Remaining', fontSize: '11px', color: '#64748b', formatter: function () { return "12 Days"; } }
                }
            }
        }
    }
};

document.addEventListener("DOMContentLoaded", function() {
    var targetContainer = document.querySelector("#leaveDonutChart");
    if(targetContainer) {
        targetContainer.innerHTML = "";
        new ApexCharts(targetContainer, leaveDonutOptions).render();
    }
});
</script>
</body>
</html>