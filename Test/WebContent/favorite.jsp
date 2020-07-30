<%@page import="java.util.Properties"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Driver"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%
	//在session中设置username这应该是登陆页面的工作
	session.setAttribute("userID", "1");
	
	//获取用户名
	String userID = (String)session.getAttribute("userID");
	%>
	<h3>UserID: <% out.print(userID); %></h3>
	<h3>>My favorite</h3>
	<%
	String url = "jdbc:mysql://localhost:3306/travels?serverTimezone=UTC";
	Properties info = new Properties();
	info.put("user","root");
	info.put("password","klhs");
	Driver driver = new com.mysql.cj.jdbc.Driver();
	Connection connection = driver.connect(url, info);
	System.out.println(connection);
	Statement statement = connection.createStatement();
	ResultSet result =  statement.executeQuery("SELECT ImageID FROM travelimagefavor WHERE UID = '1'");
	while(result.next()) {
		out.print(result.getString("ImageID"));
	}
	%>
</body>
</html>