<%-- 
    Document   : index
    Created on : 11-may-2011, 16:43:59
    Author     : javidgon
--%>

<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="model.TaskImpl"%>
<%@page import="model.LogImpl"%>
<%@page import="model.Log"%>
<%@page import="model.Task"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.iProductivity"%>
<%@page import="model.CategoryImpl"%>
<%@page import="model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iProductivity</title>
        <script type="text/javascript" src="js/validation.js"></script>
        <style type="text/css">
            @import "css/login.css";
            @import "css/index.css";
            @import "css/header.css";
        </style>
    </head>
    <body>
        <div id="header">
            <h1>iProductivity</h1>
        </div>
        <div class="index">
            <fieldset>
                <legend>Log in</legend>
                <table>
                    <form action="validationServlet" method="POST">
                        <tr><th>Email: </th> <td><input class="text" name="iemail" size="30" type="text" /></td></tr>
                        <tr><th>Password: </th> <td><input class="text" name="ipassword" size="30" type="password" /></td></tr>
                        <tr><td colspan="2"><% if(null != session.getAttribute("loginError")){ out.write("<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noPassword\" style=\"color: red; font-family:verdana \"> You've been banned. You must wait 15 minutes</span>"); }else if(null != session.getAttribute("attempts")) { if(Integer.parseInt(String.valueOf(session.getAttribute("attempts"))) < 3){out.write("<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noPassword\" style=\"color: red; font-family:verdana \"> Invalid user or password</span>");}}%></td></tr>
                        <tr><td><input type="submit" value="Enter" name="login" ></td><td></td></tr>
                    </form>
                </table>
                <p><img src="images/signup.png" alt="Imagen" />&nbsp;<a href="iProductivityServlet?registration=1" >Sign up here!</a></p>
            </fieldset>
        </div>

        <div class="footer">All rights reserved 2011. IProductivity</div>
    </body>
</html>
