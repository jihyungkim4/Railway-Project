<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Train Schedules by Station</title>
</head>
<body>
    <%
        String station = request.getParameter("station");
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");

        String query = "SELECT * FROM train_schedules_has WHERE origin = ? OR destination = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, station);
        pstmt.setString(2, station);
        ResultSet rs = pstmt.executeQuery();

        List<Map<String, String>> trainSchedules = new ArrayList<>();

        while (rs.next()) {
            Map<String, String> schedule = new HashMap<>();
            schedule.put("transitline", rs.getString("transitline"));
            schedule.put("train", rs.getString("train"));
            schedule.put("origin", rs.getString("origin"));
            schedule.put("destination", rs.getString("destination"));
            schedule.put("departure_time", rs.getString("departure_time"));
            schedule.put("arrival_time", rs.getString("arrival_time"));
            trainSchedules.add(schedule);
        }

        rs.close();
        pstmt.close();
        con.close();
    %>

    <h1>Train Schedules for Station</h1>
    <form method="get" action="trainSchedulesByStation.jsp">
        <label for="station">Enter Station Name:</label>
        <input type="text" id="station" name="station" value="<%= station %>" required>
        <button type="submit">Search</button>
    </form>
    <br>
    <%
        if (trainSchedules.isEmpty()) {
    %>
        <p>No train schedules found for the station: <%= station %>.</p>
    <%
        } else {
    %>
        <table border="1">
            <tr>
                <th>Transit Line</th>
                <th>Train</th>
                <th>Origin</th>
                <th>Destination</th>
                <th>Departure Time</th>
                <th>Arrival Time</th>
            </tr>
            <%
                for (Map<String, String> schedule : trainSchedules) {
            %>
            <tr>
                <td><%= schedule.get("transitline") %></td>
                <td><%= schedule.get("train") %></td>
                <td><%= schedule.get("origin") %></td>
                <td><%= schedule.get("destination") %></td>
                <td><%= schedule.get("departure_time") %></td>
                <td><%= schedule.get("arrival_time") %></td>
            </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
</body>
</html>
