/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package banca.Presentacion.Cajero;


import banca.Logic.Cuenta;
import banca.Logic.Login_usuario;
import banca.Logic.Persona;
import java.awt.Panel;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "CajeroController", urlPatterns = {"/Presentacion/Cajero/show","/Presentacion/Cajero/addCuenta"})
public class Controller extends HttpServlet {
    
  protected void processRequest(HttpServletRequest request, 
                                HttpServletResponse response)
         throws ServletException, IOException {

        request.setAttribute("model", new Model());
       HttpSession session = request.getSession(true);
       Login_usuario usuario=  (Login_usuario) session.getAttribute("usuario");
       String viewUrl="/Presentacion/Error.jsp";
       if(usuario!=null && usuario.getTipo()==2) 
       { switch (request.getServletPath()) {
          case "/Presentacion/Cajero/show":
              viewUrl = this.show(request);
              break;
          case "/Presentacion/Cajero/addCuenta":
              viewUrl = this.add(request);
              break;  
        
        }}     
          
        request.getRequestDispatcher(viewUrl).forward( request, response); 
  }

    public String show(HttpServletRequest request) {
    
        return this.showAction(request);
    }
   public String add(HttpServletRequest request) {
        return this.addAction(request);
    }
   
   public String PasswordRandom(){

char [] chars = "012AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz3456789".toCharArray();

// Longitud del array de char.
int charsLength = chars.length;

// Instanciamos la clase Random
Random random = new Random();
StringBuffer buffer = new StringBuffer();

// Bucle para elegir una cadena de 10 caracteres al azar
for (int i=0;i<8;i++){

   // Añadimos al buffer un caracter al azar del array
   buffer.append(chars[random.nextInt(charsLength)]);
}
return buffer.toString();
}
         private void Enviar_correo(String usuario,String receptor) throws Exception
       {
        Properties propiedad = new Properties();
        propiedad.setProperty("mail.smtp.host", "smtp.gmail.com");
        propiedad.setProperty("mail.smtp.starttls.enable", "true");
        propiedad.setProperty("mail.smtp.port", "587");
        propiedad.setProperty("mail.smtp.auth", "true");
        
        String password = this.PasswordRandom();
        banca.Logic.Model domainModel = banca.Logic.Model.instance();
        domainModel.AddLoginCliente(usuario, password);
        Session sesion = Session.getDefaultInstance(propiedad);
       String correoEnvia = "aerolineaenan.una@gmail.com";
        String contrasena = "ANEN1234567";
     
       
        String asunto = "Usuario-Contrasena Banco";
        String mensaje="Usuario:"+usuario+" Contraseña:"+password;
        
        MimeMessage mail = new MimeMessage(sesion);
        try {
            mail.setFrom(new InternetAddress (correoEnvia));
            mail.addRecipient(Message.RecipientType.TO, new InternetAddress (receptor));
            mail.setSubject(asunto);
            mail.setText(mensaje);
            
            Transport transportar = sesion.getTransport("smtp");
            transportar.connect(correoEnvia,contrasena);
            transportar.sendMessage(mail, mail.getRecipients(Message.RecipientType.TO));          
            transportar.close();
            
            
            
            
        } catch (AddressException ex) {
            Logger.getLogger(Panel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(Panel.class.getName()).log(Level.SEVERE, null, ex);
        }

       }
     
   public void CuentaFavorita(String numero,String cedula) throws Exception
   {
       banca.Logic.Model domainModel = banca.Logic.Model.instance();
       Cuenta cuenta = new Cuenta();
       Persona persona = new Persona();
       cuenta.setNumero(numero);
       persona.setCedula(cedula);
       domainModel.AddCuentaAmiga(new banca.Logic.CuentaAmiga(0,cuenta,persona));
   }
   
   
       public String addAction(HttpServletRequest request) {
         Model model = (Model) request.getAttribute("model");
        banca.Logic.Model domainModel = banca.Logic.Model.instance();
        HttpSession session = request.getSession(true);
 
    
      
        
       Map<String,String> errores = new HashMap<>();
            request.setAttribute("errores", errores);
            
        try {  
            
            if(!domainModel.Ispersona(request.getParameter("txtCedula")) ||!this.verificacion_cedulaotelefono(request.getParameter("txtCedula")) || request.getParameter("txtCedula").length()>9 ||  request.getParameter("txtCedula").length()<9)
            {
            errores.put("txtCedula","Cedula invalida");
            }
            else
            {
            model.setCurrent(domainModel.PersonaGet(request.getParameter("txtCedula")));
            }
   
           if(!this.verificacion_Limitediario(request.getParameter("txtLimite_diario")))
            {
            errores.put("txtLimite_diario","Limite invalido");
            }
            if(!errores.isEmpty())
            {
            return "/Presentacion/Cajero/Cuenta.jsp";
            }    
            Persona persona = new Persona();
            persona.setCedula(request.getParameter("txtCedula"));
           domainModel.Addcuenta(new Cuenta(request.getParameter("txtNumeroCuenta"),0,request.getParameter("txtMoneda"),persona,Double.parseDouble(request.getParameter("txtLimite_diario"))));
           this.CuentaFavorita(request.getParameter("txtNumeroCuenta"),request.getParameter("txtCedula"));
           request.setAttribute("model", new banca.Presentacion.login.Model());
            request.setAttribute("mensaje", "Se añadio la cuenta correctamente");
           return "/Presentacion/Exitosa.jsp";
        } catch (Exception ex) {
            return "";
        }
    }
    public boolean verificacion_Limitediario(String limitediario)
    {
    
     try {        
         Double.parseDouble(limitediario);
        } catch (Exception ex) {
            return false;
        }
     return true;
    }   
    public boolean verificacion_cedulaotelefono(String cedula)
    {
    
     try {        
         Integer.parseInt(cedula);
        } catch (Exception ex) {
            return false;
        }
     return true;
    }
    public String showAction(HttpServletRequest request) {
        Model model = (Model) request.getAttribute("model");
        banca.Logic.Model domainModel = banca.Logic.Model.instance();
        HttpSession session = request.getSession(true);
 
    
       Map<String,String> errores = new HashMap<>();
            request.setAttribute("errores", errores);
            
        try {        
            if(!this.verificacion_cedulaotelefono(request.getParameter("txtCedula")) || request.getParameter("txtCedula").length()>9 ||  request.getParameter("txtCedula").length()<9)
            {
            errores.put("txtCedula","Cedula invalida");
            }
              if(!this.verificacion_cedulaotelefono(request.getParameter("txtTelefono")) || request.getParameter("txtTelefono").length()>8 || request.getParameter("txtTelefono").length()<8)
            {
            errores.put("txtTelefono","Telefono invalido");
            }
            if(!errores.isEmpty())
                return "/Presentacion/Registro.jsp";
           domainModel.Addpersona(request.getParameter("txtCedula"), request.getParameter("txtNombre"), request.getParameter("txtTelefono"));
            model.setCurrent(new Persona(request.getParameter("txtCedula"), request.getParameter("txtNombre"), request.getParameter("txtTelefono")));
            this.Enviar_correo(request.getParameter("txtCedula"),request.getParameter("txtCorreo"));
           return "/Presentacion/Cajero/Cuenta.jsp";
        } catch (Exception ex) {
            errores.put("txtCedula","Cedula ya existe");
            return "/Presentacion/Registro.jsp";
        }
    }
    
  
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
}