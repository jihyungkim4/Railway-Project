<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Train Schedules</title>
</head>
<body>
<%
    // Validate session and role
    if (session.getAttribute("username") == null || !"customer_rep".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");

    // Query for dropdown data
    String trainLinesQuery = "SELECT DISTINCT transitline FROM train_schedules_has";
    String trainTypesQuery = "SELECT DISTINCT train FROM train_schedules_has";

    PreparedStatement trainLinesStmt = con.prepareStatement(trainLinesQuery);
    PreparedStatement trainTypesStmt = con.prepareStatement(trainTypesQuery);

    ResultSet trainLinesRs = trainLinesStmt.executeQuery();
    ResultSet trainTypesRs = trainTypesStmt.executeQuery();
%>
    <h1>Edit Train Schedules</h1>

    <!-- Filter Form -->
    <form action="editTrainSchedule.jsp" method="get">
        <label for="transitline">Select Train Line:</label>
        <select id="transitline" name="transitline">
            <option value="">-- All Train Lines --</option>
            <% while (trainLinesRs.next()) { %>
                <option value="<%= trainLinesRs.getString("transitline") %>">
                    <%= trainLinesRs.getString("transitline") %>
                </option>
            <% } %>
        </select>

        <label for="train">Select Train Type:</label>
        <select id="train" name="train">
            <option value="">-- All Train Types --</option>
            <% while (trainTypesRs.next()) { %>
                <option value="<%= trainTypesRs.getString("train") %>">
                    <%= trainTypesRs.getString("train") %>
                </option>
            <% } %>
        </select>

        <button type="submit">Search</button>
    </form>

<%
    // Retrieve filter parameters
    String selectedLine = request.getParameter("transitline");
    String selectedTrain = request.getParameter("train");

    // Query to fetch train schedules based on filters
    String searchQuery = "SELECT * FROM train_schedules_has WHERE 1=1";
    if (selectedLine != null && !selectedLine.isEmpty()) {
        searchQuery += " AND transitline = ?";
    }
    if (selectedTrain != null && !selectedTrain.isEmpty()) {
        searchQuery += " AND train = ?";
    }

    PreparedStatement searchStmt = con.prepareStatement(searchQuery);
    int paramIndex = 1;
    if (selectedLine != null && !selectedLine.isEmpty()) {
        searchStmt.setString(paramIndex++, selectedLine);
    }
    if (selectedTrain != null && !selectedTrain.isEmpty()) {
        searchStmt.setString(paramIndex++, selectedTrain);
    }

    ResultSet searchResults = searchStmt.executeQuery();
%>

    <!-- Display Train Schedules -->
    <h2>Available Train Schedules</h2>
    <table border="1">
        <tr>
            <th>Train Line</th>
            <th>Train Type</th>
            <th>Origin</th>
            <th>Destination</th>
            <th>Departure Time</th>
            <th>Arrival Time</th>
            <th>Fare</th> <!-- Added Fare Column -->
            <th>Actions</th>
        </tr>
        <% while (searchResults.next()) { %>
        <tr>
            <td><%= searchResults.getString("transitline") %></td>
            <td><%= searchResults.getString("train") %></td>
            <td><%= searchResults.getString("origin") %></td>
            <td><%= searchResults.getString("destination") %></td>
            <td><%= searchResults.getString("departure_time") %></td>
            <td><%= searchResults.getString("arrival_time") %></td>
            <td><%= searchResults.getString("fare") %></td> <!-- Displaying Fare -->
            <td>
                <a href="editTrainDetails.jsp?transitline=<%= searchResults.getString("transitline") %>&train=<%= searchResults.getString("train") %>">
                    Edit
                </a>
                <a href="deleteTrainSchedule.jsp?transitline=<%= searchResults.getString("transitline") %>&train=<%= searchResults.getString("train") %>"
                   onclick="return confirm('Are you sure you want to delete this train schedule?');">
                    Delete
                </a>
            </td>
        </tr>
        <% } %>
    </table>

<%
    trainLinesRs.close();
    trainTypesRs.close();
    searchResults.close();
    trainLinesStmt.close();
    trainTypesStmt.close();
    searchStmt.close();
    con.close();
%>
<p><a href="success.jsp">Home</a></p>

</body>
</html>
