<%-- 
    Document   : Registro
    Created on : 13/03/2020, 12:42:46 PM
    Author     : andre
--%>

<%@page import="banca.Presentacion.login.Model"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    Model model = (Model) request.getAttribute("model");%>
<%
    Map<String,String> errores=null;
if(model!=null)
 errores = (Map<String,String>) request.getAttribute("errores"); 
%>
<!DOCTYPE html>
<html>
    <head>
           <%@ include file="/Presentacion/link.jsp" %>
        <title>Registro</title>
        <meta name="theme-color" content="#563d7c">
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
    <link href="/Banco_proyectoI/css/signin.css" rel="stylesheet" type="text/css">
    </head>
    <body class="text-center">
      <div class="login">
          
      
                <form class="form-signin" action="/Banco_proyectoI/Presentacion/login/registro" method="POST">
                    <h1 class="registro">Registro</h1>
                    <div class="form-row">

                    <label for="validationServer01">Cedula:</label>
                    <input type="text" class="<%= this.feedback("txtCedula",errores)%>" id="validationServer01" name="txtCedula" placeholder="<%= this.placeholder("txtCedula",errores,"Cedula usuario")%>" required>
                    <div class="invalid-feedback">
                            <%= this.placeholder("txtCedula",errores,"Cedula usuario")%>
                          </div>
                    </div> 
                          <div class="form-row">

                              <label for="validationServer02">Contrasenia:</label>
                              <input type="password" class="<%= this.feedback("txtContrasena",errores)%>" id="validationServer02"  name="txtContrasena" placeholder="<%= this.placeholder("txtContrasena",errores,"Contraseña usuario")%>" required>                           
                              <div class="invalid-feedback">
                                  Contrasena invalida
                                </div>
                            </div>
                <input class="btn btn-primary" type="submit" name="butttonenviar" value="Registrarse" >
               
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

    private String feedback(String campo, Map<String,String> errores){
        if ( (errores!=null) && (errores.get(campo)!=null) )
            return("form-control is-invalid");
        else
            return("form-control");

    }
    %>