<%--
    Document   : GetAllTasks
    Created on : Aug 31, 2012, 11:17:34 AM
    Author     : rao
--%>

<%@page import="itu.dk.smds.e2013.common.TasksJDOMParser" %>
<%@page import="itu.dk.smds.e2013.servlets.GetAllTasksServlet" %>
<%@page import="org.jdom2.Document" %>
<%@page import="org.jdom2.JDOMException" %>
<%@page import="org.jdom2.output.XMLOutputter" %>
<%@page import="java.io.InputStream" %>
<%@page import="java.util.List" %>
<%@page import="java.util.logging.Level" %>
<%@page import="java.util.logging.Logger" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Get All Tasks</title>
</head>
<body>
<h1>Available users:</h1>

<%
    InputStream xmlStream = getServletContext().getResourceAsStream("/WEB-INF/task-manager-xml.xml");
%>

<form name="task_id_form" action="getByUser.jsp" method="post">

    <%
        try {
            String query = "//attendants";

            List<String> attendants = TasksJDOMParser.getUsers(xmlStream);
            for (String attendant : attendants) {
    %>        	
    <%=attendant %><br>
    <%
            }

        } catch (JDOMException ex) {
            Logger.getLogger(GetAllTasksServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    %>
    <input type="text" name="attendant">
    <input type="submit" value="Show task">
</form>

<% if("POST".equalsIgnoreCase(request.getMethod())) {%>
<textarea id="txtAreaTaskXml" cols="100" rows="30">

    <%

        try {
            InputStream xml = getServletContext().getResourceAsStream("/WEB-INF/task-manager-xml.xml");
            String query = "//task[contains(attendants,\""+request.getParameter("attendant").toString()+"\")]";

            Document tasksDoc = TasksJDOMParser.getTasksByQuery(xml, query);

            new XMLOutputter().output(tasksDoc, out);
            
        } catch (JDOMException ex) {
            Logger.getLogger(GetAllTasksServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    %>

</textarea>

<%}%>

</body>
</html>
