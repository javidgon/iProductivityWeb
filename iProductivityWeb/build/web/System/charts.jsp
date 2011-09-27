<%-- 
    Document   : charts
    Created on : 26-may-2011, 17:36:19
    Author     : javidgon
--%>

<%@page import="model.Graphs"%>
<%@page import="model.User"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Iterator"%>
<%@page import="model.iProductivity"%>
<%@page import="model.iProductivity"%>
<%@page import="java.util.List"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Charts</title>
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
            @import "css/insert.css";
        </style>
    </head>
    <body>
        <%
                    if (session.getAttribute("email") != null && (Integer)session.getAttribute("type") > 1) {%>
        <div id="header">
            <h1>iProductivity <span style="color:#302C29;">Charts</span></h1>
            <span style="float:right;margin-bottom: 3%"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
        </div>
        <div class="insert">
            <form action="graphServlet" method="get">
                <table>
                    <tr>
                        <th>Coefficient Vidal-Vera: </th><td><%= String.format("%.5f",Graphs.calculateCoefficient((String)session.getAttribute("chartEmail"))) %></td>
                    </tr>
                    <tr>
                        <th colspan="2">Show</th>
                    </tr>
                    <tr>
                    <input type="hidden" name="chartEmail" value="<%= session.getAttribute("chartEmail")%>"/>
                        <td>Chart</td><td> <select name="typeChart">
                                <option value="week">Weekly Productivity (Tasks/Days)</option>
                                <option value="month">Monthly Productivity (Tasks/Days)</option>
                                <option value="global">Business Productivity</option>
                            </select> </td></tr>
                    <tr>
                        <td><input type="submit" name="AccessCharts" value="Show"/></td>
                    </tr>
                </table>
            </form>

            <br />

            <img src="graphServlet?ViewUserChart=1.jsp" alt="Imagen" />


            <br/>
            <br/>
            <%
                                    out.write("<a href=\"iProductivityServlet?AccessUsers=1\"><img src=\"images/back.png\" alt=\"Imagen\"/></a>");%>
        </div>
        <%

                    } else{ %>
                       <p>I'm sorry, but you don't have enough rights.</p>
                   <% }
        %>

    </body>
</html>

