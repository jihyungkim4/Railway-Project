<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Train Schedule Search</title>
</head>
<body>
    <%
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        String date = request.getParameter("date");
        String sortBy = request.getParameter("sort_by");

        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "departure_time";
        }

        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");

        String query = "SELECT * FROM train_schedules_has WHERE DATE(departure_time) = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, date);
        ResultSet rs = pstmt.executeQuery();

        List<Map<String, String>> matchingSchedules = new ArrayList<>();

        while (rs.next()) {
            String stops = rs.getString("stops");
            String stopTimes = rs.getString("stop_times");

            List<String> stopsList = Arrays.asList(stops.split(","));
            List<String> stopTimesList = Arrays.asList(stopTimes.split(","));

            if (stopsList.contains(origin) && stopsList.contains(destination)) {
                if (stopsList.indexOf(origin) < stopsList.indexOf(destination)) {
                    double fare = rs.getDouble("fare");
                    int numStops = stopsList.size();
                    double farePerStop = fare / numStops;

                    int originIndex = stopsList.indexOf(origin);
                    int destinationIndex = stopsList.indexOf(destination) + 1;

                    List<String> relevantStops = stopsList.subList(stopsList.indexOf(origin), stopsList.indexOf(destination) + 1);
                    List<String> relevantStopTimes = stopTimesList.subList(originIndex, destinationIndex);

                    Map<String, String> schedule = new HashMap<>();
                    schedule.put("transitline", rs.getString("transitline"));
                    schedule.put("departure_time", rs.getString("departure_time"));
                    schedule.put("arrival_time", rs.getString("arrival_time"));
                    schedule.put("fare", rs.getString("fare"));
                    schedule.put("travel_time", rs.getString("travel_time"));
                    schedule.put("relevant_stops", relevantStops.toString());
                    schedule.put("relevant_stop_times", relevantStopTimes.toString());
                    schedule.put("fare_per_stop", String.format("$%.2f", farePerStop));

                    matchingSchedules.add(schedule);
                }
            }
        }

        rs.close();
        pstmt.close();
        con.close();

        if (sortBy.equals("departure_time")) {
            matchingSchedules.sort(Comparator.comparing(schedule -> schedule.get("departure_time")));
        } else if (sortBy.equals("arrival_time")) {
            matchingSchedules.sort(Comparator.comparing(schedule -> schedule.get("arrival_time")));
        } else if (sortBy.equals("fare")) {
            matchingSchedules.sort(Comparator.comparing(schedule -> Double.parseDouble(schedule.get("fare"))));
        }
    %>

    <form method="get" action="searchSchedules.jsp">
        <input type="hidden" name="origin" value="<%= origin %>">
        <input type="hidden" name="destination" value="<%= destination %>">
        <input type="hidden" name="date" value="<%= date %>">
        
        <label for="sort_by">Sort by:</label>
        <select name="sort_by" id="sort_by" onchange="this.form.submit()">
            <option value="departure_time" <%= sortBy.equals("departure_time") ? "selected" : "" %>>Departure Time</option>
            <option value="arrival_time" <%= sortBy.equals("arrival_time") ? "selected" : "" %>>Arrival Time</option>
            <option value="fare" <%= sortBy.equals("fare") ? "selected" : "" %>>Fare</option>
        </select>
    </form>

    <h1>Search Results</h1>
    <%
        if (matchingSchedules.isEmpty()) {
    %>
        <p>No matching train schedules found for your search.</p>
    <%
        } else {
    %>
        <table border="1">
            <thead>
                <tr>
                    <th>Transit Line</th>
                    <th>Departure Time</th>
                    <th>Arrival Time</th>
                    <th>Fare</th>
                    <th>Travel Time</th>
                    <th>Stops</th>
                    <th>Fare per Stop</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Map<String, String> schedule : matchingSchedules) {
                        String departureTime = schedule.get("departure_time");
                        String arrivalTime = schedule.get("arrival_time");

                        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date original_departure_time = originalFormat.parse(departureTime);
                        Date original_arrival_time = originalFormat.parse(arrivalTime);

                        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                        String departure_time = timeFormat.format(original_departure_time);
                        String arrival_time = timeFormat.format(original_arrival_time);

                        List<String> relevantStops = Arrays.asList(schedule.get("relevant_stops").replace("[", "").replace("]", "").split(","));
                        List<String> relevantStopTimes = Arrays.asList(schedule.get("relevant_stop_times").replace("[", "").replace("]", "").split(","));

                        double farePerStop = Double.parseDouble(schedule.get("fare_per_stop").replace("$", ""));
                %>
                <tr>
                    <td><%= schedule.get("transitline") %></td>
                    <td><%= departure_time %></td>
                    <td><%= arrival_time %></td>
                    <td><%= schedule.get("fare") %></td>
                    <td><%= schedule.get("travel_time") %></td>
                    <td>
                    <%
                        for (int i = 0; i < relevantStops.size(); i++) {
                            String stop = relevantStops.get(i);
                            String stopTime = relevantStopTimes.get(i);
                            Date original_stop_time = originalFormat.parse(stopTime);
                            String stop_time = timeFormat.format(original_stop_time);

                            double stopFare = farePerStop * (i + 1);
                            out.println(stop + " ($" + String.format("%.2f", stopFare) + ") at " + stop_time + "<br>");
                        }
                    %>
                </td>
                <td><%= schedule.get("fare_per_stop") %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        }
    %>
</body>
</html>
