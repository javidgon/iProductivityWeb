/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.GregorianCalendar;
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
import model.Utilities;
import model.Graphs;
import model.Task;
import model.iProductivity;
import org.jfree.data.general.DefaultPieDataset;

/**
 *
 * @author javidgon
 */
public class graphServlet extends HttpServlet {

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
        HttpSession session = request.getSession(true);
        String url = null;
        try {

            if (null != request.getParameter("ViewUserChart")) {

                url = "/System/getChart.jsp";  // Redirigimos a la página principal.



            } else if (null != request.getParameter("ViewRankingChart")) {

                DefaultPieDataset piedataset = new DefaultPieDataset();

                piedataset = Graphs.calculateGlobalProductivity();

                session.setAttribute("global", piedataset);
                session.setAttribute("nameChart", "Business Productivity");
                session.setAttribute("typeChart", "PieChart");
                session.setAttribute("time", "global");

                url = "/System/getChart.jsp";  // Redirigimos a la página principal.



            } else if (null != request.getParameter("AccessCharts")) {
                int nTasks[] = new int[31];
                int days[] = new int[31];
                DefaultPieDataset dataset = null;

                List<Task> task = null;
                Calendar c = new GregorianCalendar().getInstance(); // El comparador del for.
                Calendar d = new GregorianCalendar().getInstance(); // El de cada tarea.
                Calendar e = new GregorianCalendar().getInstance(); // El que se modifica.
                int counter = 0;
                // Accedemos a la página de charts. (Sólo puede hacerlo el usuario)
                String email = (String) request.getParameter("chartEmail");
                String type = (String) request.getParameter("typeChart");

                task = iProductivity.consultaTasksForUser(email);   // Buscamos todas las tareas de un usuario.
                if (type.equalsIgnoreCase("week")) {
                    for (int i = 1; i <= 7; i++) {    // Desde el Lunes(1), al día de hoy.

                        days[i - 1] = i;  // Guardamos en el array days el día de la semana.
                        e.set(Calendar.DAY_OF_WEEK, i); // Configuramos el calendario que vamos a utilizar para comparar.
                        Iterator it1 = task.iterator();

                        while (it1.hasNext()) {

                            Task t = (Task) it1.next();

                            if (null != t.getFinalization_date()) {

                                if((t.getFinalization_date().getTime() > t.getCreation_date().getTime()) && t.getDone().equalsIgnoreCase("Yes")){
                                d.setTime(t.getFinalization_date());    // Leemos el tiempo de finalización de cada tarea.

                                if (d.get(Calendar.DAY_OF_WEEK) == e.get(Calendar.DAY_OF_WEEK)) { // Vemos si es el mismo!!

                                    counter++;  // Incrementamos el número de tareas.

                                }
                            }
                                }

                        }
                        nTasks[i - 1] = counter;  //  Guardamos el número de tareas en el array nTasks.
                        counter = 0;    // Ponemos el contador a 0.
                    }
                    session.setAttribute("typeChart", "BarChart");
                    session.setAttribute("nameChart", "Daily Workflow");

                } else if (type.equalsIgnoreCase("month")) {
                    int nDays = 0;

                    nDays = Utilities.numberOfDaysInAMonth(c.get(Calendar.MONTH));

                    for (int i = 1; i <= nDays; i++) {


                        days[i - 1] = i;  // Guardamos en el array days el día de la semana.
                        e.set(Calendar.DAY_OF_MONTH, i); // Configuramos el calendario que vamos a utilizar para comparar.
                        Iterator it1 = task.iterator();

                        while (it1.hasNext()) {

                            Task t = (Task) it1.next();
                            if (null != t.getFinalization_date()) {
                                 if((t.getFinalization_date().getTime() > t.getCreation_date().getTime()) && t.getDone().equalsIgnoreCase("Yes")){
                                d.setTime(t.getFinalization_date());    // Leemos el tiempo de finalización de cada tarea.

                                if (d.get(Calendar.DAY_OF_MONTH) == e.get(Calendar.DAY_OF_MONTH)) { // Vemos si es el mismo!!

                                    counter++;  // Incrementamos el número de tareas.
                                }
                            }
                                                                }

                        }
                        nTasks[i - 1] = counter;  //  Guardamos el número de tareas en el array nTasks.
                        counter = 0;    // Ponemos el contador a 0.

                    }
                    session.setAttribute("typeChart", "BarChart");
                    session.setAttribute("nameChart", "Monthly Workflow");

                } else if (type.equalsIgnoreCase("global")) {
                    dataset = Graphs.calculateGlobalProductivity();

                    session.setAttribute("typeChart", "PieChart");
                    session.setAttribute("global", dataset);
                    session.setAttribute("nameChart", "Business Productivity");
                }

                session.setAttribute("days", days);
                session.setAttribute("nTasks", nTasks);
                session.setAttribute("ejex", "Days");
                session.setAttribute("ejey", "Number of Tasks");
                session.setAttribute("chartEmail", email);
                session.setAttribute("time", type);

                url = "/System/charts.jsp";  // Redirigimos a la página principal.


            }

                ServletContext sc = getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher(url);
                rd.forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(graphServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(graphServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
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
