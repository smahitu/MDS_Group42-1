<%--
    Document   : GetAllTasks
    Created on : Aug 31, 2012, 11:17:34 AM
    Author     : rao
--%>

<%@page import="itu.dk.smds.e2013.common.TasksJDOMParser" %>
<%@page import="itu.dk.smds.e2013.servlets.GetAllTasksServlet" %>
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
<h1>Available tasks:</h1>

<%
    InputStream xmlStream = getServletContext().getResourceAsStream("/WEB-INF/task-manager-xml.xml");
%>

<label id="labelTaskIds" cols="100" rows="30">

    <%
        try {
            String query = "//task";

            List<String> taskIds = TasksJDOMParser.getTaskIds(xmlStream);
            for (String taskId : taskIds) {
                %>
    taskId
                <%
            }

        } catch (JDOMException ex) {
            Logger.getLogger(GetAllTasksServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    %>


</label>

</body>
</html>
