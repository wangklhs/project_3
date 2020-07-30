<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link rel="stylesheet" href="style.css">
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
        <p>Sign in for Fisher</p>
        <div class="form-con">
            <form method="post" action="/project/login">
            	<input type="hidden" name="location" value="<%= request.getParameter("location") == null ? "" :  request.getParameter("location") %>">
                <p>Username: <span style="color: indianred;"><%= request.getAttribute("err") == null ? "" : "Username or Password is wrong" %></span></p>
                <input name="username" type="text" value="<%= request.getParameter("username") == null ? "" :  request.getParameter("username") %>" required>
                <p>Password:</p>
                <input name="password" type="password" value="<%= request.getParameter("password") == null ? "" :  request.getParameter("password") %>" required>
                <p></p>
                <button type="submit" class="submit">Sign in</button>
            </form>
        </div>
        <p>New to Fisher? <a href="register.jsp" class="blue-a">Creat a new account.</a></p>
    </div>
    <footer class="root-fot form-fot">
        Copyright© 19fdubaldcoders' first project. No right reserved.  备案号: 19302010050 ws
    </footer>
</body>
</html>