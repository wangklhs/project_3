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
	if (request.getParameter("first name") != null && request.getParameter("first name") != "" && request.getParameter("last name") != "" && request.getParameter("email") !="") {
		out.print("Welcome!" + request.getParameter("last name"));
		}
	else {
		out.print("<form method=\"post\" action=\"register.jsp\">");
		out.print("<p>First name:</p>");
		out.print("<input type=\"text\" name=\"first name\">");
		out.print("	<p>Last name:</p>");
		out.print("<input type=\"text\" name=\"last name\">");
		out.print("	<p>E-mail:</p>");
		out.print("<input type=\"email\" name=\"email\"><p></p>");
		out.print("<input type=\"submit\" value=\"log in\">");
		out.print("</form>");
		if (request.getParameter("first name") != null || request.getParameter("last name") != null || request.getParameter("email") !=null) {
			if (request.getParameter("first name") == "") 
				out.print("<p style=\"color: red;\">You must enter First name!</p>");
				else {
					if (request.getParameter("last name") == "") 
						out.print("<p style=\"color: red;\">You must enter Last name!</p>");
					else {
						if (request.getParameter("email") == "") 
							out.print("<p style=\"color: red;\">You must enter E-mail!</p>");
					}
				}
				
		}
	}
	%>
</body>
</html>