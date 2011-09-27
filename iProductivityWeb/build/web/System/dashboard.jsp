<%-- 
    Document   : dashboard
    Created on : 13-may-2011, 17:18:22
    Author     : javidgon
--%>

<%@page import="model.Category"%>
<%@page import="java.util.Iterator"%>
<%@page import="model.iProductivity"%>
<%@page import="model.Task"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
        </style>
        <script type="text/javascript" src="js/counter.js"></script>
        <script type="text/javascript" src="js/validation.js"></script>
    </head>
    <body>

        <% if (session.getAttribute("email") != null) {
                        session.setAttribute("filter", null);
        %>
        <a name="up"></a>
        <div id="header">
            <h1>iProductivity  <span style="color:#302C29;">Dashboard</span></h1>
            <span style="float:right;margin-bottom: 3%;color:#8FB840;"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
        </div>
        <div class="dashboard">
            <%
                 if ((Integer) session.getAttribute("type") == 1) {  // Si es un usuario normal %>
            <h1> Welcome <%= session.getAttribute("email")%> !</h1>
            <% List<Task> tasks = iProductivity.consultaTasksForUser((String) session.getAttribute("email"));

                                 if (tasks.size() > 0) {
            %>
            <h1> My Tasks: </h1>

            <table>

                <%
                                         Iterator it1 = tasks.iterator();

                                         while (it1.hasNext()) {

                                             Task t = (Task) it1.next();

                                             if (!t.getDone().equalsIgnoreCase("Yes")) {

                                                 out.write("<tr><td>" + t.getDescription()
                                                         + "</td><td><form action=\"iProductivityServlet?TaskAccomplished=1\" method=\"post\"><input type=\"hidden\" value=\""
                                                         + t.getDescription() + "\" name=\"Tdescription\"><input type=\"hidden\" value=\"" + t.getUser()
                                                         + "\" name=\"Tuser\"> <input type=\"image\" src=\"images/do.png\" alt=\"Imagen\"></td></form></td><td><h1 id=\"txt\"></h1></td></tr>");

                                             }
                                         }
                                     } else {

                                         out.write("<div class=\"alert\">There aren't tasks yet.</div>");

                                     }

                %>
            </table>
            <%
                                 out.write("<img src=\"images/profile.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?EditUser=1&ownEmail=" + session.getAttribute("email") + "\">Edit my profile </a><br />");
                                 out.write("<img src=\"images/report.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?CreateIncident=1\">Report an Incident </a><br />");


                                 if (null != request.getParameter("success")) {%>

            <div id="success" class="success">Task was made successfully!</div>


            <%   } else if (null != request.getParameter("editedUser")) {%>


            <div id="info" class="info">User was edited successfully!</div>


            <%  }

                                 out.write("<a style=\" float:right; vertical-align:bottom;\" href=\"#up\"><img src=\"images/up.png\" alt=\"Imagen\"/></a>");



                             } else if ((Integer) session.getAttribute("type") == 2) { // Si es un administrador. %>
            <h1>Welcome <%=session.getAttribute("name")%>!</h1>
            <h1> Coordinator's Tools: </h1>
            <%

                                 out.write("<img src=\"images/newtask.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?Create=1\">Create a new Task </a><br />");
                                 out.write("<img src=\"images/users.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?AccessUsers=1\">View employees </a><br/>");
                                 out.write("<img src=\"images/tasks.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?AccessHistoricalTasks=1\">View employees' Tasks </a><br/>");
                                 out.write("<img src=\"images/ranking.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?AccessRanking=1\">View employees' Ranking </a><br/>");
                                 out.write("<img src=\"images/profile.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?EditUser=1&ownEmail=" + session.getAttribute("email") + "\">Edit my profile </a><br />");
                                 out.write("<img src=\"images/report.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?CreateIncident=1\">Report an Incident </a><br />");


                                 if (null != request.getParameter("success")) {%>

            <div id="success" class="success">Task was created successfully!</div>


            <%   } else if (null != request.getParameter("editedTask")) {%>


            <div id="info" class="info">Task was edited successfully!</div>


            <%  } else if (null != request.getParameter("editedUser")) {%>


            <div id="info" class="info">User was edited successfully!</div>


            <%  }




                            

                             } else { // Si es ROOT. %>

            <h1>Root Control panel</h1>

            <!-- USUARIOS -->

            <%
                                 out.write("<img src=\"images/newtask.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?CreateCategory=1\">Create a new Category </a><br />");
                                 out.write("<img src=\"images/users.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?AccessUsers=1\">View Users </a><br />");
                                 out.write("<img src=\"images/tasks.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?AccessHistoricalTasks=1\">View Tasks </a><br />");
                                 out.write("<img src=\"images/categories.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?AccessCategories=1\">View Categories </a><br />");
                                 out.write("<img src=\"images/viewreports.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?AccessIncidents=1\">View Incidents </a><br />");
                                 out.write("<img src=\"images/logs.png\" alt=\"Imagen\" />&nbsp;<a href=\"iProductivityServlet?AccessLogs=1\">View Logs </a>");


                                 if (null != request.getParameter("success")) {%>

            <div id="success" class="success">Category was created successfully!</div>


            <%   }
                            }



                        }  else{ %>
    <p>I'm sorry, but you don't have enough rights.</p>
                   <% }



                        


            %>
        </div>
    </body>
</html>
