<%-- 
    Document   : insertCategory
    Created on : 17-may-2011, 9:43:17
    Author     : javidgon
--%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert Category</title>
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
            @import "css/insert.css";
        </style>
        <script type="text/javascript" src="js/validation.js"></script>
    </head>
    <body>
        <% if (session.getAttribute("email") != null && (Integer) session.getAttribute("type") == 3) {%>
        <div id="header">
            <h1>iProductivity <span style="color:#302C29;"> Insert Category</span></h1>
            <span style="float:right;margin-bottom: 3%"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
        </div>
        <div class="insert">
            <table>
                <form action="iProductivityServlet" method="POST">
                    <tr><th>Name: </th><td> <input class="text" id ="nameCategory" name="name" size="30" type="text" onkeyup="validateCategory(this.value)"/></td><td><div id="messageCategory"></div></td></tr>
                    <tr><td><input type="submit" id="InsertCategory"name="Insert Category" value="Insert" disabled></td><td></td></tr>
                </form>
            </table>
            <br/>
            <br/>
            <%
             out.write("<a href=\"iProductivityServlet?init=1\"><img src=\"images/back.png\" alt=\"Imagen\"/></a>");%> </div> <%
                         }else{ %>
        <p>I'm sorry, but you don't have enough rights.</p>
                   <% } %>
    </body>
</html>
