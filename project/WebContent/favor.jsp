<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Favor</title>
<link rel="stylesheet" href="style.css">
<style type="text/css">
.con{
    margin: 20px 300px 20px 100px;
    background-color: white;
    border: darkgray solid 1px;
    border-radius: 6px;
}
#footprint{
	position: absoulate;
	left: 1150px;
	top: 300px; 
	color: #7dc5eb;
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
<%! String makeImg(int id, String title, String path, String des) { 
   		String result =  "<a href=\"/project/details?id=" + id + "\"><img class=\"img\" src=\"images/large/" + path + "\"></a><div class=\"abs-right\"><h3>" + title + "</h3><p>";
 		if (des == null) {
 			des = "No description";
 		}
   		return result + des + "</p></div>";
   	}
   	%>
   	<div class="con">
    <header class="head" style="font-size: 22pt"><%= request.getParameter("friendid") == null ? "My Favor" : (String)request.getAttribute("friendname") + "'s Favor"%></header>
    <%
    ArrayList<String[]> imgs = (ArrayList<String[]>)request.getAttribute("imgs");
    if (imgs.size() == 0 || request.getParameter("authority") == "b") {
    %>
    <div style='padding: 80px 0 80px 350px'>
        <span style='color: rgb(112,128,144); font-size: 24px;'><%=  request.getParameter("authority") == "a" ? "No photo collected" : "The user has set permissions"%></span>
    </div>
    <% }
    else {
    	int pagenum;
    	for (int i = 0; i < imgs.size(); i ++) {
    		out.print("<div class=\"details\" id=\"" + i + "\">");
    		out.print(makeImg(Integer.parseInt(imgs.get(i)[0]), imgs.get(i)[1], imgs.get(i)[3], imgs.get(i)[2]));
    		if (request.getParameter("friendid") == null) {
    %>
    	<button class='red'>
               <img src="images/sup/delete.png">
               <a href="/project/favor?del=<%= imgs.get(i)[0]%>"><span>Delete</span></a>
        </button>
        </div>
    <%    	
    		}}
    	if ((pagenum = imgs.size() / 9 + 1) > 1) {
    %>
    <a class="page" onclick="toLastPage()"> << </a> &nbsp &nbsp
    <%for(int i = 0; i < pagenum; i ++) {
    	out.print("<a class='page' id=\"page" + (i + 1) + "\" onclick=\"toPage("+ (i + 1) +")\">" + (i + 1) + "</a> &nbsp &nbsp");
    }
    %>
	<a class="page" onclick="toNextPage()"> >> </a>  
    <% 		}
    	}
    if (request.getAttribute("footprint") != null) {
    	ArrayList<String[]> footprint = (ArrayList<String[]>)request.getAttribute("footprint");
    	out.print("<ul id=\"footprint\">My footprint");
    	for (int i = 0; i < footprint.size(); i ++) {
    		out.print("<li><a style=\"color:#7dc5eb\"href=\"/project/details?id=" + footprint.get(i)[1] + "\">" + footprint.get(i)[2] + "</a></li>");
    	}
    	out.print("</ul>");
    } 
    %>
    </div>
   	<footer class="root-fot">
    	Copyright© 19fdubaldcoders' first project. No right reserved.  备案号: 19302010050 ws
	</footer>
</body>
<script type="text/javascript">
var divs = document.getElementsByClassName("details");
var pagenum = Math.ceil(divs.length / 9);
var page = 1;

function changePage() {
    for(let i = 0; i < divs.length; i ++) {
        if (i + 1 <= 9 * (page - 1) | i  + 1 > 9 * page)
            divs[i].style = "display: none;";
        else
            divs[i].style = "display: block";
    }
    for(let i = 0; i < pagenum; i ++) {
    	if (i + 1 == page)
    		document.getElementById("page" + (i + 1)).style = "font-weight: bold;";
    	else
    		document.getElementById("page" + (i  + 1)).style = "";
    }
    
}
function toLastPage() {
    if (page != 1) {
        page = page - 1;
        changePage();
    }
}
function toNextPage() {
    if (page != pagenum) {
        page = page + 1;
        changePage();
    }
}
function toPage(i) {
    if (page != i) {
        page = i;
        changePage();
    }
}

changePage();

</script>
</html>