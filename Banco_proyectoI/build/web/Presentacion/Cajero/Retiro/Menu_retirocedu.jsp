<%-- 
    Document   : Cedula_deposito
    Created on : 17/03/2020, 08:06:09 PM
    Author     : andre
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="banca.Logic.Cuenta"%>
<%@page import="banca.Presentacion.Cajero.Retiro.Model"%>
<%
    Model model = (Model) request.getAttribute("model");
    List<Cuenta> cuentas=null;
    if(model!=null)
    {  cuentas = model.getCuentas();}
    
%>
<%
    Map<String,String> errores=null;
if(model!=null)
 errores = (Map<String,String>) request.getAttribute("errores"); 
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       
        <%@ include file="/Presentacion/link.jsp" %>
        <title>Retiro-Cliente</title>
    </head>
    <body>
         <%@ include file="/Presentacion/Encabezado.jsp" %>
         <%if(cuentas==null) {%>
         <form class="form_inicio" action="/Banco_proyectoI/Presentacion/Cajero/Retiro/showcuentas" method="POST">
             <h2>Retiro</h2> 
             <p>Cedula:</p><input class="<%=this.Invalida("txtCedula", errores) %>" type="text" name="txtCedula" placeholder="<%=this.placeholder("txtCedula", errores, "Cedula cliente") %>"> <br> <br>
               <center> <input  type="Submit" name="Enviar" value="Enviar"> </center>
               
         </form>
              <%}%>
               <%if(cuentas!=null) {%>
               <form action="/Banco_proyectoI/Presentacion/Cajero/Retiro/add" method="POST">
                   <div class="form_inicio">
                       <h2>Retiro</h2>
                   <p>Monto:</p><input class="<%=this.Invalida("txtMonto", errores) %>" type="text" name="txtMonto" placeholder="<%=this.placeholder("txtMonto", errores, "Monto") %>">
                  </div>
                   <h2>Cuenta cliente</h2>
                <table>
            <thead>
                <tr> <td>Numero</td> <td>Cedula</td>  <td>Nombre</td> <td>Moneda</td> </tr>
            </thead>
            <tbody>
                        <% for(Cuenta c:cuentas){%>
                        <tr> <td class="td_button"><input  type="Submit" name="Buttoncuenta" value="<%=c.getNumero()%>"> </td>  <td><%=c.getPersona().getCedula() %></td> <td><%=c.getPersona().getNombre() %> </td><td><%=c.getMoneda() %></td></tr>
                        <%}%>
            </tbody>
        </table>
            </form>
              <%}%>
              <%@ include file="/Presentacion/Footer.jsp" %>
    </body>
</html>
<%!
   private String placeholder(String campo, Map<String,String> errores,String mensaje){
      if ( (errores!=null) && (errores.get(campo)!=null) )
        return errores.get(campo);
      else
        return mensaje;
    }
%>
<%!
   private String Invalida(String campo, Map<String,String> errores){
      if ( (errores!=null) && (errores.get(campo)!=null) )
        return "Invalida";
      else
        return "";
    }
%>