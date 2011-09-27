<%-- 
    Document   : users
    Created on : 20-may-2011, 19:17:53
    Author     : javidgon
--%>

<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.iProductivity"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="model.User"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
            @import "css/insert.css";
        </style>
        <title>Users</title>
    </head>
    <body>
        <%
                    if (session.getAttribute("email") != null && (Integer) session.getAttribute("type") > 1) {%>
        <a name="up"></a>
        <div id="header">
            <h1>iProductivity <span style="color:#302C29;">Users</span></h1>
            <span style="float:right;margin-bottom: 3%"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
        </div>
        <div class="insert">
            <form action="iProductivityServlet" method="post">
                <table>
                    <tr>
                        <th colspan="2">Search by user</th>
                    </tr>
                    <tr>
                        <td>Email: </td>
                        <td><input type="text" name="email" value="" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" name="SearchUser" value="Search"/></td>
                    </tr>
                </table>
            </form>
            <form action="iProductivityServlet" method="post">
                <table>
                    <tr>
                        <th colspan="2">Search by Creation Time</th>
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
                        <td><input type="submit" name="FilterUser" value="Filter"/></td>
                    </tr>
                </table>
            </form>
            <br />
            <%
                                    List<User> users = null;
                                    if (session.getAttribute("filter").equals("") == true) {

                                        users = iProductivity.consultaUsers();

                                    } else if (session.getAttribute("filter").equals("SearchUser") == true) {

                                        users = new ArrayList<User>();
                                        users.add((User) session.getAttribute("User"));

                                    } else {

                                        users = (List) session.getAttribute("listUser");

                                    }

                                    if (users.size() > 1) {


            %>
            <table id="records">
                <tr>
                    <th>Email</th>
                    <th>Name</th>
                    <th>Surname</th>
                    <th>Creation Date</th>
                    <th>Type</th>
                    <th></th>
                    <th></th>
                </tr>

                <%

                                            Iterator it1 = users.iterator();
                                            Calendar d = new GregorianCalendar();
                                            while (it1.hasNext()) {

                                                User t = (User) it1.next();

                                                if ((Integer) session.getAttribute("type") == 2) { // Si es admin.

                                                    if (null != t.getBoss()) {

                                                        if (t.getBoss().equalsIgnoreCase((String) session.getAttribute("email")) && !t.getEmail().equalsIgnoreCase("root@iproductivity.com")) {



                                                            d.setTime(t.getCreation_date());
                                                            out.write("<tr><td style=\" font-style:italic;\">" + t.getEmail()
                                                                    + "</td><td>" + t.getName() + "</td><td>" + t.getSurname() + "</td><td> " + d.get(Calendar.YEAR) + " / " + d.get(Calendar.MONTH) + " / " + d.get(Calendar.DATE) + "</td><td>" + t.getType() + "</td>");

                                                            if (t.getType() == 1) {
                                                                out.write("<td colspan=\"2\"><a href=\"graphServlet?AccessCharts=1&chartEmail=" + t.getEmail() + "&typeChart=week\"><img src=\"images/ranking.png\" alt=\"\" /> </a></td>");

                                                            }
                                                            out.write("</tr>");
                                                        }
                                                    }

                                                } else if ((Integer) session.getAttribute("type") == 3) {

                                                    if (t.getType() != 3) {

                                                        d.setTime(t.getCreation_date());
                                                        out.write("<tr><td style=\" font-style:italic;\">" + t.getEmail()
                                                                + "</td><td>" + t.getName() + "</td><td>" + t.getSurname() + "</td><td> " + d.get(Calendar.YEAR) + " / " + d.get(Calendar.MONTH) + " / " + d.get(Calendar.DATE) + "</td><td>" + t.getType() + "</td>");


                                                        out.write("<form action=\"iProductivityServlet?DeleteUser=1\" method=\"post\"><input type=\"hidden\" name=\"Uemail\" value=" + t.getEmail() + " \" /><td><input type=\"image\" src=\"images/delete.png\" alt=\"Imagen\" onclick=\"onsubmit()\" /></td>");
                                                        if(null != t.getBoss()){
                                                            out.write("<td><a href=\"graphServlet?AccessCharts=1&chartEmail=" + t.getEmail() + "&typeChart=week\"><img src=\"images/ranking.png\" alt=\"\" /> </a></form></td>");
}

                                                        out.write("</tr>");

                                                    }

                                                }


                                            }
                                        } else {

                                            out.write("<div class=\"alert\">There aren't coordinators or employees yet.</div>");

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
