<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cancel Reservation</title>
</head>
<body>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String reservationNumberStr = request.getParameter("reservation_number");

    if (reservationNumberStr == null || reservationNumberStr.isEmpty()) {
        out.println("<p style='color: red;'>Error: No reservation number provided.</p>");
        return;
    }

    int reservationNumber = Integer.parseInt(reservationNumberStr);

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "9142203eE!");

        String updateQuery = "UPDATE reservations_for_associatedwith_contains SET status = 'cancelled' WHERE reservation_number = ?";
        PreparedStatement ps = con.prepareStatement(updateQuery);
        ps.setInt(1, reservationNumber);
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<p style='color: green;'>Reservation #" + reservationNumber + " has been successfully canceled.</p>");
        } else {
            out.println("<p style='color: red;'>Error: Reservation not found or already canceled.</p>");
        }

        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>

<p><a href="PastCurrentReservations.jsp">View Past and Current Reservations</a></p>
<p><a href="HandleResTable_Customer.jsp">Back to My Reservations</a></p>
</body>
</html>
