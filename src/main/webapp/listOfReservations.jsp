<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List Reservations</title>
</head>
<body>
    <%
        String transitline = request.getParameter("transitline");
        String passenger = request.getParameter("passenger");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "9142203eE!");

            PreparedStatement ps = null;

            if (transitline != null && !transitline.trim().isEmpty()) {
                String query = "SELECT * FROM reservations_for_associatedwith_contains WHERE transitline = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, transitline);
            } else if (passenger != null && !passenger.trim().isEmpty()) {
                String query = "SELECT * FROM reservations_for_associatedwith_contains WHERE passenger = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, passenger);
            } else {
                String query = "SELECT * FROM reservations_for_associatedwith_contains";
                ps = con.prepareStatement(query);
            }

            ResultSet rs = ps.executeQuery();

    %>

    <h1>List Reservations</h1>
    <form method="get">
        <label>Transit Line: </label>
        <input type="text" name="transitline" placeholder="Enter Transit Line">
        <button type="submit">Search</button>
    </form>

    <form method="get">
        <label>Customer Name: </label>
        <input type="text" name="passenger" placeholder="Enter Customer Name">
        <button type="submit">Search</button>
    </form>

    <hr>

    <h2>Results:</h2>
    <table border="1">
        <tr>
            <th>Reservation Number</th>
            <th>Reservation Date</th>
            <th>Passenger</th>
            <th>Transit Line</th>
            <th>Train</th>
            <th>Origin Station</th>
            <th>Destination Station</th>
            <th>Total Fare</th>
            <th>Email Address</th>
        </tr>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("reservation_number") %></td>
            <td><%= rs.getDate("reservation_date") %></td>
            <td><%= rs.getString("passenger") %></td>
            <td><%= rs.getString("transitline") %></td>
            <td><%= rs.getString("train") %></td>
            <td><%= rs.getString("origin_station") %></td>
            <td><%= rs.getString("destination_station") %></td>
            <td><%= rs.getDouble("total_fare") %></td>
            <td><%= rs.getString("email_address") %></td>
        </tr>
        <%
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            out.println("<p>SQL Error: " + e.getMessage() + "</p>");
        } catch (Exception e) {
            out.println("<p>Unexpected Error: " + e.getMessage() + "</p>");
        }
        %>
    </table>
</body>
</html>
