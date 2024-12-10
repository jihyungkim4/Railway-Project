<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Train Schedules</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
            text-align: left;
        }
    </style>
</head>
<body>
<%
    // Validate session to ensure user is logged in
    if (session.getAttribute("username") == null || !"customer_rep".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String sortBy = request.getParameter("sort_by");
    if (sortBy == null || sortBy.isEmpty()) {
        sortBy = "departure_time"; // Default sorting by departure time
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");

    // Query to fetch all train schedules
    String query = "SELECT * FROM train_schedules_has";
    PreparedStatement pstmt = con.prepareStatement(query);
    ResultSet rs = pstmt.executeQuery();

    List<Map<String, String>> trainSchedules = new ArrayList<>();

    while (rs.next()) {
        Map<String, String> schedule = new HashMap<>();
        schedule.put("transitline", rs.getString("transitline"));
        schedule.put("train", rs.getString("train"));
        schedule.put("origin", rs.getString("origin"));
        schedule.put("destination", rs.getString("destination"));
        schedule.put("stops", rs.getString("stops"));
        schedule.put("stop_times", rs.getString("stop_times"));
        schedule.put("departure_time", rs.getString("departure_time"));
        schedule.put("arrival_time", rs.getString("arrival_time"));
        schedule.put("travel_time", rs.getString("travel_time"));
        schedule.put("fare", rs.getString("fare"));
        trainSchedules.add(schedule);
    }

    rs.close();
    pstmt.close();
    con.close();

    // Sorting the schedules based on the selected criteria
    if (sortBy.equals("departure_time")) {
        trainSchedules.sort(Comparator.comparing(schedule -> schedule.get("departure_time")));
    } else if (sortBy.equals("arrival_time")) {
        trainSchedules.sort(Comparator.comparing(schedule -> schedule.get("arrival_time")));
    } else if (sortBy.equals("fare")) {
        trainSchedules.sort(Comparator.comparing(schedule -> Double.parseDouble(schedule.get("fare"))));
    }
%>

<form method="post" action="updateAllTrainDetails.jsp">
    <label for="sort_by">Sort by:</label>
    <select name="sort_by" id="sort_by" onchange="this.form.submit()">
        <option value="departure_time" <%= sortBy.equals("departure_time") ? "selected" : "" %>>Departure Time</option>
        <option value="arrival_time" <%= sortBy.equals("arrival_time") ? "selected" : "" %>>Arrival Time</option>
        <option value="fare" <%= sortBy.equals("fare") ? "selected" : "" %>>Fare</option>
    </select>
</form>

<h1>Edit Train Schedules</h1>
<%
    if (trainSchedules.isEmpty()) {
%>
    <p>No train schedules found.</p>
<%
    } else {
%>
    <form method="post" action="updateAllTrainDetails.jsp">
        <table>
            <thead>
                <tr>
                    <th>Transit Line</th>
                    <th>Train</th>
                    <th>Origin</th>
                    <th>Destination</th>
                    <th>Stops</th>
                    <th>Stop Times</th>
                    <th>Departure Time</th>
                    <th>Arrival Time</th>
                    <th>Travel Time</th>
                    <th>Fare</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int index = 0;
                    for (Map<String, String> schedule : trainSchedules) {
                        String departureTime = schedule.get("departure_time");
                        String arrivalTime = schedule.get("arrival_time");

                        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date departureDate = originalFormat.parse(departureTime);
                        Date arrivalDate = originalFormat.parse(arrivalTime);

                        SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                        String formattedDepartureTime = timeFormat.format(departureDate);
                        String formattedArrivalTime = timeFormat.format(arrivalDate);
                %>
                <tr>
                    <td><input type="text" name="schedules[<%= index %>][transitline]" value="<%= schedule.get("transitline") %>" readonly></td>
                    <td><input type="text" name="schedules[<%= index %>][train]" value="<%= schedule.get("train") %>" readonly></td>
                    <td><input type="text" name="schedules[<%= index %>][origin]" value="<%= schedule.get("origin") %>"></td>
                    <td><input type="text" name="schedules[<%= index %>][destination]" value="<%= schedule.get("destination") %>"></td>
                    <td><input type="text" name="schedules[<%= index %>][stops]" value="<%= schedule.get("stops") %>"></td>
                    <td><input type="text" name="schedules[<%= index %>][stop_times]" value="<%= schedule.get("stop_times") %>"></td>
                    <td><input type="datetime-local" name="schedules[<%= index %>][departure_time]" value="<%= formattedDepartureTime %>"></td>
                    <td><input type="datetime-local" name="schedules[<%= index %>][arrival_time]" value="<%= formattedArrivalTime %>"></td>
                    <td><input type="number" name="schedules[<%= index %>][travel_time]" value="<%= schedule.get("travel_time") %>"></td>
                    <td><input type="number" step="0.01" name="schedules[<%= index %>][fare]" value="<%= schedule.get("fare") %>"></td>
                </tr>
                <%
                        index++;
                    }
                %>
            </tbody>
        </table>
        <button type="submit">Submit Changes</button>
    </form>
<%
    }
%>
</body>
</html>
