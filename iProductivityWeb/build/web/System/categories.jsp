<%-- 
    Document   : categories
    Created on : 21-may-2011, 12:36:41
    Author     : javidgon
--%>

<%@page import="model.iProductivity"%>
<%@page import="model.Category"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page session="true" import="java.util.*, model.*,servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Categories</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">
            @import "css/dashboard.css";
            @import "css/index.css";
            @import "css/header.css";
            @import "css/insert.css";
        </style>
</head>
<body>
    <%    if (session.getAttribute("email") != null && (Integer)session.getAttribute("type") == 3) {%>
    <div id="header">
        <h1>iProductivity <span style="color:#302C29;">Categories</span></h1>
        <span style="float:right;margin-bottom: 3%;color:#8FB840;"><h3 id="general"></h3><a href="iProductivityServlet?exit=1"><img src="images/logout.png" width="40px"alt="Logout" /></a></span>
    </div>
    <div class="insert">
        <table>
        <%
        List<Category> categories = iProductivity.consultaCategories();
        Iterator it2 = categories.iterator();

        if(categories.size() > 0){

                        while (it2.hasNext()) {

                            Category c = (Category) it2.next();

                            out.write("<tr><td>" + c.getName()
                                    + "</td><td><form action=\"iProductivityServlet?Remove+Category\" method=\"post\">"
                                    + "<input type=\"hidden\" value=\"" + c.getName()
                                    + "\" name=\"Cname\"><input type=\"image\" src=\"images/delete.png\"></form></td></tr>");


                        }

}else{

    out.write("<div class=\"alert\">There aren't categories yet.</div>");

}




                %>
        </table>
                        <br/>
                        <br/>
                        <%
                        out.write("<a href=\"iProductivityServlet?init=1\"><img src=\"images/back.png\" alt=\"Imagen\"/></a>"); %>
    </div> <%
                    } else { %>
                       <p>I'm sorry, but you don't have enough rights.</p>
                   <% }
        %>

        
</body>
</html>
