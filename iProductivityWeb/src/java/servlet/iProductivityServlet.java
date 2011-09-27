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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.TreeMap;
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
import model.BlackListImpl;
import model.Category;
import model.CategoryImpl;
import model.CoefficientComparator;
import model.Graphs;
import model.Utilities;
import model.Incident;
import model.IncidentImpl;
import model.Log;
import model.LogImpl;
import model.Task;
import model.TaskImpl;
import model.User;
import model.UserImpl;
import model.iProductivity;

/**
 *
 * @author javidgon
 */
public class iProductivityServlet extends HttpServlet {

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

        //out.flush();
        HttpSession session = request.getSession(true);
        SHA1 s = new SHA1();
        String url = null;
        try {

            if (null != request.getParameter("init")) {

                url = "/System/dashboard.jsp";  // Redirigimos a la página principal.


            } else if (null != request.getParameter("registration")) {


                url = "/registration.jsp";  // Redirigimos a la página principal.


            } else if (null != request.getParameter("Enter")) {

                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String name = null;
                int minutes = 0;

                // En control de formulario se hace con javascript.
                name = iProductivity.loginUser(email, s.getHash(password));
                BlackList b = iProductivity.consultaBlacklist((String) request.getRemoteAddr());
                if (b != null) {
                    Calendar now = new GregorianCalendar();
                    now.getInstance();

                    Calendar btime = new GregorianCalendar();
                    btime.setTime(b.getDate());

                    if (now.get(Calendar.HOUR_OF_DAY) == btime.get(Calendar.HOUR_OF_DAY)) {

                        minutes = now.get(Calendar.MINUTE) - btime.get(Calendar.MINUTE);

                    } else {

                        int hours = now.get(Calendar.HOUR_OF_DAY) - btime.get(Calendar.HOUR_OF_DAY);

                        if (btime.get(Calendar.MINUTE) > now.get(Calendar.MINUTE)) {

                            minutes = 60 - btime.get(Calendar.MINUTE) + now.get(Calendar.MINUTE);

                        } else {

                            minutes = now.get(Calendar.MINUTE) - btime.get(Calendar.MINUTE);
                        }

                        minutes = (hours * 60) + minutes;


                    }
                }
                if (name == null || ((b != null) && (minutes < 15))) {  // No nos hemos identificado correctamente, o estamos bloqueados.

                    if (((b != null) && (minutes < 15))) {
                    } else {

                        BlackList b3 = iProductivity.consultaBlacklist((String) request.getRemoteAddr());

                        if (b3 != null) {

                            iProductivity.deleteBlackList(b3);
                        }

                        if (null != session.getAttribute("attempts")) { // Si existe attempts.

                            if (Integer.parseInt(String.valueOf(session.getAttribute("attempts"))) == 2) {

                                BlackList b2 = new BlackListImpl((String) request.getRemoteAddr(), new Date());

                                iProductivity.createBlackList(b2);



                            } else {

                                int attempts = Integer.parseInt(String.valueOf(session.getAttribute("attempts")));
                                attempts++;
                                session.setAttribute("attempts", attempts);
                            }

                        } else {        // Si no existe attempts.
                            int attempts = 1;
                            session.setAttribute("attempts", attempts);

                        }
                    }

                    url = "/index.jsp";  // Redirigimos a la página principal.




                } else {
                    BlackList b3 = iProductivity.consultaBlacklist((String) request.getRemoteAddr());

                    if (null != b3) {
                        iProductivity.deleteBlackList(b3);
                    }

                    Log l = new LogImpl(email + " has been logged in", email, new Date());
                    iProductivity.createLog(l);
                    User u = iProductivity.consultaUser(email);
                    Integer i = null;

                    i = iProductivity.consultaType(email);

                    session.setAttribute("email", email);
                    session.setAttribute("type", i);
                    session.setAttribute("name", u.getName());
                    url = "/System/Tools/loading.jsp";  // Redirigimos al dashboard.

                }
            } else if (null != request.getParameter("Sign Up")) {

                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String name = request.getParameter("name");
                String surname = request.getParameter("surname");
                String boss = request.getParameter("boss");
                Integer type;

                if (request.getParameter("type").equals("Employee")) {

                    type = 1;
                } else {
                    type = 2;
                }

                User u = new UserImpl(email, s.getHash(password), name, surname, type, boss, new Date());

                iProductivity.createUser(u);


                Log l = new LogImpl(email + " has signed up", email, new Date());
                iProductivity.createLog(l);

                url = "/congratulations.jsp?CreatedAccount=true";  // Redirigimos a la página principal.



            } else if (null != request.getParameter("exit")) {

                session.invalidate();

                url = "/index.jsp";  // Redirigimos a la página principal.



            } // -----------------------------------------------------------------------------------------------------------------
            else if (null != request.getParameter("Edit")) {

                // Editamos la tarea (Sólo puede hacerlo el administrador)

                Integer hours = Integer.valueOf(request.getParameter("Tminutes")) / 60;
                Integer minutes = Integer.valueOf(request.getParameter("Tminutes")) % 60;

                session.setAttribute("Tdescription", request.getParameter("Tdescription"));
                session.setAttribute("Ttype", request.getParameter("Ttype"));
                session.setAttribute("Tminutes", minutes);
                session.setAttribute("Thours", hours);
                session.setAttribute("Tuser", request.getParameter("Tuser"));
                session.setAttribute("Tcreation_date", request.getParameter("Tcreation_date"));

                url = "/System/editTask.jsp";  // Redirigimos a la página principal.


            } else if (null != request.getParameter("EditUser")) {

                // Editamos el usuario.

                if (null == request.getParameter("ownEmail")) {


                    String email = request.getParameter("Uemail");
                    String name = request.getParameter("Uname");
                    String surname = request.getParameter("Usurname");
                    Integer type = Integer.valueOf(request.getParameter("Utype"));
                    String boss = request.getParameter("Uboss");

                    session.setAttribute("Uemail", email);
                    session.setAttribute("Uname", name);
                    session.setAttribute("Usurname", surname);
                    session.setAttribute("Utype", type);
                    session.setAttribute("Uboss", boss);

                } else {



                    User u = iProductivity.consultaUser(request.getParameter("ownEmail"));

                    session.setAttribute("Uemail", u.getEmail());
                    session.setAttribute("Uname", u.getName());
                    session.setAttribute("Usurname", u.getSurname());
                    session.setAttribute("Utype", u.getType());
                    session.setAttribute("Uboss", u.getBoss());

                }




                url = "/System/editUser.jsp";  // Redirigimos a la página principal.




            } else if (null != request.getParameter("Finish")) {
                Calendar d = new GregorianCalendar();
                int time = Integer.parseInt(String.valueOf(request.getParameter("hours"))) * 60 + Integer.parseInt((String.valueOf(request.getParameter("minutes"))));
                d.setTimeInMillis(Long.valueOf((String) session.getAttribute("Tcreation_date")));
                // Editamos la tarea. (Sólo puede hacerlo el usuario)

                session.setAttribute("Ttype", session.getAttribute("Ttype"));
                session.setAttribute("Tminutes", request.getParameter("minutes"));

                Task t = new TaskImpl((String) session.getAttribute("Tdescription"), (String) session.getAttribute("Ttype"), request.getParameter("done"), time, (String) session.getAttribute("Tuser"), d.getTime());

                iProductivity.updateTask(t);

                if (request.getParameter("done").equalsIgnoreCase("Yes")) {

                    iProductivity.doTask((String) session.getAttribute("Tdescription"), (String) session.getAttribute("Tuser"), new Date());

                }
                Log l = new LogImpl((String) session.getAttribute("email") + " has edited this task: " + (String) session.getAttribute("Tdescription"), (String) session.getAttribute("email"), new Date());
                iProductivity.createLog(l);

                url = "/System/dashboard.jsp?editedTask=1";  // Redirigimos a la página principal.


            } else if (null != request.getParameter("Finish User")) {

                String email = (String) session.getAttribute("Uemail");
                String oldpassword = (String) request.getParameter("Uoldpassword");
                String newpassword = (String) request.getParameter("Unewpassword");
                String name = (String) request.getParameter("Uname");
                String surname = (String) request.getParameter("Usurname");
                Integer type = (Integer) session.getAttribute("Utype");
                String boss = (String) session.getAttribute("Uboss");
                SHA1 s2 = new SHA1();

                String aux = s.getHash(oldpassword);
                String aux2 = s2.getHash(newpassword);

                String nameUser = iProductivity.loginUser(email, aux);

                if (null != nameUser) {

                    User t = new UserImpl(email, aux2, name, surname, type, boss);

                    iProductivity.updateUser(t);
                    Log l = new LogImpl((String) session.getAttribute("email") + " has edited his profile", (String) session.getAttribute("email"), new Date());
                    iProductivity.createLog(l);

                    session.setAttribute("Uname", name);
                    session.setAttribute("Usurname", surname);
                    session.setAttribute("Upassword", newpassword);



                }

                url = "/System/dashboard.jsp?editedUser=1";  // Redirigimos a la página principal.


            } else if (null != request.getParameter("DeleteIncident")) {
                Incident l = new IncidentImpl((String) request.getParameter("message"), (String) request.getParameter("user"), new Date(Long.parseLong(request.getParameter("creation_date"))));

                iProductivity.deleteIncident(l);

                // RECARGAR LA LISTA.
                List<Incident> aux = new ArrayList<Incident>();  // Auxiliar.
                if (session.getAttribute("filter").equals("") == false) {
                    List<Incident> incidents = (List) session.getAttribute("listIncident");
                    Iterator it1 = incidents.iterator();

                    while (it1.hasNext()) {

                        Incident incident = (Incident) it1.next();

                        if (!incident.equals(l)) {

                            aux.add(incident);

                        }
                    }

                    session.setAttribute("listIncident", null);
                    session.setAttribute("listIncident", aux);
                }

                url = "/System/incidents.jsp";  // Redirigimos a la página principal.


                // -----------------------------------------------------------------------------------------------------------------


            } else if (null != request.getParameter("Remove")) {

                // Borramos la tarea (Sólo puede hacerlo el administrador)

                iProductivity.deleteTask((String) request.getParameter("Tdescription"), (String) request.getParameter("Tuser"));
                // RECARGAR LA LISTA.
                List<Task> aux = new ArrayList<Task>();  // Auxiliar.
                if (null != session.getAttribute("filter")) {
                    if (session.getAttribute("filter").equals("") == false) {
                        List<Task> tasks = (List) session.getAttribute("listTask");
                        Iterator it1 = tasks.iterator();

                        while (it1.hasNext()) {

                            Task task = (Task) it1.next();

                            if (!task.getDescription().equals((String) request.getParameter("Tdescription")) && !task.getUser().equals((String) request.getParameter("Tuser"))) {

                                aux.add(task);

                            }
                        }

                        session.setAttribute("listTask", null);
                        session.setAttribute("listTask", aux);
                    }
                }

                Log l = new LogImpl((String) request.getParameter("Tuser") + " has removed this task: " + (String) request.getParameter("Tdescription"), (String) request.getParameter("Tuser"), new Date());
                iProductivity.createLog(l);
                if (null != session.getAttribute("filter")) {
                    url = "/System/historicalTask.jsp";  // Redirigimos a la página principal.

                } else {
                    url = "/System/dashboard.jsp";  // Redirigimos a la página principal.

                }

            } else if (null != request.getParameter("Remove Category")) {

                String name = (String) request.getParameter("Cname");

                iProductivity.deleteCategory(name);
                Log l = new LogImpl((String) session.getAttribute("email") + " has removed this category: " + name, (String) session.getAttribute("email"), new Date());
                iProductivity.createLog(l);

                url = "/System/categories.jsp";  // Redirigimos a la página principal.





            } else if (null != request.getParameter("DeleteLog")) {
                Log l = new LogImpl((String) request.getParameter("message"), (String) request.getParameter("user"), new Date(Long.parseLong(request.getParameter("creation_date"))));

                iProductivity.deleteLog(l);

                // RECARGAR LA LISTA.
                List<Log> aux = new ArrayList<Log>();  // Auxiliar.
                if (session.getAttribute("filter").equals("") == false) {
                    List<Log> logs = (List) session.getAttribute("listLog");
                    Iterator it1 = logs.iterator();

                    while (it1.hasNext()) {

                        Log log = (Log) it1.next();

                        if (!log.equals(l)) {

                            aux.add(log);

                        }
                    }

                    logs.remove(l);
                    session.setAttribute("listLog", null);
                    session.setAttribute("listLog", aux);
                }

                url = "/System/logs.jsp";  // Redirigimos a la página principal.

            } else if (null != request.getParameter("DeleteUser")) {

                List<Task> tasks = iProductivity.consultaTasksForUser((String) request.getParameter("Uemail"));

                Iterator it = tasks.iterator();

                while (it.hasNext()) {
                    Task t = (Task) it.next();
                    iProductivity.deleteTask(t.getDescription(), t.getUser());


                }


                iProductivity.deleteUser((String) request.getParameter("Uemail"));

                Log l = new LogImpl((String) session.getAttribute("email") + " has removed this user: " + (String) request.getParameter("Uemail"), (String) session.getAttribute("email"), new Date());
                iProductivity.createLog(l);


                // RECARGAR LA LISTA.
                List<User> aux = new ArrayList<User>();  // Auxiliar.
                if (session.getAttribute("filter").equals("FilterUser") == true) {
                    List<User> users = (List) session.getAttribute("listUser");
                    Iterator it1 = users.iterator();

                    while (it1.hasNext()) {

                        User user = (User) it1.next();

                        if (!user.equals(l)) {

                            aux.add(user);

                        }
                    }

                    session.setAttribute("listUser", null);
                    session.setAttribute("listUser", aux);
                } else if (session.getAttribute("filter").equals("SearchUser") == true) {

                    session.setAttribute("filter", "");

                }

                url = "/System/users.jsp";  // Redirigimos a la página principal.



                // -----------------------------------------------------------------------------------------------------------------


            } else if (null != request.getParameter("AccessHistoricalTasks")) {

                // Accedemos al historial de tareas. (Sólo puede hacerlo el usuario)

                session.setAttribute("filter", "");

                url = "/System/historicalTask.jsp";  // Redirigimos a la página principal.


            } else if (null != request.getParameter("AccessRanking")) {

                String email = null;
                HashMap<String, Double> map = new HashMap<String, Double>();
                CoefficientComparator cc = new CoefficientComparator(map);
                TreeMap<String, Double> sorted_map = new TreeMap(cc);
                List<User> l = iProductivity.consultaUsersByType(1);
                Iterator it1 = l.iterator();
                while (it1.hasNext()) {
                    User u = (User) it1.next();

                    List<Task> tasks = iProductivity.consultaTasksForUser(u.getEmail());

                    if (tasks.size() > 0) {

                        email = u.getEmail();
                        map.put(u.getEmail(), Graphs.calculateCoefficient(u.getEmail()));

                    }

                }
                sorted_map.putAll(map);

                session.setAttribute("sortedMap", sorted_map);



                url = "/System/ranking.jsp";  // Redirigimos a la página principal.


            } else if (null != request.getParameter("AccessUsers")) {

                // Accedemos a los incidents. (Sólo puede hacerlo el usuario)

                session.setAttribute("filter", "");

                url = "/System/users.jsp";  // Redirigimos a la página principal.




            } else if (null != request.getParameter("AccessIncidents")) {

                // Accedemos a los incidents. (Sólo puede hacerlo el usuario)

                session.setAttribute("filter", "");

                url = "/System/incidents.jsp";  // Redirigimos a la página principal.



            } else if (null != request.getParameter("AccessCategories")) {

                // Accedemos a los categories. (Sólo puede hacerlo el usuario)

                url = "/System/categories.jsp";  // Redirigimos a la página principal.



            } else if (null != request.getParameter("AccessLogs")) {

                // Accedemos a los logs. (Sólo puede hacerlo el usuario)

                session.setAttribute("filter", "");

                url = "/System/logs.jsp";  // Redirigimos a la página principal.



            } // -----------------------------------------------------------------------------------------------------------------
            else if (null != request.getParameter("TaskAccomplished")) {

                String description = (String) request.getParameter("Tdescription");
                String email = (String) request.getParameter("Tuser");
                Date d = new Date();
                // Realizamos la tarea.

                iProductivity.doTask(description, email, d);


                url = "/System/dashboard.jsp?success=1";  // Redirigimos a la página principal.



            } // -----------------------------------------------------------------------------------------------------------------
            else if (null != request.getParameter("Create")) {
                // Creamos la tarea. (Sólo puede hacerlo el usuario)

                url = "/System/insertTask.jsp";  // Redirigimos a la página principal.



            } else if (null != request.getParameter("CreateCategory")) {

                // Creamos la tarea. (Sólo puede hacerlo el usuario)

                url = "/System/insertCategory.jsp";  // Redirigimos a la página principal.




            } else if (null != request.getParameter("CreateIncident")) {

                // Creamos el incident. (Sólo puede hacerlo el usuario)

                url = "/System/insertIncident.jsp";  // Redirigimos a la página principal.



            } else if (null != request.getParameter("Insert")) {

                Integer time = (60 * (Integer.valueOf(request.getParameter("hours")))) + (Integer.valueOf(request.getParameter("minutes")));

                Task t = new TaskImpl(request.getParameter("description"), request.getParameter("type"), "No", time, request.getParameter("user"), new Date());

                iProductivity.createTask(t);
                Log l = new LogImpl((String) session.getAttribute("email") + " has created this task: " + request.getParameter("description"), (String) session.getAttribute("email"), new Date());
                iProductivity.createLog(l);

                url = "/System/dashboard.jsp?success=1";  // Redirigimos a la página principal.





            } else if (null != request.getParameter("Insert Category")) {

                Category c = new CategoryImpl(request.getParameter("name"), new Date());

                iProductivity.createCategory(c);
                Log l = new LogImpl((String) session.getAttribute("email") + " has created this category: " + request.getParameter("name"), (String) session.getAttribute("email"), new Date());
                iProductivity.createLog(l);

                url = "/System/dashboard.jsp?success=1";  // Redirigimos a la página principal.




            } else if (null != request.getParameter("InsertIncident")) {

                Incident i = new IncidentImpl((String) request.getParameter("message"), (String) session.getAttribute("email"), new Date());

                iProductivity.createIncident(i);
                Log l = new LogImpl((String) session.getAttribute("email") + " has created this incident: " + request.getParameter("message"), (String) session.getAttribute("email"), new Date());
                iProductivity.createLog(l);

                url = "/System/dashboard.jsp";  // Redirigimos a la página principal.



// -----------------------------------------------------------------------------------------------------------------


            } else if (null != request.getParameter("SearchLog")) {
                List<Log> l = null;
                session.setAttribute("filter", "SearchLog");
                l = iProductivity.consultaLogsForUser(request.getParameter("email"));


                session.setAttribute("listLog", l);
                url = "/System/logs.jsp";  // Redirigimos a la página principal.


            } else if (null != request.getParameter("FilterLog")) {
                List<Log> logs = null;
                List<Log> logsByFilter = new ArrayList<Log>();
                session.setAttribute("filter", "FilterLog");
                logs = iProductivity.consultaLogs();


                if (request.getParameter("time").equals("today")) {

                    Iterator it1 = logs.iterator();
                    while (it1.hasNext()) {
                        Log l = (Log) it1.next();

                        if (Utilities.diferenciasDeFechas(l.getCreation_date(), new Date()) <= 1) {
                            logsByFilter.add(l);
                        }

                    }
                } else if (request.getParameter("time").equals("week")) {
                    Iterator it1 = logs.iterator();
                    while (it1.hasNext()) {

                        Log l = (Log) it1.next();
                        if (Utilities.diferenciasDeFechas(l.getCreation_date(), new Date()) <= 7) {
                            logsByFilter.add(l);
                        }

                    }
                } else {
                    logsByFilter = logs;
                }

                session.setAttribute("listLog", logsByFilter);
                url = "/System/logs.jsp";  // Redirigimos a la página principal.





            } else if (null != request.getParameter("SearchIncident")) {
                List<Incident> l = null;
                session.setAttribute("filter", "SearchIncident");
                l = iProductivity.consultaIncidentsForUser(request.getParameter("email"));


                session.setAttribute("listIncident", l);
                url = "/System/incidents.jsp";  // Redirigimos a la página principal.


            } else if (null != request.getParameter("FilterIncident")) {
                List<Incident> incidents = null;
                List<Incident> incidentsByFilter = new ArrayList<Incident>();
                session.setAttribute("filter", "FilterIncident");
                incidents = iProductivity.consultaIncidents();


                if (request.getParameter("time").equals("today")) {

                    Iterator it1 = incidents.iterator();
                    while (it1.hasNext()) {
                        Incident l = (Incident) it1.next();

                        if (Utilities.diferenciasDeFechas(l.getCreation_date(), new Date()) <= 1) {
                            incidentsByFilter.add(l);
                        }

                    }
                } else if (request.getParameter("time").equals("week")) {
                    Iterator it1 = incidents.iterator();
                    while (it1.hasNext()) {

                        Incident l = (Incident) it1.next();
                        if (Utilities.diferenciasDeFechas(l.getCreation_date(), new Date()) <= 7) {
                            incidentsByFilter.add(l);
                        }

                    }
                } else {
                    incidentsByFilter = incidents;
                }

                session.setAttribute("listIncident", incidentsByFilter);
                url = "/System/incidents.jsp";  // Redirigimos a la página principal.


            } else if (null != request.getParameter("SearchUser")) {
                session.setAttribute("filter", "SearchUser");
                String email = request.getParameter("email");
                User l = iProductivity.consultaUser(email);

                if (null == l) {
                    List<User> list = new ArrayList();
                    session.setAttribute("filter", "FilterUser");

                    session.setAttribute("listUser", list);
                    url = "/System/users.jsp";  // Redirigimos a la página principal.

                } else {

                    session.setAttribute("User", l);
                    url = "/System/users.jsp";  // Redirigimos a la página principal.

                }



            } else if (null != request.getParameter("FilterUser")) {
                List<User> users = null;
                List<User> usersByFilter = new ArrayList<User>();
                session.setAttribute("filter", "FilterUser");
                users = iProductivity.consultaUsers();

                if (null != users) {
                    if (request.getParameter("time").equals("today")) {

                        Iterator it1 = users.iterator();
                        while (it1.hasNext()) {
                            User l = (User) it1.next();

                            if (Utilities.diferenciasDeFechas(l.getCreation_date(), new Date()) <= 1) {
                                usersByFilter.add(l);
                            }

                        }
                    } else if (request.getParameter("time").equals("week")) {
                        Iterator it1 = users.iterator();
                        while (it1.hasNext()) {

                            User l = (User) it1.next();
                            if (Utilities.diferenciasDeFechas(l.getCreation_date(), new Date()) <= 7) {
                                usersByFilter.add(l);
                            }

                        }
                    } else {
                        usersByFilter = users;
                    }
                }

                session.setAttribute("listUser", usersByFilter);
                url = "/System/users.jsp";  // Redirigimos a la página principal.


            } else if (null != request.getParameter("SearchTask")) {
                List<Task> t = null;
                session.setAttribute("filter", "SearchTask");
                t = iProductivity.consultaTasksForUser(request.getParameter("email"));


                session.setAttribute("listTask", t);
                url = "/System/historicalTask.jsp";  // Redirigimos a la página principal.

            } else if (null != request.getParameter("FilterTask")) {
                List<Task> tasks = null;
                List<Task> tasksByFilter = new ArrayList<Task>();
                session.setAttribute("filter", "FilterTask");
                tasks = iProductivity.consultaTasks();


                if (request.getParameter("time").equals("today")) {

                    Iterator it1 = tasks.iterator();
                    while (it1.hasNext()) {
                        Task t = (Task) it1.next();

                        if (Utilities.diferenciasDeFechas(t.getCreation_date(), new Date()) <= 1) {
                            tasksByFilter.add(t);
                        }

                    }
                } else if (request.getParameter("time").equals("week")) {
                    Iterator it1 = tasks.iterator();
                    while (it1.hasNext()) {

                        Task t = (Task) it1.next();
                        if (Utilities.diferenciasDeFechas(t.getCreation_date(), new Date()) <= 7) {
                            tasksByFilter.add(t);
                        }

                    }
                } else {
                    tasksByFilter = tasks;
                }

                session.setAttribute("listTask", tasksByFilter);
                url = "/System/historicalTask.jsp";  // Redirigimos a la página principal.


            }

            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher(url);
            rd.forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(iProductivityServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(iProductivityServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(iProductivityServlet.class.getName()).log(Level.SEVERE, null, ex);
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
