<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css">
<title>Friends</title>
<style type="text/css">
#button{
background-color: #515151;
position: relative;
left: 15px;
width:120px;
}
</style>
</head>
<body>
	<nav>
        <div id="nav-right">
            <% 
            if(session.getAttribute("username") != null) {
            	out.print("<ul id=\"list\">");
            	out.print("<span class=\"nav-a\" style=\"margin-left:50px; position:relative; right: 15px;\"><img width=\"20\" style=\"position:relative; top:5px;\" class=\"nav-img\" src=\"images/sup/people.png\">" + session.getAttribute("username") + "</span>");
            %>
            <li>
               <ul>
                   <li id="first-child"><a href="/project/upload">Upload</a></li>
                   <li id="second-child"><a href="/project/photo">My photo</a></li>
                   <li id="third-child"><a href="/project/favor">My favorite</a></li>
                   <li id="fifth-child"><a href="/project/friends">My friends</a></li>
                   <li id="fourth-child"><a href="/project/logout">Log out</a></li>
               </ul>
            </li>          
           <%
           out.print("</ul>");
           }
            else {
            %> 
                <a class="nav-a" style="margin-left:-200px; position:relative; right: 50px;" href="login.jsp"><img width="20" class="nav-img" src="images/sup/login.png">login</a>
            <% }%>
        </div>
        <div id="nav-left">
            <img id="logo" src="images/sup/logo.png" width="48">
            <a class="nav-a up" href="/project/index"><img width="20" class="nav-img" src="images/sup/home.png">Home</a>
            <a class="nav-a up" href="/project/search"><img width="20" class="nav-img" src="images/sup/search2.png">Search</a>
        </div>
    </nav>
    <%!
    String makeDiv(String id, String email, String username, String date, String authority) {
    	String result = "<div class=\"details\">";
    	String button = "<button class='red'><img src=\"images/sup/delete.png\"><a href=\"/project/friends?del=" + id + "\"><span>Delete</span></a></button></div>";
    	return result + "<p>Username: &nbsp &nbsp <a style=\"color: #7dc5eb;\" href=\"/project/favor?friendid=" + id + "&authority=" + authority + "\">" + username + "</a></p>" + "<p>Email: &nbsp &nbsp <a style=\"color: #7dc5eb;\" href=\"/project/favor?friendid=" + id + "&authority=" + authority + "\">" + email + "</a></p><p>DateJoined: &nbsp &nbsp" + date + "</p>" + button;
    }
    %>
    <div class="con search">
    <header class="head">
        Search user 
    </header>
    <form class="search-form" action="/project/friends" method="post">
    	Authority: <button id="button"><%= (int)request.getAttribute("started") == 1 ? "<a href=\"/project/friends?close=1\">close</a>" : "<a href=\"/project/friends?start=1\">start</a>" %></button>
    	<p></p>
        Please input userid or username precisely: 
        <br>
        <% 
        String err = request.getParameter("err") == null ? "" : request.getParameter("err") == "1" ? "<span style=\"color: indianred;\">The user doesn't exist</span>" : "<span style=\"color: indianred;\">You have added this user</span>"; 
        out.print(err);
        %>
        <input type="text" name="user" class="title-input" required>       
       	<br>
        <button type="submit" class="submit">Search</button>
    </form>
</div>
    <div class="con">
    <header class="head" >My Friends</header>
     <%
    ArrayList<String[]> friends = (ArrayList<String[]>)request.getAttribute("friends");
    if (friends.size() == 0) {
    %>
    <div style='padding: 80px 0 80px 450px'>
        <span style='color: rgb(112,128,144); font-size: 24px;'>You haven't added any friend</span>
    </div>
    <% } 
    else {
    	for (int i = 0; i < friends.size(); i ++) {
    %>
    <%= makeDiv(friends.get(i)[0], friends.get(i)[1], friends.get(i)[2], friends.get(i)[3], friends.get(i)[4]) %>
    <% }} %>
    </div>
    <footer class="root-fot">
    	Copyright© 19fdubaldcoders' first project. No right reserved.  备案号: 19302010050 ws
	</footer>
</body>
</html>