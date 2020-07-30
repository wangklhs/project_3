<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	//判断用户名密码是否正确的变量，将来完善他的取值；
	boolean isUser = false;
	if (request.getParameter("username") == null && !isUser) {
		out.print("<form method=\"post\" action=\"login.jsp\">");
		out.print("<p>Username:</p>");
		out.print("<input type=\"text\" name=\"username\" required>");
		out.print("	<p>Password:</p>");
		out.print("<input type=\"password\" name=\"password\" required><p></p>");
		out.print("<input type=\"submit\" value=\"log in\">");
		out.print("</form>");
		}
	else {
		out.print("Welcome!" + request.getParameter("username"));
	}
	%>
</body>
</html>