<%-- 
    Document   : editUser
    Created on : 17-may-2011, 17:30:48
    Author     : javidgon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit User</title>
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
            @import "css/insert.css";
        </style>
        <script type="text/javascript" src="js/validation.js"></script>
    </head>
    <body>
        <% if (session.getAttribute("email") != null) {%>
        <div id="header">
            <h1>iProductivity <span style="color:#302C29;">Edit User</span></h1>
            <span style="float:right;margin-bottom: 3%"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
        </div>
        <div class="insert">
            <table>
                <form action="iProductivityServlet" method="POST">
                    <tr><th>Email: </th><td> <%= session.getAttribute("Uemail")%></td></tr>
                    <tr><th>Name: </th><td> <input class="text" type="text" name="Uname" value="<%= session.getAttribute("Uname")%>"/></td></tr>
                    <tr><th>Surname: </th><td> <input class="text" type="text" name="Usurname"value="<%= session.getAttribute("Usurname")%>"/></td></tr>
                    <tr><th>Old Password: </th><td> <input class="text" type="password" id="oldpassword"  name="Uoldpassword" onkeyup="validateOldPass(this.value)"/></td><td><div id="messageOldPass"></div></td></tr>
                    <tr><th>New Password: </th><td> <input class="text" type="password" id="password" name="Unewpassword" onkeyup="validatePassEdit(this.value)" /></td><td><div id="messagePass"></div></td></tr>
                    <tr><th>Retype new Password: </th><td> <input class="text" type="password" id="repassword" name="Unewpassword2" onkeyup="validateRepassEdit(this.value)" /></td><td><div id="messageRepass"></div></td></tr>
                    <tr><th>Type: </th><td><%= session.getAttribute("Utype")%></td></tr>
                    <% if ((Integer) session.getAttribute("Utype") == 1) {%>
                    <tr><th>Boss: </th><td><%= session.getAttribute("Uboss")%></td></tr>
                    <% }%>
                    <tr><td><input type="submit" id="Finish User" value="Edit" name="Finish User" disabled></td><td></td></tr>
                </form>
            </table>
            <br/>
            <br/>
            <%
                 out.write("<a href=\"iProductivityServlet?init=1\"><img src=\"images/back.png\" alt=\"Imagen\"/></a>");
            %>
        </div>
        <%
                    }else{ %>
          <p>I'm sorry, but you don't have enough rights.</p>
                   <% } %>
    </body>
</html>
