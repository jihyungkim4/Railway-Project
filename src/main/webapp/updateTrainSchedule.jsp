<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Train Schedule</title>
</head>
<body>
<%
    if (session.getAttribute("username") == null || !"customer_rep".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String transitLine = request.getParameter("transitline");
    String departureTime = request.getParameter("departure_time");
    String origin = request.getParameter("origin");
    String destination = request.getParameter("destination");
    String stops = request.getParameter("stops");
    String stopTimes = request.getParameter("stop_times");
    String travelTime = request.getParameter("travel_time");
    String fareStr = request.getParameter("fare");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "9142203eE!");

        // Update schedule
        String query = "UPDATE train_schedules_has SET origin = ?, destination = ?, stops = ?, stop_times = ?, travel_time = ?, fare = ? WHERE transitline = ? AND departure_time = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, origin);
        ps.setString(2, destination);
        ps.setString(3, stops);
        ps.setString(4, stopTimes);
        ps.setString(5, travelTime);
        ps.setDouble(6, Double.parseDouble(fareStr));
        ps.setString(7, transitLine);
        ps.setString(8, departureTime);

        int rowsUpdated = ps.executeUpdate();

        if (rowsUpdated > 0) {
            out.println("<p style='color: green;'>Schedule updated successfully.</p>");
        } else {
            out.println("<p style='color: red;'>Failed to update schedule. Please try again.</p>");
        }

        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>
<p><a href="searchSchedules.jsp">Back to Schedule Search</a></p>
</body>
</html>
