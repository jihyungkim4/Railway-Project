<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.pkg.ApplicationDB, java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Reservation</title>
</head>
<body>
<%
    if (session.getAttribute("user") == null || !"customer".equals(session.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }

    String reservationId = request.getParameter("reservation_number");
    String newTransitLine = request.getParameter("transitline");
    String newOrigin = request.getParameter("origin");
    String newDestination = request.getParameter("destination");
    boolean isRoundTrip = "on".equals(request.getParameter("round_trip"));

    if (reservationId == null) {
        out.println("<p>Error: No reservation number provided!</p>");
        return;
    }

    try (Connection con = ApplicationDB.getConnection()) {
        String query = "UPDATE reservations_for_associatedwith_contains SET transitline = ?, origin_station = ?, destination_station = ?, is_round_trip = ? WHERE reservation_number = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, newTransitLine);
            ps.setString(2, newOrigin);
            ps.setString(3, newDestination);
            ps.setBoolean(4, isRoundTrip);
            ps.setInt(5, Integer.parseInt(reservationId));
            ps.executeUpdate();
        }
        out.println("<p>Reservation updated successfully!</p>");
        out.println("<div style='margin-top: 20px;'>");
        out.println("<a href='HandleResTable_Customer.jsp' style='background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; margin-right: 10px;'>Back to Reservations</a>");
        out.println("<a href='customerSuccessPage.jsp' style='background-color: #008CBA; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px;'>Customer Dashboard</a>");
        out.println("</div>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
        out.println("<div style='margin-top: 20px;'>");
        out.println("<a href='HandleResTable_Customer.jsp' style='background-color: #f44336; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px;'>Back to Reservations</a>");
        out.println("</div>");
    }
%>
</body>
</html>
