<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Most Active Transit Lines</title>
</head>
<body>
    <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "9142203eE!");


            String query = "SELECT transitline, COUNT(*) AS reservation_count " +
                           "FROM reservations_for_associatedwith_contains " +
                           "GROUP BY transitline " +
                           "ORDER BY reservation_count DESC " +
                           "LIMIT 5";

            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
    %>

    <h1>Top 5 Most Active Transit Lines</h1>

    <hr>

    <h2>Result:</h2>
    <table border="1">
        <tr>
            <th>Transit Line</th>
            <th>Number of Reservations</th>
        </tr>
        <%

            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("transitline") %></td>
            <td><%= rs.getInt("reservation_count") %></td>
        </tr>
        <%
            }

            if (!rs.isBeforeFirst()) {
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
