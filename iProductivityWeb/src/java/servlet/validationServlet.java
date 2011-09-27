/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import encryption.SHA1;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.BlackList;
import model.Task;
import model.User;
import model.iProductivity;

/**
 *
 * @author javidgon
 */
public class validationServlet extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);
        try {

            if (null != request.getParameter("email")) {
                // Estamos validando el email.

                String email = (String) request.getParameter("email");
                if (!email.isEmpty()) {

                    if (!email.contains("@")) {

                        out.println(" <img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noEmail\" style=\"color: red; font-family:verdana \">  It's not a valid email address</span>");

                    } else {

                        User u = null;
                        u = iProductivity.consultaUser(email);


                        if (u == null) {
                            out.println(" <img src=\"images/true.png\" alt=\"Imagen\" width=\"30px\" /> <span id=\"yesEmail\" style=\"color: green; font-family:verdana \">  This email is available!</span>");
                        } else {
                            out.println(" <img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noEmail\" style=\"color: red; font-family:verdana \">  Oh! This email has already been taken.</span>");
                        }
                    }
                }



            } else if (null != request.getParameter("password")) {
                String password = (String) request.getParameter("password");

                if (!password.isEmpty()) {

                    if (password.length() < 8) {

                        out.println("<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noPassword\" style=\"color: red; font-family:verdana \">  Password is too short. At least 8 characters.</span>");

                    } else {

                        out.println(" <img src=\"images/true.png\" alt=\"Imagen\" width=\"30px\" /> <span id=\"yesPassword\" style=\"color: green; font-family:verdana \">  This is a good password!</span>");

                    }


                }



            } else if (null != request.getParameter("login")) {

                BlackList b = iProductivity.consultaBlacklist((String) request.getRemoteAddr());

                if (null == b) {

                    String email = (String) request.getParameter("iemail");
                    String password = (String) request.getParameter("ipassword");


                    String url = "/iProductivityServlet?Enter=1&email=" + email + "&password=" + password + "";  // Redirigimos a la página principal.
                    ServletContext sc = getServletContext();
                    RequestDispatcher rd = sc.getRequestDispatcher(url);
                    rd.forward(request, response);


                } else {

                    session.setAttribute("loginError", 1);

                    String url = "/index.jsp";  // Redirigimos a la página principal.
                    ServletContext sc = getServletContext();
                    RequestDispatcher rd = sc.getRequestDispatcher(url);
                    rd.forward(request, response);



                }


            } else if (null != request.getParameter("category")) {
                String category = (String) request.getParameter("category");
                String c = null;

                if (!category.isEmpty()) {

                    if (category.length() < 3) {

                        out.println("<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noCategory\" style=\"color: red; font-family:verdana \">  Category is too short. At least 3 characters.</span>");

                    } else {

                         c = iProductivity.consultaCategory(request.getParameter("category"));

                        if (null == c) {

                            out.println(" <img src=\"images/true.png\" alt=\"Imagen\" width=\"30px\" /> <span id=\"yesCategory\" style=\"color: green; font-family:verdana \">  This is a good Category!</span>");
                        }else{

                             out.println("<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noCategory\" style=\"color: red; font-family:verdana \"> This Category is already in the database</span>");

                        }
                    }



                }

            } else if(null != request.getParameter("oldpassword")){
                SHA1 s = new SHA1();

                String email = (String) session.getAttribute("Uemail");
                String password = (String) request.getParameter("oldpassword");
                if (!password.isEmpty()) {

                        User u = null;
                        u = iProductivity.consultaUser(email);
                        if (u.getPassword().equals(s.getHash(password))) {
                            out.println(" <img src=\"images/true.png\" alt=\"Imagen\" width=\"30px\" /> <span id=\"yesOldPassword\" style=\"color: green; font-family:verdana \"></span>");
                        } else {
                            out.println(" <img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noOldPassword\" style=\"color: red; font-family:verdana \"></span>");
                        }

                }
            }else if (null != request.getParameter("description")) {
                String description = (String)request.getParameter("description");
                List <Task> tasks = null;
                boolean enc = false;

                String user = (String)request.getParameter("employee");

                if(!description.isEmpty()){

                 if (description.length() < 5) {

                        out.println("<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noDescription\" style=\"color: red; font-family:verdana \">  Description is too short. At least 5 characters.</span>");

                    } else {

                        tasks = iProductivity.consultaTasksForUser(user);

                        Iterator it = tasks.iterator();

                        while(it.hasNext()){

                            Task t = (Task) it.next();

                            if(t.getDescription().equalsIgnoreCase(description)){

                                enc = true;

                            }

                        }

                        if(enc == false){

                             out.println(" <img src=\"images/true.png\" alt=\"Imagen\" width=\"30px\" /> <span id=\"yesDescription\" style=\"color: green; font-family:verdana \">  This is a good description!</span>");


                        }else{

                             out.println("<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noDescription\" style=\"color: red; font-family:verdana \"> This user already HAS or HAS DONE this task.</span>");


                        }


                    }






                }



            }


        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(validationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(validationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(validationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
