<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" charset="UTF-8">
<link rel="stylesheet" href="style.css">
<script src="https://cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
<title>Upload</title>
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
    <div class="con">
    <header class="head">
        Image Information
    </header>
    <%
    ArrayList<String[]> img = (ArrayList<String[]>)request.getAttribute("img");
    String content = null;
    String country = null;
    if (request.getParameter("content") != null) {
    	content = request.getParameter("content");
    }
    else {
    	if (img != null)
    		content = img.get(0)[9];
    }
    if (request.getParameter("country") != null) {
    	country = request.getParameter("country");
    }
    else {
    	if (img != null)
    		country = img.get(0)[6];
    }
    ArrayList<String[]> countries = (ArrayList<String[]>)request.getAttribute("countries");
    ArrayList<String[]> cities = (ArrayList<String[]>)request.getAttribute("cities");
    String src = request.getParameter("src");
    %>
    <form id='form' class="search-form upload-form" method="POST" action="/project/upload<%= request.getParameter("id") == null ? "" : "?id=" + request.getParameter("id")%><%= request.getParameter("src") == null ? "" : "?path=" + request.getParameter("src")%>"">
    <%
    if (img != null) {
    	out.print("<img src=\"images/large/" + img.get(0)[8] + "\" id=\"img\">");
    }
    else {
    	if (src != null) {
    		out.print("<img src=\"images/large/" + src + "\" id=\"img\">");
    	}
    	else {
    		out.print("<img src=\"images/sup/initial.png\" id=\"img\">");
    	}
    	out.print("<input type=\"file\" name=\"file\" id=\"file\">");
    }
    %>
    <div class="select" style="border: none; padding: 40px 0 10px 0">
        <select name="content" id="con" required>
        <option value="" <%= content == null ? "selected" : "" %>>Content</option>
        <option value="scenery" <%= content != null && content.equals("scenery") ? "selected" : "" %>>Scenery</option>
        <option value="city" <%= content != null && content.equals("city") ? "selected" : "" %>>City</option>
        <option value="people" <%= content != null && content.equals("people") ? "selected" : "" %>>People</option>
        <option value="animal" <%= content != null && content.equals("animal") ? "selected" : "" %>>Animal</option>
        <option value="building" <%= content != null && content.equals("building") ? "selected" : "" %>>Building</option>
        <option value="wonder" <%= content != null && content.equals("wonder") ? "selected" : "" %>>Wonder</option>
		<option value="other" <%= content != null && content.equals("other") ? "selected" : "" %>>Other</option>
        </select>
        <select name="iso" id="first" onChange="nextChange()" required>
        <%
        for(int i = 0; i < countries.size(); i ++) {
        	if (i == 0){%>
        	<option value=""  <%= img == null ? "selected" : "" %>>Country</option>
        	<% 
        	}
        	else {
        	%>
        	<option value="<%= countries.get(i)[0] %>" <%= country != null && country.equals(countries.get(i)[0]) ? "selected" : "" %>><%= countries.get(i)[1] %></option>
        <%
        	}
        }
        %>
        </select>
        <select name="city" required>
            <option  value='' <%= img == null ? "selected" : "" %>>City</option>
            <%
            if (cities != null) {
            	for(int i = 0; i < cities.size(); i ++) {
            		String select = img != null && img.get(0)[5].equals(cities.get(i)[0]) ? "selected" : "";
            		out.print("<option value=\"" + cities.get(i)[0] + "\" " + select + ">" + cities.get(i)[1] + "</option>");
            	}
            }
            %>
        </select>
        </div>
        <p>图片标题:</p>
        <input type="text" name="title" class="title-input" value="<%= img == null ? "" : img.get(0)[1] %>" required>
        <p>图片描述:</p>
        <textarea name="des" class="des-input" required><%= img == null ? "" : img.get(0)[2] %></textarea>
        <p></p>

        <button type="submit" class="submit">complete</button>
        </form>
	</div>
<footer class="root-fot">
    Copyright© 19fdubaldcoders' first project. No right reserved.  备案号: 19302010050 ws
</footer>
<a id='anchor' style='display: none' href="/project/upload?<%= request.getParameter("id") == null ? "n=1" : "id=" + request.getParameter("id") %>"></a>
</body>
<script>
    var form = document.getElementById("form");
    var img = document.getElementById("img");
    var file = document.getElementById("file");
    $("#file").change(function() {
        var objUrl = getObjectURL(this.files[0]);
        var path = this.value.substring(this.value.lastIndexOf('h') + 2);
        console.log("objUrl = "+objUrl);
        if (objUrl) {
            $("#img").attr("src", objUrl);
            form.action = '/project/upload?path=' + path;
        }
    }) ;
    function getObjectURL(file) {
        var url = null;
        if (window.createObjectURL!=undefined) {
            url = window.createObjectURL(file) ;
        } else if (window.URL!=undefined) {
            url = window.URL.createObjectURL(file) ;
        } else if (window.webkitURL!=undefined) {
            url = window.webkitURL.createObjectURL(file) ;
        }
        return url ;
    }
    function nextChange() {
        var first = document.getElementById("first");
        var anchor = document.getElementById("anchor");
        var option = first.children[first.selectedIndex];
        var con = document.getElementById("con");
        if (first.selectedIndex != 0) {
            if (con.selectedIndex != 0) {
                anchor.href += "&content=" + con.children[con.selectedIndex].value;
            }
            if (file) {
                let path = file.value;
                if (path != 0) {
                    path = path.substring(path.lastIndexOf('h') + 2);
                    anchor.href += "&country=" + option.value + "&src=" + path;
                }
                else {
                    if (img.src.indexOf("initial.png") > 0)
                        anchor.href += "&country=" + option.value;
                    else {
                        path = img.src.substring(img.src.lastIndexOf('e') + 2);
                        anchor.href += "&country=" + option.value + "&src=" + path;
                    }
                }
            }
            else
                anchor.href += "&country=" + option.value;
            anchor.click();
        }
    }
</script>
</html>