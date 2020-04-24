<%-- 
    Document   : Exitosa
    Created on : 16/04/2020, 01:00:48 PM
    Author     : andre
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   
String mensaje =  (String) request.getAttribute("mensaje"); 
%>
<html>
    <head>
        <%@ include file="/Presentacion/link.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <title>Exitosa</title>
    </head>
    <body>
         <%@ include file="/Presentacion/Encabezado.jsp" %> 
        
         <h2><%=mensaje%></h2>
         
        <center><a href="/Banco_proyectoI/Presentacion/Inicio.jsp"><input  type="button" name="txtmenu" value="Menu"></a></center>
        <%@ include file="/Presentacion/Footer.jsp" %>
    </body>
</html>
