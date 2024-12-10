<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Past and Current Reservations</title>
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
        .cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        .active {
            background-color: #d4edda;
            color: #155724;
        }
    </style>
</head>
<body>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String email = null;

    try {
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

        // Fetch all reservations (active and cancelled)
        String query = "SELECT reservation_number, transitline, origin_station, destination_station, total_fare, status FROM reservations_for_associatedwith_contains WHERE email_address = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (!rs.isBeforeFirst()) {
            out.println("<p style='text-align:center; color:red;'>No reservations found.</p>");
        } else {
            out.println("<h2 style='text-align:center;'>Past and Current Reservations</h2>");
            out.println("<table>");
            out.println("<tr><th>Reservation Number</th><th>Transit Line</th><th>Origin</th><th>Destination</th><th>Fare</th><th>Status</th></tr>");
            while (rs.next()) {
                String status = rs.getString("status");
                String rowClass = status.equals("cancelled") ? "cancelled" : "active";

                out.println("<tr class='" + rowClass + "'>");
                out.println("<td>" + rs.getInt("reservation_number") + "</td>");
                out.println("<td>" + rs.getString("transitline") + "</td>");
                out.println("<td>" + rs.getString("origin_station") + "</td>");
                out.println("<td>" + rs.getString("destination_station") + "</td>");
                out.println("<td>$" + rs.getDouble("total_fare") + "</td>");
                out.println("<td>" + status + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        }

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>

<p><a href="HandleResTable_Customer.jsp">Back to Manage Reservations</a></p>
</body>
</html>
