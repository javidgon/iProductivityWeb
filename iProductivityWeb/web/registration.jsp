<%-- 
    Document   : registration
    Created on : 13-may-2011, 17:10:39
    Author     : javidgon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
        <script type="text/javascript" src="js/validation.js"></script>
        <style type="text/css">
            @import "css/login.css";
            @import "css/index.css";
            @import "css/header.css";
        </style>
        <script type="text/javascript" src="js/validation.jsp"></script>
    </head>
    <body>
        <div id="header">
            <h1>iProductivity</h1>
        </div>
        <div class="login">
            <h1>Sign Up</h1>
            <table>
                <form action="iProductivityServlet" method="POST" onsubmit="return valida(this)" >
                    <tr><th>Email: </th><td><input class="text" id="email" name="email" size="30" type="text" onkeyup="validateEmail(this.value)"/></td><td><div id="messageEmail"></div></td></tr>
                    <tr><th>Password: </th><td><input class="text" id="password" name="password" size="30" type="password" onkeyup="validatePass(this.value)" /></td><td><div id="messagePass"></div></td></tr>
                    <tr><th>Re-Password: </th><td><input class="text" id="repassword" name="repassword" size="30" type="password" onkeyup="validateRepass(this.value)" /></td><td><div id="messageRepass"></div></td></tr>
                    <tr><th>Name: </th><td><input class="text" id="name" name="name" size="30" type="text" onkeyup="validateName(this.value)"/></td><td><div id="messageName"></div></td></tr>
                    <tr><th>Surname: </th><td><input class="text" id="surname" name="surname" size="30" type="text" /></td></tr>
                    <tr><th>Type: </th><td>
                            <select name="type" onchange="status(this)" >
                                <option>Employee</option>
                                <option>Coordinator</option>
                            </select></td></tr>
                    <tr><th>Boss: </th><td> <select name="boss" id="boss">

                                <% List<User> l = iProductivity.consultaUsersByType(2);%>

                                <% Iterator it1 = l.iterator();

                                            while (it1.hasNext()) {

                                                User u = (User) it1.next();
                                                out.write("<option value=\"" + u.getEmail() + "\">" + u.getEmail() + "</option>");


                                            }
                                %>

                            </select> </tr>
                    <tr><td><input type="submit" id="SignUp" value="Sign Up" name="Sign Up" disabled></td><td></td></tr>
                </form>
            </table>
            <br/>
            <br/>
            <a href="index.jsp"><img src="images/back.png" alt="Imagen"/></a>
        </div>
    </body>
</html>
