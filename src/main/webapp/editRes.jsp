<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.pkg.ApplicationDB, java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Reservation</title>
</head>
<body>
<%
    if (session.getAttribute("user") == null || !"customer".equals(session.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }

    String reservationNumber = request.getParameter("reservation_number");

    try (Connection con = ApplicationDB.getConnection()) {
        String query = "SELECT * FROM reservations_for_associatedwith_contains WHERE reservation_number = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, Integer.parseInt(reservationNumber));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
%>
    <form method="post" action="UpdateResTable.jsp">
        <input type="hidden" name="reservation_number" value="<%= reservationNumber %>">
        Transit Line: <input type="text" name="transitline" value="<%= rs.getString("transitline") %>"><br>
        Origin: <input type="text" name="origin" value="<%= rs.getString("origin_station") %>"><br>
        Destination: <input type="text" name="destination" value="<%= rs.getString("destination_station") %>"><br>
        Round Trip: <input type="checkbox" name="round_trip" <%= rs.getBoolean("is_round_trip") ? "checked" : "" %>><br>
        <button type="submit">Update Reservation</button>
    </form>
<%
                } else {
                    out.println("<p>Reservation not found!</p>");
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
</body>
</html>
