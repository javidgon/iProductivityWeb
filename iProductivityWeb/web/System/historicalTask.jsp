<%-- 
    Document   : tasks
    Created on : 16-may-2011, 14:12:01
    Author     : Hokasito
--%>

<%@page import="model.TaskImpl"%>
<%@page import="java.util.Iterator"%>
<%@page import="model.Task"%>
<%@page import="java.util.List"%>
<%@page import="model.iProductivity"%>
<%@page import="servlet.iProductivityServlet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historical of tasks</title>
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
            @import "css/insert.css";
        </style>
    </head>
    <body>
        <%
                    if (session.getAttribute("email") != null && (Integer) session.getAttribute("type") > 1) {%>
        <a name="up"></a>
        <div id="header">
            <h1>iProductivity <span style="color:#302C29;">Historical of tasks</span></h1>
            <span style="float:right;margin-bottom: 3%"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
        </div>
        <div class="insert">
            <form action="iProductivityServlet" method="post">
                <table>
                    <tr>
                        <th colspan="2">Search by user</th>
                    </tr>
                    <tr>
                        <td>Email</td><td> <select name="email">

                                <%
                                                        List<User> l = null;
                                                        if ((Integer) session.getAttribute("type") == 3) {
                                                            l = iProductivity.consultaUsersByType(1);

                                                        } else {
                                                            l = iProductivity.consultaUsersByCoordinator((String) session.getAttribute("email"));

                                                        }

                                                        Iterator it2 = l.iterator();

                                                        while (it2.hasNext()) {
                                                            User u = (User) it2.next();
                                                            if (u.getEmail() != "") {
                                                                out.write("<option value=\"" + u.getEmail() + "\">" + u.getEmail() + "</option>");
                                                            }


                                                        }
                                %>

                            </select> </td></tr><tr>
                        <td><input type="submit" name="SearchTask" value="Search"/></td>
                    </tr>
                </table>
            </form>
            <form action="iProductivityServlet" method="post">
                <table>
                    <tr>
                        <th colspan="2">Search by time</th>
                    </tr>
                    <tr>
                        <td>Time</td>
                        <td>
                            <select name="time">
                                <option value="all">All</option>
                                <option value="today">Today</option>
                                <option value="week">Last Week</option>
                            </select>
                        </td></tr><tr>
                        <td><input type="submit" name="FilterTask" value="Filter"/></td>
                    </tr>
                </table>
            </form>
            <br />

            <%
                                    List<Task> tasks = null;
                                    List<User> users = null;
                                    boolean flag = false;
                                    if ((Integer) session.getAttribute("type") == 2) {
                                        users = iProductivity.consultaUsersByCoordinator((String) session.getAttribute("email"));
                                    } else {
                                        users = iProductivity.consultaUsers();
                                    }



                                    if (session.getAttribute("filter").equals("") == true) {
                                        tasks = iProductivity.consultaTasks();
                                    } else {
                                        tasks = (List) session.getAttribute("listTask");
                                    }

                                    if (tasks.size() > 0) {


                                        Iterator it1 = tasks.iterator();
                                        Calendar d = new GregorianCalendar();
                                        while (it1.hasNext()) {

                                            Task t = (Task) it1.next();

                                            Iterator u1 = users.iterator();


                                            while (u1.hasNext()) {

                                                User uv = (User) u1.next();

                                                if (uv.getEmail().equals(t.getUser())) {

                                                    if (flag != true) {

            %>
            <table id="records">
                <tr>
                    <th>Description</th>
                    <th>Minutes</th>
                    <th>User</th>
                    <th>Done</th>
                    <th>Creation Date</th>
                    <th></th>
                    <th></th>
                </tr>



                <%
                                                            flag = true;






                                                        }





                                                        d.setTime(t.getCreation_date());


                                                        out.write("<tr>"
                                                                + "<td style=\" font-style:italic\">" + t.getDescription() + "</td>"
                                                                + "<td>" + t.getMinutes() + "</td>"
                                                                + "<td>" + t.getUser() + "</td>"
                                                                + "<td>" + t.getDone() + "</td>"
                                                                + "<td>" + d.get(Calendar.YEAR) + " / " + d.get(Calendar.MONTH) + " / " + d.get(Calendar.DATE) + "</td>"
                                                                + "<td><form action=\"iProductivityServlet?Edit=1\" method=\"post\"><input type=\"hidden\" value=\""
                                                                + t.getDescription() + "\" name=\"Tdescription\"><input type=\"hidden\" value=\"" + t.getUser()
                                                                + "\" name=\"Tuser\"><input type=\"hidden\" value=\"" + t.getType()
                                                                + "\" name=\"Ttype\"><input type=\"hidden\" value=\"" + t.getDone()
                                                                + "\" name=\"Tdone\"><input type=\"hidden\" value=\"" + t.getMinutes()
                                                                + "\" name=\"Tminutes\"><input type=\"hidden\" value=\"" + t.getCreation_date().getTime()
                                                                + "\" name=\"Tcreation_date\"><input type=\"image\" src=\"images/edit.png\"></form>"
                                                                + "</td><td><form action=\"iProductivityServlet?Remove=1\" method=\"post\">"
                                                                + "<input type=\"hidden\" value=\"" + t.getUser() + "\" name=\"Tuser\" />" /* Parámetro oculto para el usuario. */
                                                                + "<input type=\"hidden\" value=\"" + t.getDescription() + "\" name=\"Tdescription\" />" /* Parámetro oculto para la descripción. */
                                                                + "<input type=\"image\" src=\"images/delete.png\" />"
                                                                + "</form></td>"
                                                                + "</tr>");
                                                    }
                                                }
                                            }

                                            if (flag == false) {



                                                out.write("<div class=\"alert\">There aren't tasks yet.</div>");




                                            }




                                        } else {

                                            out.write("<div class=\"alert\">There aren't tasks yet.</div>");

                                        }

                %>

            </table>
            <br/>
            <br/> 
            <%
                                    out.write("<a href=\"iProductivityServlet?init=1\"><img src=\"images/back.png\" alt=\"Imagen\"/></a>&nbsp;<a style=\" float:right;\" href=\"#up\"><img src=\"images/up.png\" alt=\"Imagen\"/></a>");%>
        </div>
        <%

                    } else{ %>
                      <p>I'm sorry, but you don't have enough rights.</p>
                   <% }
        %>

    </body>
</html>

