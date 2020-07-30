<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">
<link href="bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet " href="style.css">
<link href="rolling-image.css" rel="stylesheet">
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>Home</title>
<style type="text/css">
.up{
    position: relative;
    bottom: 3px;
    padding-left: 60px;
}
#logo{
    position: relative;
    right: 700px;
    top: -5px;
}
#nav-right a.nav-a{
    position: relative;
    top: 16px;
}
.nav-img{
    position: relative;
    right: 10px;
    top: 0px;
}
#list{
    list-style-type: none;
    position: absolute;
    left: 1150px;
    top: 17px;
}
</style>
</head>
<body>
	<nav>
        <div id="nav-right">
            
            <% 
            if(session.getAttribute("username") != null) {
            	out.print("<ul id=\"list\">");
            	out.print("<span class=\"nav-a\" style=\"margin-left:50px; position:relative; right: 15px;\"><img width=\"20\" class=\"nav-img\" src=\"images/sup/people.png\">" + session.getAttribute("username") + "</span>");
            %>
            <li>
               <ul>
                   <li id="first-child"><a href="/project/upload">Upload</a></li>
                   <li id="second-child"><a href="/project/photo">My photo</a></li>
                   <li id="third-child"><a href="/project/favor">My favorite</a></li>
                   <li id="fifth-child"><a href="/project/friends">My friends</a></li>
                   <li id="fourth-child"><a href="/project/logout?location=index">Log out</a></li>
               </ul>
            </li>          
           <%
           out.print("</ul>");
           }
            else {
            %> 
                <a class="nav-a" style="margin-left:-200px; position:relative; right: 20px;" href="login.jsp?location=index"><img width="20" class="nav-img" src="images/sup/login.png">login</a>
            <% }%>
        </div>
        <div id="nav-left" style="padding-top: 7px;">
            <img id="logo" src="images/sup/logo.png" width="48">
            <a id="now" name="now" class="nav-a up" href="/project/index"><img width="20" class="nav-img" src="images/sup/home.png">Home</a>
            <a class="nav-a up" href="/project/search"><img width="20" class="nav-img" src="images/sup/search2.png">Search</a>
        </div>
    </nav>
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
          <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
          <li data-target="#carousel-example-generic" data-slide-to="1"></li>
          <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        </ol>
      	<%
            ArrayList<String[]> imgs1 = (ArrayList<String[]>)request.getAttribute("imgs1");
            ArrayList<String[]> imgs2 = (ArrayList<String[]>)request.getAttribute("imgs2");
        %>
        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
          <div class="item active">
            <img src="images/large/<%= imgs1.get(0)[1] %>" alt="..." class="item-images">
            <div class="carousel-caption">
              <%= imgs1.get(0)[0] %>
            </div>
          </div>
          <div class="item">
            <img src="images/large/<%= imgs1.get(1)[1] %>" alt="..." class="item-images">
            <div class="carousel-caption">
              <%= imgs1.get(1)[0] %>
            </div>
          </div>
          <div class="item">
            <img src="images/large/<%= imgs1.get(2)[1] %>" alt="..." class="item-images">
            <div class="carousel-caption">
              <%= imgs1.get(2)[0] %>
            </div>
          </div>
        </div>
      
        <!-- Controls -->
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
          <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
    </div>
   	<%! String makeImg(int id, String title, String path, String author) { 
   		String date = "2019-" + (8 + id /120) + "-" + (1 + id / 4);
   		return "<a href=\"/project/details?id=" + id + "\"><img class=\"img\" src=\"images/large/" + path + "\"></a><figcaption><h4>" + title + "</h4>Author: " + author + " <br>Date: " + date + "</figcaption>";
   	}
   	%>
<div class="content">
   	<div class="con-down">
        <table id="tab-one">
            <tr>
                <td>
                    <figure>
                        <%= makeImg(Integer.parseInt(imgs2.get(0)[0]), imgs2.get(0)[1], imgs2.get(0)[3], imgs2.get(0)[4]) %>
                    </figure>
                </td>
                <td>
                    <figure>
                        <%= makeImg(Integer.parseInt(imgs2.get(1)[0]), imgs2.get(1)[1], imgs2.get(1)[3], imgs2.get(1)[4]) %>
                    </figure>
                </td>
                <td>
                    <figure>
                        <%= makeImg(Integer.parseInt(imgs2.get(2)[0]), imgs2.get(2)[1], imgs2.get(2)[3], imgs2.get(2)[4]) %>
                    </figure>
                </td>
            </tr>
       </table>
    </div>
</div>
<footer id="home_footer">
    <table id="fot-tab-one">
        <tr>
            <td>开发者:</td>
            <td>合作商:</td>
        </tr>
        <tr>
            <td>wang shuai</td>
            <td>反积分联盟</td>
        </tr>
        <tr>
            <td>W.S.</td>
            <td>死亡细胞学系</td>
        </tr>
        <tr>
            <td>HD-WS</td>
            <td>fdu资深hz</td>
        </tr>
    </table>
    <table id="fot-tab-two">
        <tr>
            <td><img src="images/sup/coin.png"></td>
            <td><img src="images/sup/share.png"></td>
        </tr>
        <tr>
            <td><img src="images/sup/setting.png"></td>
            <td><img src="images/sup/wechat.png"></td>
        </tr>
    </table>
    <span>Copyright© 19fdubaldcoders' first project. No right reserved.  备案号: 19302010050 ws</span>
</footer>
</body>
</html>