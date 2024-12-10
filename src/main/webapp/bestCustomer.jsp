<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Best Customer</title>
</head>
<body>
    <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");

            String query = "SELECT passenger, SUM(total_fare) AS total_spent " +
                           "FROM reservations_for_associatedwith_contains " +
                           "GROUP BY passenger " +
                           "ORDER BY total_spent DESC " +
                           "LIMIT 1";

            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
    %>

    <h1>Best Customer</h1>

    <hr>

    <h2>Result:</h2>
    <table border="1">
        <tr>
            <th>Customer Name</th>
            <th>Total Money Spent</th>
        </tr>
        <%
            if (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("passenger") %></td>
            <td>$<%= String.format("%.2f", rs.getDouble("total_spent")) %></td>
        </tr>
        <%
            } else {
        %>
        <tr>
            <td colspan="2">No reservations found!</td>
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