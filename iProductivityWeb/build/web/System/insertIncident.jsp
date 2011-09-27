<%-- 
    Document   : insertIncident
    Created on : 20-may-2011, 15:33:07
    Author     : javidgon
--%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report Incident</title>
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
            @import "css/insert.css";
        </style>
    </head>
    <body>
        <% if (session.getAttribute("email") != null) {%>
        <div id="header">
            <h1>iProductivity <span style="color:#302C29;"> Report Incident</span></h1>
            <span style="float:right;margin-bottom: 3%"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
        </div>
        <div class="insert">
        <table>
            <form action="iProductivityServlet" method="POST">
                <tr><th>User: </th><td><%= session.getAttribute("email")%></td></tr>
                <tr><th>Message: </th><td><textarea cols="10" rows="30" name="message"></textarea>

                <tr><td><input type="submit" value="Send" name="InsertIncident"></td><td></td></tr>
            </form>
        </table>
            <br/>
            <br/>
        <%

                       out.write("<a href=\"iProductivityServlet?init=1\"><img src=\"images/back.png\" alt=\"Imagen\"/></a>"); %></div><%
                    } else{ %>
               <p>I'm sorry, but you don't have enough rights.</p>
                   <% } %>
    </body>
</html>
