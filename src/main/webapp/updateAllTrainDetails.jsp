<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Train Schedules</title>
</head>
<body>
<%
    // Validate session to ensure user is logged in
    if (session.getAttribute("username") == null || !"customer_rep".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String sortBy = request.getParameter("sort_by");
    if (sortBy == null || sortBy.isEmpty()) {
        sortBy = "departure_time"; // Default sorting by departure time
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");

    try {
        // Loop through submitted data and update the database
        String updateQuery = "UPDATE train_schedules_has SET origin = ?, destination = ?, stops = ?, stop_times = ?, " +
                             "departure_time = ?, arrival_time = ?, travel_time = ?, fare = ? " +
                             "WHERE transitline = ? AND train = ?";
        PreparedStatement pstmt = con.prepareStatement(updateQuery);

        Map<String, String[]> parameterMap = request.getParameterMap();
        int rowsUpdated = 0;

        for (int i = 0; parameterMap.containsKey("schedules[" + i + "][transitline]"); i++) {
            // Retrieve form parameters for each schedule
            String transitline = request.getParameter("schedules[" + i + "][transitline]");
            String train = request.getParameter("schedules[" + i + "][train]");
            String origin = request.getParameter("schedules[" + i + "][origin]");
            String destination = request.getParameter("schedules[" + i + "][destination]");
            String stops = request.getParameter("schedules[" + i + "][stops]");
            String stopTimes = request.getParameter("schedules[" + i + "][stop_times]");
            String departureTime = request.getParameter("schedules[" + i + "][departure_time]").replace("T", " ");
            String arrivalTime = request.getParameter("schedules[" + i + "][arrival_time]").replace("T", " ");
            double travelTime = Double.parseDouble(request.getParameter("schedules[" + i + "][travel_time]"));
            double fare = Double.parseDouble(request.getParameter("schedules[" + i + "][fare]"));

            // Set parameters for the query
            pstmt.setString(1, origin);
            pstmt.setString(2, destination);
            pstmt.setString(3, stops);
            pstmt.setString(4, stopTimes);
            pstmt.setString(5, departureTime);
            pstmt.setString(6, arrivalTime);
            pstmt.setDouble(7, travelTime);
            pstmt.setDouble(8, fare);
            pstmt.setString(9, transitline);
            pstmt.setString(10, train);

            // Execute the update
            rowsUpdated += pstmt.executeUpdate();
        }

        // Display success message
        out.println("<p style='color: green;'>" + rowsUpdated + " rows updated successfully!</p>");
    } catch (Exception e) {
        out.println("<p style='color: red;'>An error occurred while updating train schedules: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        // Close the connection
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
<a href="editTrainSchedule.jsp">Back to Train Schedules</a>
</body>
</html>
