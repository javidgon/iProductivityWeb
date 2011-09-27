<%-- 
    Document   : insertTask
    Created on : 16-may-2011, 12:36:13
    Author     : javidgon
--%>

<%@page import="model.Category"%>
<%@page import="java.util.Iterator"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="model.iProductivity"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert Task</title>
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
            @import "css/insert.css";
        </style>
        <script type="text/javascript" src="js/validation.js"></script>
    </head>
    <body>

        <% if (session.getAttribute("email") != null && (Integer)session.getAttribute("type") > 1) {%>
        <div id="header">
            <h1>iProductivity <span style="color:#302C29;"> Insert Task</span></h1>
            <span style="float:right;margin-bottom: 3%"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
        </div>
        <div class="insert">
        <table>
            <form action="iProductivityServlet" method="POST">
                <tr><th>Description: </th><td><input class="text" id ="description" name="description" size="30" type="text"  onkeyup="validateDescription(this.value)"/></td><td><div id="messageDescription"></div></td></tr>
                <tr><th>Category: </th><td> <select name="type" id="type">

                            <% List<Category> c = iProductivity.consultaCategories();%>

                            <% Iterator it1 = c.iterator();

                                 while (it1.hasNext()) {

                                     Category ca = (Category) it1.next();
                                     out.write("<option value=\"" + ca.getName() + "\">" + ca.getName() + "</option>");


                                 }
                            %>

                        </select> </td></tr>
                <tr><th>Hours: </th><td><input class="text" id ="hours" name="hours" size="10" type="text"  onkeyup="validateHours(this.value)"/></td><td><div id="messageHours"></div></td></tr>
                <tr><th>Minutes: </th><td><input class="text" id ="minutes" name="minutes" size="10" type="text" onkeyup="validateMinutes(this.value)" /></td><td><div id="messageMinutes"></div></td></tr>
                <tr><th>Employee: </th><td> <select id="employee" name="user" onchange=" validateDescription(document.getElementById('description').value)" >

                            <% List<User> l = iProductivity.consultaUsersByCoordinator((String)session.getAttribute("email"));%>

                            <% Iterator it2 = l.iterator();

                                 while (it2.hasNext()) {
                                     User u = (User) it2.next();
                                     if (u.getEmail() != "") {
                                         out.write("<option value=\"" + u.getEmail() + "\">" + u.getEmail() + "</option>");
                                     }


                                 }
                            %>

                        </select> </td></tr>
                <tr><td><input type="submit" value="Insert" name="Insert" id ="InsertTask" disabled></td><td></td></tr>
            </form>
        </table>
            <br/>
            <br/>
        <%

                       out.write("<a href=\"iProductivityServlet?init=1\"><img src=\"images/back.png\" alt=\"Imagen\"/></a>"); %></div><%
                    }  else{ %>
          <p>I'm sorry, but you don't have enough rights.</p>
                   <% } %>
    </body>
</html>
