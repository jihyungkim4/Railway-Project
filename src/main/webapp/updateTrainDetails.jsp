<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Train Details</title>
</head>
<body>
<%
    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // Retrieve form data
        String transitLine = request.getParameter("transitline");
        String train = request.getParameter("train");
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        String stops = request.getParameter("stops");
        String stopTimes = request.getParameter("stop_times");
        String departureTime = request.getParameter("departure_time").replace("T", " ");
        String arrivalTime = request.getParameter("arrival_time").replace("T", " ");
        double travelTime = Double.parseDouble(request.getParameter("travel_time"));
        double fare = Double.parseDouble(request.getParameter("fare"));

        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");

        // Update query
        String updateQuery = "UPDATE train_schedules_has SET origin = ?, destination = ?, stops = ?, stop_times = ?, " +
                             "departure_time = ?, arrival_time = ?, travel_time = ?, fare = ? " +
                             "WHERE transitline = ? AND train = ?";
        pstmt = con.prepareStatement(updateQuery);
        pstmt.setString(1, origin);
        pstmt.setString(2, destination);
        pstmt.setString(3, stops);
        pstmt.setString(4, stopTimes);
        pstmt.setString(5, departureTime);
        pstmt.setString(6, arrivalTime);
        pstmt.setDouble(7, travelTime);
        pstmt.setDouble(8, fare);
        pstmt.setString(9, transitLine);
        pstmt.setString(10, train);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<p style='color: green;'>Train details updated successfully!</p>");
        } else {
            out.println("<p style='color: red;'>Failed to update train details. Please try again.</p>");
        }
    } catch (Exception e) {
        out.println("<p style='color: red;'>An error occurred while updating the train details. Please try again later.</p>");
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<a href="editTrainDetails.jsp">Back to Train Details</a>
</body>
</html>
