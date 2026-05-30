package com.ems.controller; // তোমার প্যাকেজ স্ট্রাকচার অনুযায়ী (ফাইল ছবিতে controller দেখাচ্ছে)

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.ems.dao.AttendanceDAO;

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
  
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("action received");

        HttpSession session = request.getSession();

        Integer empId =
            (Integer) session.getAttribute("id");

        String action =
            request.getParameter("action");

        if (empId != null) {

            // CHECK OUT
            if ("checkout".equals(action)) {

                boolean done =
                    AttendanceDAO.markCheckout(empId);

                if (done) {

                    response.sendRedirect(
                      
                         "dashboard.jsp?status=checkedout"
                    );

                } else {

                    System.out.println("Checkout Failed");

                    response.sendRedirect(
                        
                     "dashboard.jsp?status=failed"
                    );
                }

            }

            // CHECK IN
            else {

                if (!AttendanceDAO.isCheckedIn(empId)) {

                    AttendanceDAO.markAttendance(empId);

                }

                response.sendRedirect(
                    
                     "dashboard.jsp?status=checkedin"
                );
            }

        }

        else {

            response.sendRedirect("login.jsp");
        }
    }
}