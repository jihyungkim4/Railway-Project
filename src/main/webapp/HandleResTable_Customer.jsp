<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage My Reservations</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        a {
            text-decoration: none;
            color: blue;
        }
        a:hover {
            color: darkblue;
        }
    </style>
</head>
<body>
<%
    // Validate session to ensure user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String email = null;

    try {
        // Load JDBC Driver and establish a connection
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");

        // Fetch the email address of the logged-in user
        String emailLookupQuery = "SELECT email_address FROM customer WHERE username = ?";
        PreparedStatement emailLookupPs = con.prepareStatement(emailLookupQuery);
        emailLookupPs.setString(1, username);
        ResultSet emailRs = emailLookupPs.executeQuery();
        if (emailRs.next()) {
            email = emailRs.getString("email_address");
        } else {
            out.println("<p style='color: red;'>Error: Username not found in the customer table.</p>");
            return;
        }
        emailRs.close();
        emailLookupPs.close();

        // Query for active reservations only
        String query = "SELECT reservation_number, transitline, origin_station, destination_station, total_fare FROM reservations_for_associatedwith_contains WHERE email_address = ? AND status = 'active'";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (!rs.isBeforeFirst()) {
            out.println("<p style='text-align:center; color:red;'>No active reservations found.</p>");
        } else {
            out.println("<h2 style='text-align:center;'>Manage My Reservations</h2>");
            out.println("<table>");
            out.println("<tr><th>Reservation Number</th><th>Transit Line</th><th>Origin</th><th>Destination</th><th>Fare</th><th>Actions</th></tr>");
            while (rs.next()) {
                int reservationNumber = rs.getInt("reservation_number");
                out.println("<tr>");
                out.println("<td>" + reservationNumber + "</td>");
                out.println("<td>" + rs.getString("transitline") + "</td>");
                out.println("<td>" + rs.getString("origin_station") + "</td>");
                out.println("<td>" + rs.getString("destination_station") + "</td>");
                out.println("<td>$" + rs.getDouble("total_fare") + "</td>");
                out.println("<td>");
                out.println("<a href='editRes.jsp?reservation_number=" + reservationNumber + "'>Edit</a> | ");
                out.println("<a href='cancelReservation.jsp?reservation_number=" + reservationNumber + "'>Cancel</a>");
                out.println("</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        }

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<p style='text-align:center; color:red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>
<p><a href="PastCurrentReservations.jsp">View Past and Current Reservations</a></p>
<p><a href="resPage.jsp">Reservation Portal</a></p>
</body>
</html>
