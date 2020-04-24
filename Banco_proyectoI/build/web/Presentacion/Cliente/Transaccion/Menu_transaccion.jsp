<%-- 
    Document   : Menu_transaccion
    Created on : 14/03/2020, 08:14:50 AM
    Author     : andre
--%>


<%@page import="banca.Logic.CuentaAmiga"%>
<%@page import="banca.Presentacion.Cliente.Transaccion.Model"%>
<%@page import="banca.Logic.Cuenta"%>
<%@page import="java.util.List"%>


<%
    Model model = (Model) request.getAttribute("model");
 
   List<Cuenta> cuentas = model.getCuentas();
   List<CuentaAmiga> cuentasamiga = model.getCuentasamigas();
%>
   
   


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
 <%@ include file="/Presentacion/link.jsp" %>
        <title>Transaccion-Cuenta favorita</title>
        <style>
        .formtrans {
background: rgba(6, 31, 143, 0.9);
padding: 40px;
max-width: 600px;
margin: 40px auto;
border-radius: 4px;
box-shadow: 0 4px 10px 4px rgba(6, 31, 143, 0.3);
color: whitesmoke;
}
        </style>
    </head>
    <body>
 
 
           
         <%@ include file="/Presentacion/Encabezado.jsp" %>
      
           <form name="formtrans" action="/Banco_proyectoI/Presentacion/Cliente/Transaccion/cuentas" method="POST">
               <div class="form-trans">
             <h2>Transferencia</h2>
             <p >Mis cuentas:</p>
             <select name="selectCuenta" >
                    <% for( Cuenta c:cuentas){%>
                    <option   value="<%=c.getNumero() %>"> <%=c.getNumero() %> </option>
                    <%}%>
        </select><br>
         </div>
        <h2>Numero de cuenta favorita:</h2>
      <table>
            <thead>
                <tr> <td>Numero Cuenta</td> <td>Cedula</td> <td>Nombre</td> <td>Moneda</td>  </tr>
            </thead>
            <tbody>
                        <% for(CuentaAmiga c:cuentasamiga){%>
                        <tr> <td class="td_button"><input  type="submit" name="numeroFld" value="<%=c.getVinculada().getNumero() %>"></td> 
                    <td> <%=c.getVinculada().getPersona().getCedula() %></td><td><%=c.getVinculada().getPersona().getNombre() %></td><td><%=c.getVinculada().getMoneda() %></td></tr>
                        <%}%>
            </tbody>
        </table>
                 </form>
            <%@ include file="/Presentacion/Footer.jsp" %>
    </body>
</html>
