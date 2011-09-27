<%-- 
    Document   : loading
    Created on : 21-may-2011, 12:55:46
    Author     : javidgon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Loading...</title>
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
            @import "css/login.css";
        </style>
        <script type="text/javascript" src="js/counter.js"></script>
    </head>
    <body onload="progress()">
        <%    if (session.getAttribute("email") != null) {%>
        <div id="header">
            <h1>iProductivity <span style="color:#302C29;"></span></h1>
            
        </div>
        <div class="login">
            <h1 id="txt" >Loading </h1>
            <h3 id="explanation"></h3>
        </div>
        <%} %>
    </body>
</html>
