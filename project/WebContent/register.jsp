<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link rel="stylesheet" href="style.css">
<style type="text/css">
.form-fot{
position: relative;
top: 15px;
}
</style>
</head>
<body>
	<nav>
        <div id="nav-right">
         	 <a class="nav-a" style="margin-left:-200px; position:relative; right: 50px;" href="login.jsp?location=index"><img width="20" class="nav-img" src="images/sup/login.png">login</a>   
        </div>
        <div id="nav-left">
            <img id="logo" src="images/sup/logo.png" width="48">
            <a class="nav-a up" href="/project/index"><img width="20" class="nav-img" src="images/sup/home.png">Home</a>
            <a class="nav-a up" href="/project/search"><img width="20" class="nav-img" src="images/sup/search2.png">Search</a>
        </div>
    </nav>
    <div class="form">
    <img src="images/sup/form_logo.png">
    <p>Sign up for Fisher</p>
    <div class="form-con">
        <form method="post" action="/project/register<%= request.getParameter("location") == null ? "" : "?location=" + request.getParameter("location")%>">
            <p>Username:<span style="color: indianred;">
                <% if (request.getAttribute("err1") != null) {
                	if (request.getAttribute("err1") == "1")
                		out.print("Username is illegal (length: 4-15)");
                	else
                		out.print("Username has existed");
                }
                %>
                </span>
            </p>
            <input name="username" type="text" value="<%= request.getParameter("username") == null ? "" :  request.getParameter("username") %>" required>
            <p>E-mail:</p>
            <input name="email" type="email" value="<%= request.getParameter("email") == null ? "" :  request.getParameter("email") %>" required>
            <p>Password:<span style="color: indianred;">
                <% if (request.getAttribute("err2") != null) {
                	out.print("Password is illegal (length: 6-12)");
                }
                %>
                </span>
            </p>
            <input id="pass" name="password" type="password" value="<%= request.getParameter("pass") == null ? "" :  request.getParameter("pass") %>" required><span id="intensity"></span>
            <p>Confirm Your Password:
            <span style="color: indianred;">
                <% if (request.getAttribute("err3") != null) {
                	out.print("Two different password");
                }
                %>
                </span>
            </p>
            <input name="repass" type="password" value="<%= request.getParameter("repass") == null ? "" :  request.getParameter("repass") %>"required>
            <p></p>
            <button type="submit" class="submit">Sign Up</button>
        </form>
    </div>
    <p>Have an account? <a href="login.jsp?location=" class="blue-a">Come back to log in.</a></p>
</div>
<footer class="root-fot form-fot">
    Copyright© 19fdubaldcoders' first project. No right reserved.  备案号: 19302010050 ws
</footer>
</body>
</html>