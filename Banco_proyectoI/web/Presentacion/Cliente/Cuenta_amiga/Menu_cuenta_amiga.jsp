<%-- 
    Document   : Menu_cuenta_amiga
    Created on : 13/03/2020, 02:33:26 PM
    Author     : andre
--%>

<%@page import="banca.Presentacion.Cliente.Cuenta_amiga.Model"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="banca.Logic.Cuenta"%>

<%
   Model model = (Model) request.getAttribute("model");
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
        <title>Cuenta favorita</title>
        <link href="/Banco_proyectoI/css/signin.css" rel="stylesheet" type="text/css">
    </head>
    <body>
         <%@ include file="/Presentacion/Encabezado.jsp" %> 
          
         <form class="form-signin" action="/Banco_proyectoI/Presentacion/Cliente/Cuenta_amiga/add" method="POST">
          <h2>Cuenta Favorita</h2>
     <div class="form-row">
         <label for="errores1">Numero de cuenta favorita:</label>
         <input class="<%=this.feedback("txtCuentaamiga", errores) %>" id="errores1" type="text" name="txtCuentaamiga" placeholder="<%=this.placeholder("txtCuentaamiga", errores, "# Cuenta favorita") %>" requiered>
         <div class="invalid-feedback">
                 <%=this.placeholder("txtCuentaamiga", errores, "# Cuenta favorita") %>
               </div>
     </div>
     <div class="form-row">
         <label for="errores2">Nombre propietario:</label>
         <input type="text" name="txtNombre" placeholder="Nombre" id="errores2" required>
     </div>
     <div class="form-row">
         <label for="errores3">Cedula propietario:</label>
         <input type="text" name="txtCedula" placeholder="Cedula" id="errores3" required> <br> <br>
     </div>
      <center><input type="submit" name="butttonenviar" value="Añadir" ></center>
      </form>
         <%@ include file="/Presentacion/Footer.jsp" %>
    </body>
</html>
<%! private String placeholder(String campo, Map<String,String> errores,String mensaje){
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