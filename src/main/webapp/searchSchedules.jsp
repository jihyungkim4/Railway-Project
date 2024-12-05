<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	    String origin = request.getParameter("origin");
	    String destination = request.getParameter("destination");
	    String date = request.getParameter("date");
	
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "pass");
	
	    String query = "SELECT * FROM train_schedules_has WHERE DATE(departure_time) = ?";
	    PreparedStatement pstmt = con.prepareStatement(query);
	    pstmt.setString(1, date);
	    ResultSet rs = pstmt.executeQuery();
	
	    List<Map<String, String>> matchingSchedules = new ArrayList<>();
	
	    while (rs.next()) {
	        String stops = rs.getString("stops");
	        List<String> stopsList = Arrays.asList(stops.split(","));
	        
	
	        if (stopsList.contains(origin) && stopsList.contains(destination)) {
	            if (stopsList.indexOf(origin) < stopsList.indexOf(destination)) {
	            	double fare = rs.getDouble("fare");
                    int numStops = stopsList.size();
                    double farePerStop = fare / numStops;

                    List<String> relevantStops = stopsList.subList(stopsList.indexOf(origin), stopsList.indexOf(destination) + 1);

	                    		
	                Map<String, String> schedule = new HashMap<>();
	                schedule.put("transitline", rs.getString("transitline"));
	                schedule.put("departure_time", rs.getString("departure_time"));
	                schedule.put("arrival_time", rs.getString("arrival_time"));
	                schedule.put("fare", rs.getString("fare"));
	                schedule.put("travel_time", rs.getString("travel_time"));
	                schedule.put("relevant_stops", relevantStops.toString());
                    schedule.put("fare_per_stop", String.format("$%.2f", farePerStop));
                   
	                matchingSchedules.add(schedule);
	            }
	        }
	    }
	
	    rs.close();
	    pstmt.close();
	    con.close();
	%>
	
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
                    	
                   	 List<String> relevantStops = Arrays.asList(schedule.get("relevant_stops").replace("[", "").replace("]", "").split(","));
                        double farePerStop = Double.parseDouble(schedule.get("fare_per_stop").replace("$", ""));
               
                %>
                <tr>
                    <td><%= schedule.get("transitline") %></td>
                    <td><%= schedule.get("departure_time") %></td>
                    <td><%= schedule.get("arrival_time") %></td>
                    <td><%= schedule.get("fare") %></td>
                    <td><%= schedule.get("travel_time") %></td>
                    <td>
                    <%
                        for (int i = 0; i < relevantStops.size(); i++) {
                            String stop = relevantStops.get(i);
                            double stopFare = farePerStop * (i + 1);
                            out.println(stop + " ($" + String.format("%.2f", stopFare) + ")<br>");
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