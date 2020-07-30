<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Details</title>
<link rel="stylesheet" href="style.css">
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
    <% 
    ArrayList<String[]> row = (ArrayList<String[]>)request.getAttribute("row"); 
    int id = Integer.parseInt(row.get(0)[0]);
    String date = "2019-" + (8 + id /120) + "-" + (1 + id / 4);
    %>
 <div class="con">
    <header class="head">
        Details
    </header>
    <div class="details">
        <h2><%= row.get(0)[1] %></h2>
        <%= "<img style=\"max-height:450px; min-height:450px; max-width:600px; min-width:600px;\" src=\"images/large/" + row.get(0)[8] + "\">" %>
        <ul class="float-right">
            <li>
                <table>
                    <tr>
                        <td class="head">Like number</td>
                    </tr>
                    <tr>
                        <td class="like"><%= row.get(0)[10]%></td>
                    </tr>
                </table>
            </li>
            <li>
                <table>
                    <tr>
                        <td class="head">Image details</td>
                    </tr>
                    <tr>
                        <td style="padding-left: 20px">Content: <%= row.get(0)[9] == null ? "" : row.get(0)[9]%></td>
                    </tr>
                    <tr>
                        <td style="padding-left: 20px">Country: <%= row.get(0)[6] == null ? "" : row.get(0)[6]%></td>
                    </tr>
                    <tr>
                        <td style="padding-left: 20px">City: <%= row.get(0)[5] == null ? "" : row.get(0)[5]%></td>
                    </tr>
                    <tr>
                        <td style="padding-left: 20px">Writer: <%= row.get(0)[7] == null ? "" : row.get(0)[7]%></td>
                    </tr>
                    <tr>
                        <td style="padding-left: 20px">Date: <%= date%></td>
                    </tr>
                </table>
            </li>
            <li>
                <table class="red">
                    <tr>
                        <td>
                        <%
                        if (request.getAttribute("collected") != null) {
                        	out.print("<img src=\"images/sup/like.png\"><span>Collected</span>");
                        }
                        else {
                        	out.print("<a href=\"/project/details?favor=1&id=" + id + "\"><img src=\"images/sup/like.png\"><span>Collect</span></a>");
                        }
                        %>
                        </td>
                    </tr>
                </table>
            </li>
        </ul>
        <p>
            Description: <br><%= row.get(0)[2] == null ? "" : row.get(0)[2] %>
            <br>
            Don’t worry about encountering bugs. After all, everyone is new on the way of coding. If the code you write has no bugs, go
            Apply for exemption. Learning to debug in your messy code will be a very important feature, so you can improve your debug.
            Ping, try to solve errors faster when you can't avoid them.
        </p>
    </div>
</div>   
</body>
</html>