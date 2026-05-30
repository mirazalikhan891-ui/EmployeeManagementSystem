<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.ems.utils.DBConnection" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) { response.sendRedirect("login.jsp"); return; }

    String name = "N/A", email = "N/A", dept = "N/A", imgPath = "", salary = "0.0", empId = "N/A";
    
    try (Connection con = DBConnection.getConnection()) {
        PreparedStatement ps = con.prepareStatement("SELECT * FROM employees WHERE username=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            dept = rs.getString("department");
            imgPath = rs.getString("image_path");
            salary = rs.getString("salary");
            empId = rs.getString("id");
        }
    } catch (Exception e) { e.printStackTrace(); }

    String displayImg = (imgPath != null && !imgPath.isEmpty()) 
                        ? request.getContextPath() + "/" + imgPath 
                        : "https://ui-avatars.com/api/?name=" + name;
%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        .premium-times-layout { font-family: 'Times New Roman', Times, serif !important; }
        .gold-glow-title { color: #D4AF37; text-shadow: 0 0 10px rgba(212, 175, 55, 0.7); letter-spacing: 0.15em; }
        
        /* 1-side thick and 3-side thin golden border */
        .golden-box-border {
            border-left: 8px solid #D4AF37;
            border-top: 1px solid #D4AF37;
            border-right: 1px solid #D4AF37;
            border-bottom: 1px solid #D4AF37;
            box-shadow: 10px 10px 25px rgba(212, 175, 55, 0.2);
        }
        
        .text-glow { text-shadow: 0 0 5px rgba(255,255,255,0.7); }
    </style>
</head>
<body class="bg-slate-100 premium-times-layout min-h-screen flex items-center justify-center p-6">

    <div class="max-w-[800px] w-full bg-white p-10 golden-box-border rounded-r-xl shadow-2xl">
        <h2 class="text-3xl font-black gold-glow-title uppercase mb-8 text-center text-glow">ACCOUNT OVERVIEW</h2>
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-10 items-center">
            <div class="flex flex-col items-center border-r border-slate-100">
                <img src="<%= displayImg %>" class="w-40 h-40 rounded-full border-4 border-amber-500/30 shadow-xl object-cover mb-4">
                <h3 class="text-xl font-bold text-slate-800 text-glow"><%= name %></h3>
                <p class="text-emerald-700 font-bold text-sm mt-1">ID: EMP-<%= empId %></p>
            </div>

            <div class="space-y-6">
                <div class="grid grid-cols-1 gap-4">
                    <div>
                        <p class="text-[10px] text-slate-400 font-bold uppercase tracking-widest">Email Address</p>
                        <p class="font-bold text-slate-700 text-lg text-glow"><%= email %></p>
                    </div>
                    <div>
                        <p class="text-[10px] text-slate-400 font-bold uppercase tracking-widest">Department</p>
                        <p class="font-bold text-slate-700 text-lg text-glow"><%= dept %></p>
                    </div>
                    <div>
                        <p class="text-[10px] text-slate-400 font-bold uppercase tracking-widest">Salary</p>
                        <p class="font-bold text-emerald-600 text-lg text-glow"><%= salary %></p>
                    </div>
                </div>

                <form action="<%= request.getContextPath() %>/ProfileUploadServlet" method="POST" enctype="multipart/form-data" class="pt-4 border-t border-slate-100">
                    <div class="flex items-center gap-4">
                        <input type="file" name="profileImage" class="flex-1 text-sm text-slate-500" required>
                        <button type="submit" class="px-6 bg-emerald-600 text-white font-black py-2 rounded-lg hover:bg-emerald-700 transition-all uppercase text-xs">
                            Update Photo
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="mt-8 text-center border-t border-slate-100 pt-6">
            <a href="dashboard.jsp" class="px-8 py-3 bg-gradient-to-r from-blue-900 to-blue-700 text-white font-bold uppercase tracking-widest text-xs hover:from-blue-800 hover:to-blue-600 transition-all rounded shadow-lg">
                Dashboard
            </a>
        </div>
    </div>
</body>
</html>