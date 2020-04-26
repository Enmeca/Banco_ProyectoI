<%-- 
    Document   : TransaccionAdd
    Created on : 15/03/2020, 04:14:20 PM
    Author     : andre
--%>

<%@page import="java.util.Map"%>
<%@page import="banca.Logic.Cuenta"%>
<%@page import="banca.Presentacion.Cliente.Transaccion.Model"%>
<%
    Model model = (Model) request.getAttribute("model");
 
  Cuenta cuenta = model.getSeleccionado();
 Cuenta cuentafavorita = model.getSeleccionaamiga();
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
        <title>Transaccion</title>
    </head>
    <body>
   <%@ include file="/Presentacion/Encabezado.jsp" %>
   <div class="form-centro" style="align-content: center;">
      <form class="form-trans" action="/Banco_proyectoI/Presentacion/Cliente/Transaccion/Transaccion" method="POST">
          <h2>Transferencia</h2>
          <div class="form-group">
              <label for="micuenta">Mi cuenta:</label>
              <input  id="micuenta" type="text" name="txtMicuenta" value="<%=cuenta.getNumero() %>" readonly>
          </div>
          <div class="form-group">
              <label for="cuentadepo">cuenta a depositar:</label>
              <input  id="cuentadepo" type="text" name="txtCuentafavorita" value="<%=cuentafavorita.getNumero() %>" readonly>
          </div>
          <div class="form-group">
          <label for="monto1">Monto:</label>
          <input id="monto1" class="<%=this.feedback("txtMonto", errores) %>" type="text" name="txtMonto" placeholder="<%=this.placeholder("txtMonto", errores, "Monto a transferir") %>" required>
            <div class="invalid-feedback">
                <%=this.placeholder("txtMonto", errores, "Monto a transferir") %>
            </div>
        </div>
         <div class="form-group">
             <label for="desc-trans">Descripcion:</label>
             <input id="desc-trans" type="text" name="txtDescripcion" placeholder="Descripcion" required>
         </div>
          
         <center>  <input  type="submit" name="buttonenviar" value="Enviar"> </center>
          
      </form>
</div>
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

<%!
    private String feedback(String campo, Map<String,String> errores){
        if ( (errores!=null) && (errores.get(campo)!=null) )
            return("form-control is-invalid");
        else
            return("form-control");

    }
    %>