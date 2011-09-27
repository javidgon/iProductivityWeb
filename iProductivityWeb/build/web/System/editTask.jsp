<%-- 
    Document   : editTask
    Created on : 16-may-2011, 14:42:07
    Author     : javidgon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Task</title>
        <script type="text/javascript" src="../js/validation.js"></script>
        <style type="text/css">
            @import "css/index.css";
            @import "css/header.css";
            @import "css/insert.css";
        </style>
        <script type="text/javascript" src="js/validation.js"></script>
    </head>
    <body>
        <% if (session.getAttribute("email") != null && (Integer)session.getAttribute("type") > 1) {
        Calendar d = new GregorianCalendar();
        d.setTimeInMillis(Long.valueOf((String)session.getAttribute("Tcreation_date")));
    %>
        <div id="header">
            <h1>iProductivity <span style="color:#302C29;">Edit Task</span></h1>
            <span style="float:right;margin-bottom: 3%"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
        </div>
        <div class="insert">
            <table>
                <form action="iProductivityServlet" method="POST">
                    <tr><th>Description: </th><td><input type="text" class="text" id="description" name="description" value="<%= session.getAttribute("Tdescription")%>" disabled </td><td><div id="yesDescription"></div></td></tr>
                    <tr><th>Category: </th><td> <input type="text" class="text" id="type" name="type" value="<%= session.getAttribute("Ttype")%>" disabled /></td></tr>
                    <tr><th>Hours: </th><td> <input type="text" class="text" id="hours" name="hours"value="<%= session.getAttribute("Thours")%>" onkeyup="validateHours(this.value)"/></td><td><div id="messageHours"></div></td></tr>
                    <tr><th>Minutes: </th><td> <input type="text" class="text" id="minutes" name="minutes"value="<%= session.getAttribute("Tminutes")%>" onkeyup="validateMinutes(this.value)"/></td><td><div id="messageMinutes"></div></td></tr>
                    <tr><th>Creation Date: </th><td><%= d.getTime() %></td></tr>
                    <tr><th>User: </th><td><%= session.getAttribute("Tuser")%></td></tr>
                    <tr><th>Done: </th><td><input type="radio" name="done" value="Yes">Yes<br>
                            <input type="radio" name="done" value="No" checked>No</td></tr>
                    <tr><td><input type="submit" id="InsertTask"value="Finish" name="Finish"></td><td></td></tr>
                </form>
            </table>
                    <br/>
                    <br/>
            <%
                 out.write("<a href=\"iProductivityServlet?AccessHistoricalTasks=1\"><img src=\"images/back.png\" alt=\"Imagen\"/></a>"); %>
        </div>
            <%  }else{ %>
               <p>I'm sorry, but you don't have enough rights.</p>
                   <% } %>
    </body>
</html>
