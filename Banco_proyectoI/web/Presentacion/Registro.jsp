<%-- 
    Document   : Registro
    Created on : 03/03/2020, 08:01:45 PM
    Author     : andre
--%>

<%@page import="banca.Presentacion.Cajero.Model"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
 Model model = (Model) request.getAttribute("model");
    Map<String,String> errores=null;
if(model!=null)
 errores = (Map<String,String>) request.getAttribute("errores"); 
%>
<!DOCTYPE html>
<html>
    <head>
         <%@ include file="link.jsp" %>
        <title>Registro</title>
    </head>
    <body>
          <%@ include file="Encabezado.jsp" %>
          <div class="login">
          <form class="form-signin"    action="/Banco_proyectoI/Presentacion/Cajero/show" method="POST">
               <h2>Registro</h2>
                <div class="form-row">
                    <label for="Cedula01">Cedula:</label>
                    <input type="text" class="<%= this.feedback("txtCedula",errores)%>" id="Cedula01" name="txtCedula" placeholder="<%= this.placeholder("txtCedula",errores,"Cedula usuario")%>" required>
                    <div class="invalid-feedback">
                            <%= this.placeholder("txtCedula",errores,"Cedula usuario")%>
                    </div>
                </div>

        <div class="form-row">
            <label for="Nom01">Nombre:</label><br>
          <input type="text" name="txtNombre" placeholder="Nombre" id="Nom01">
        </div>

               <div class="form-row">
            <label for="Tel01">Telefono:</label>
                    <input type="text" class="<%= this.feedback("txtCedula",errores)%>" id="Tel01" name="txtTelefono" placeholder="<%= this.placeholder("txtTelefono",errores,"numero telefonico")%>" required>
                    <div class="invalid-feedback">
                            <%= this.placeholder("txtCedula",errores,"numero telefonico")%>
                    </div>
      </div>

      <div class="form-row">
      <label for="email01">Correo de envio de la contraseña:</label>
      <input type="text" id="email01" name="txtCorreo" placeholder="Correo">
      </div>
      <center><input type="submit" class="btn btn-primary" name="butttonenviar" value="Añadir" ></center>
                  
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
    private String feedback(String campo, Map<String,String> erroresf){
        if ( (erroresf!=null) && (erroresf.get(campo)!=null) )
            return("form-control is-invalid");
        else
            return("form-control");
}
%>