<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customers by Transit Line</title>
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
    // Validate session to ensure user is logged in and a customer representative
    if (session.getAttribute("username") == null || !"customer_rep".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<h2 style="text-align: center;">Search Customers by Transit Line and Date</h2>

<!-- Search Form -->
<form action="customersByTransitLine.jsp" method="get" style="text-align: center; margin-bottom: 20px;">
    <label for="transitline">Transit Line:</label>
    <input type="text" id="transitline" name="transitline" placeholder="Enter Transit Line" required>
    <label for="date">Date:</label>
    <input type="date" id="date" name="date" required>
    <button type="submit">Search</button>
</form>

<%
    // Get parameters
    String transitLine = request.getParameter("transitline");
    String travelDate = request.getParameter("date");

    if (transitLine == null || transitLine.isEmpty() || travelDate == null || travelDate.isEmpty()) {
        out.println("<p style='text-align:center; color:red;'>Please provide a transit line and date to search.</p>");
    } else {
        try {
            // Load JDBC Driver and establish a connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "9142203eE!");

            // Query for customers with reservations on the given transit line and date
            String query = "SELECT r.reservation_number, r.transitline, r.origin_station, r.destination_station, r.total_fare, c.username, c.email_address " +
                           "FROM reservations_for_associatedwith_contains r " +
                           "JOIN customer c ON r.email_address = c.email_address " +
                           "WHERE r.transitline = ? AND r.reservation_date = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, transitLine);
            pstmt.setString(2, travelDate);

            ResultSet rs = pstmt.executeQuery();

            if (!rs.isBeforeFirst()) {
                out.println("<p style='text-align:center; color:red;'>No customers found for the given transit line and date.</p>");
            } else {
                out.println("<h3 style='text-align:center;'>Results for Transit Line: " + transitLine + " on " + travelDate + "</h3>");
                out.println("<table>");
                out.println("<tr><th>Reservation Number</th><th>Customer Username</th><th>Email Address</th><th>Origin</th><th>Destination</th><th>Fare</th></tr>");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("reservation_number") + "</td>");
                    out.println("<td>" + rs.getString("username") + "</td>");
                    out.println("<td>" + rs.getString("email_address") + "</td>");
                    out.println("<td>" + rs.getString("origin_station") + "</td>");
                    out.println("<td>" + rs.getString("destination_station") + "</td>");
                    out.println("<td>$" + rs.getDouble("total_fare") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }

            rs.close();
            pstmt.close();
            con.close();
        } catch (Exception e) {
            out.println("<p style='text-align:center; color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>
<p style="text-align: center;"><a href="success.jsp">Back to Dashboard</a></p>
</body>
</html>
