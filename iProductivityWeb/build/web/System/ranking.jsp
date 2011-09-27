<%-- 
    Document   : ranking
    Created on : 28-may-2011, 7:53:29
    Author     : Hokasito
--%>

<%@page import="model.CoefficientComparator"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.Graphs"%>
<%@page import="java.util.Iterator"%>
<%@page import="model.iProductivity"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ranking</title>
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
            @import "css/insert.css";
        </style>
    </head>
    <body>
        <%
                    if (session.getAttribute("email") != null && (Integer)session.getAttribute("type") > 1) {
                        int counter = 0;
                        String valoration = "";
                        TreeMap<String, Double> sorted_map = (TreeMap) session.getAttribute("sortedMap");

        %>
        <div id="header">
            <h1>iProductivity <span style="color:#302C29;">Ranking</span></h1>
            <span style="float:right;margin-bottom: 3%"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
        </div>
        <% if(sorted_map.size() > 0){%>

        <div class="insert">
            <table id="ranking">
                <tr>
                    <th></th>
                    <th>User</th>
                    <th>Coefficient</th>
                    <th id="image" rowspan="<%= sorted_map.size() + 1%>"><img src="graphServlet?ViewRankingChart=1.jsp" alt="Imagen" /></th>
                </tr>
                <%

                                        for (String key : sorted_map.keySet()) {

                                                if (sorted_map.get(key) >= 0.25) {
                                                    valoration = "<span style=\"color:green; font-weight:bold;\">High Productivity</span>";
                                                } else if (sorted_map.get(key) >= 0.208) {
                                                    valoration = "<span style=\"color:green;\">Good Productivity</span>";

                                                } else if (sorted_map.get(key) >= 0.166) {
                                                    valoration = "<span style=\"color:orange;\">Low Productivity</span>";

                                                } else {
                                                    valoration = "<span style=\"color:red;\">Spanish Productivity</span>";

                                                }

                                                counter++;
                                                out.write("<tr><td>" + counter + "</td><td>" + key + "</td><td>" + String.format("%.5f", sorted_map.get(key)) + " " + valoration + "  </td></tr>");
                                            
                                        }


                                        } else {

                                            out.write("<div class=\"alert\">There isn't enough data for creating the ranking.</div>");

                                        }


                %>
            </table>

            <br />
            <br/>
            <%

                                    out.write("<a href=\"iProductivityServlet?init=1\"><img src=\"images/back.png\" alt=\"Imagen\"/></a>");%>
        </div>

        <%

                    }  else{ %>
             <p>I'm sorry, but you don't have enough rights.</p>
                   <% }
        %>

    </body>
</html>

