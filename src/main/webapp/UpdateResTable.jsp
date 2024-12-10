<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.utils.ApplicationDB, java.sql.*" %>

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

    String reservationId = request.getParameter("reservation_id");
    String newTransitLine = request.getParameter("transitline");
    String newOrigin = request.getParameter("origin");
    String newDestination = request.getParameter("destination");
    boolean isRoundTrip = "on".equals(request.getParameter("round_trip"));

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
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
</body>
</html>
