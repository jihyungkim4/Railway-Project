<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Revenue Listing</title>
</head>
<body>
    <%
        String transitline = request.getParameter("transitline");
        String passenger = request.getParameter("passenger");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");

            PreparedStatement ps = null;

            if (transitline != null && !transitline.trim().isEmpty()) {
                String query = "SELECT transitline, SUM(total_fare) AS revenue FROM reservations_for_associatedwith_contains WHERE transitline = ? GROUP BY transitline";
                ps = con.prepareStatement(query);
                ps.setString(1, transitline);
            } else if (passenger != null && !passenger.trim().isEmpty()) {
                String query = "SELECT passenger, SUM(total_fare) AS revenue FROM reservations_for_associatedwith_contains WHERE passenger = ? GROUP BY passenger";
                ps = con.prepareStatement(query);
                ps.setString(1, passenger);
            } else {
                String query = "SELECT transitline, SUM(total_fare) AS revenue FROM reservations_for_associatedwith_contains GROUP BY transitline";
                ps = con.prepareStatement(query);
            }

            ResultSet rs = ps.executeQuery();

    %>

    <h1>Revenue Listing</h1>
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
            <% 
                if (transitline != null && !transitline.trim().isEmpty()) { 
            %>
                <th>Transit Line</th>
                <th>Total Revenue</th>
            <% 
                } else if (passenger != null && !passenger.trim().isEmpty()) { 
            %>
                <th>Customer Name</th>
                <th>Total Revenue</th>
            <% 
                } else { 
            %>
                <th>Transit Line</th>
                <th>Total Revenue</th>
            <% 
                } 
            %>
        </tr>
        <%
            while (rs.next()) {
                if (transitline != null && !transitline.trim().isEmpty()) {
        %>
        <tr>
            <td><%= rs.getString("transitline") %></td>
            <td><%= rs.getDouble("revenue") %></td>
        </tr>
        <%
                } else if (passenger != null && !passenger.trim().isEmpty()) {
        %>
        <tr>
            <td><%= rs.getString("passenger") %></td>
            <td><%= rs.getDouble("revenue") %></td>
        </tr>
        <%
                } else {
        %>
        <tr>
            <td><%= rs.getString("transitline") %></td>
            <td><%= rs.getDouble("revenue") %></td>
        </tr>
        <%
                }
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