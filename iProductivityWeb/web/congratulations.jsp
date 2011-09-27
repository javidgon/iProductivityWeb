<%-- 
    Document   : congratulations
    Created on : 16-may-2011, 17:06:32
    Author     : javidgon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Congratulations</title>
        <style type="text/css">
            @import "css/login.css";
            @import "css/index.css";
            @import "css/header.css";
        </style>
    </head>
    <body>
        <% if (null != request.getParameter("CreatedAccount")) {%>
        <div id="header">
            <h1>iProductivity</h1>
        </div>
        <div class="login">
            <h1>Congratulations! Your account has been created!</h1>
            <h3><a href="index.jsp"> Access to your dashboard right now!</a></h3>
        </div>
        <%}  else{ %>
                       <div id="problem"><img src="images/trollface.png" alt="Problem?" width="70%" /><p>I'm sorry, but you don't have enough rights.</p> <span style="font-size:200%;font-weight: bold">Problem?</span></div>
                   <% } %>
    </body>
</html>
