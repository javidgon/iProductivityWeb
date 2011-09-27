<%-- 
    Document   : logs
    Created on : 16-may-2011, 14:12:01
    Author     : Hokasito
--%>

<%@page import="model.LogImpl"%>
<%@page import="java.util.Iterator"%>
<%@page import="model.Log"%>
<%@page import="java.util.List"%>
<%@page import="model.iProductivity"%>
<%@page import="servlet.iProductivityServlet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logs</title>
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
            @import "css/insert.css";
        </style>
    </head>
    <body>
        <%
                    if (session.getAttribute("email") != null && (Integer) session.getAttribute("type") == 3) {%>
        <a name="up"></a>
        <div id="header">
            <h1>iProductivity <span style="color:#302C29;">Logs</span></h1>
            <span style="float:right;margin-bottom: 3%"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
        </div>
        <div class="insert">
            <a name="up"></a> <form action="iProductivityServlet" method="post">
                <table>
                    <tr>
                        <th colspan="2">Search by user</th>
                    </tr>
                    <tr>
                        <td>Email</td><td> <select name="email">

                                <%
                                                        List<User> t = null;
                                                        t = iProductivity.consultaUsers();

                                                        Iterator it2 = t.iterator();

                                                        while (it2.hasNext()) {
                                                            User u = (User) it2.next();
                                                            if (u.getEmail() != "") {
                                                                out.write("<option value=\"" + u.getEmail() + "\">" + u.getEmail() + "</option>");
                                                            }


                                                        }
                                %>

                            </select> </td></tr>
                    <tr>
                        <td><input type="submit" name="SearchLog" value="Search"/></td>
                    </tr>
                </table>
            </form>
            <form action="iProductivityServlet" method="post">
                <table>
                    <tr>
                        <th colspan="2">Search by time</th>
                    </tr>
                    <tr>
                        <td>Time: </td>
                        <td>
                            <select name="time">
                                <option value="all">All</option>
                                <option value="today">Today</option>
                                <option value="week">Last Week</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="submit" name="FilterLog" value="Filter"/></td>
                    </tr>
                </table>
            </form>
            <br />
            <%
                                    List<Log> logs = null;
                                    if (session.getAttribute("filter").equals("") == true) {

                                        logs = iProductivity.consultaLogs();

                                    } else {

                                        logs = (List) session.getAttribute("listLog");

                                    }

                                    if (logs.size() > 0) {


            %>
            <table id="records">
                <tr>
                    <th>Message</th>
                    <th>User</th>
                    <th>Creation Date</th>
                    <th></th>
                </tr>


                <%

                                            Iterator it1 = logs.iterator();
                                            while (it1.hasNext()) {

                                                Log l = (Log) it1.next();

                                                out.write("<tr>"
                                                        + "<td style=\"font-style:italic\">" + l.getMessage() + "</td>"
                                                        + "<td>" + l.getUser() + "</td>"
                                                        + "<td>" + l.getCreation_date() + "</td>"
                                                        + "<td><form action=\"iProductivityServlet?DeleteLog=1\" method=\"post\">"
                                                        + "<input type=\"hidden\" value=\"" + l.getUser() + "\" name=\"user\" />" /* Parámetro oculto para el usuario. */
                                                        + "<input type=\"hidden\" value=\"" + l.getMessage() + "\" name=\"message\" />" /* Parámetro oculto para el mensaje. */
                                                        + "<input type=\"hidden\" value=\"" + l.getCreation_date().getTime() + "\" name=\"creation_date\" />" /* Parámetro oculto para la fecha de creación. */
                                                        + "<input type=\"image\" src=\"images/delete.png\" onclick=\"submit()\" />"
                                                        + "</form></td>"
                                                        + "</tr>");

                                            }

                                        } else {

                                            out.write("<div class=\"alert\">There aren't logs yet.</div>");

                                        }

                %>

            </table>
            <br/>
            <br/>
            <%
                                    out.write("<a href=\"iProductivityServlet?init=1\"><img src=\"images/back.png\" alt=\"Imagen\"/></a>&nbsp;<a style=\" float:right;\" href=\"#up\"><img src=\"images/up.png\" alt=\"Imagen\"/></a>");%>
        </div>
        <%

                    }  else{ %>
           <p>I'm sorry, but you don't have enough rights.</p>
                   <% } 
        %>

    </body>
</html>
