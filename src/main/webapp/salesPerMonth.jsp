<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Monthly Sales Report</title>
</head>
<body>
<%
    String month = request.getParameter("month");
    String year = request.getParameter("year");

    if (month != null && year != null) {
        try {
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "9142203eE!");

            
            String query = "SELECT DATE_FORMAT(reservation_date, '%Y-%m') AS month, " +
                           "SUM(total_fare) AS total_sales " +
                           "FROM reservations_for_associatedwith_contains " +
                           "WHERE MONTH(reservation_date) = ? AND YEAR(reservation_date) = ? " +
                           "GROUP BY month";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, Integer.parseInt(month));
            ps.setInt(2, Integer.parseInt(year));

            ResultSet rs = ps.executeQuery();

            
            if (rs.next()) {
                out.println("<h2>Sales Report for " + year + "-" + month + "</h2>");
                out.println("<p>Total Sales: $" + rs.getDouble("total_sales") + "</p>");
            } else {
                out.println("<p>No sales data available for the specified month.</p>");
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            out.println("<p>SQL Error: " + e.getMessage() + "</p>");
        } catch (Exception e) {
            out.println("<p>Unexpected Error: " + e.getMessage() + "</p>");
        }
    }
%>


<h1>Generate Monthly Sales Report</h1>
<form method="post">
    Year: <input type="number" name="year" required placeholder="e.g., 2024"><br>
    Month: 
    <select name="month" required>
        <option value="" disabled selected>Select Month</option>
        <option value="1">January</option>
        <option value="2">February</option>
        <option value="3">March</option>
        <option value="4">April</option>
        <option value="5">May</option>
        <option value="6">June</option>
        <option value="7">July</option>
        <option value="8">August</option>
        <option value="9">September</option>
        <option value="10">October</option>
        <option value="11">November</option>
        <option value="12">December</option>
    </select><br>
    <button type="submit">Generate Report</button>
</form>
</body>
</html>
