package model;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;
import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class iProductivity {

    private static final SqlMapClient sqlMap;

    static {
        try {
            String resource = "model/sqlIbatisMapConfig.xml";
            Reader reader = Resources.getResourceAsReader(resource);
            sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
        } catch (Exception e) {
            throw new RuntimeException("Error initializing MyAppSqlConfig"
                    + " class. Cause: " + e);
        }
    }

    public static List<Category> consultaCategories()
            throws SQLException, ClassNotFoundException, IOException {
        return sqlMap.queryForList("getCategories");
    }


    public static String consultaCategory(String name)
            throws SQLException, ClassNotFoundException, IOException {
        return (String)sqlMap.queryForObject("getCategory",name);
    }

    public static void createCategory(Category c)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.insert("insertCategory", c);
    }

    public static void deleteCategory(String name)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.delete("deleteCategory", name);
    }

    // ------------------------------------------------------------------
    public static List<Task> consultaTasks()
            throws SQLException, ClassNotFoundException, IOException {
        return sqlMap.queryForList("getTasks");
    }
    public static List<Task> consultaTasksForUser(String email)
            throws SQLException, ClassNotFoundException, IOException {
        return sqlMap.queryForList("getTasksForUser",email);
    }

    public static void createTask(Task t)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.insert("insertTask", t);
    }

    public static void deleteTask(String description, String user)
            throws SQLException, ClassNotFoundException, IOException {
        List l = new ArrayList();
        l.add(description);
        l.add(user);
        sqlMap.delete("deleteTask", l);
    }

   
 public static void updateTask(Task t)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.update("updateTask", t);
    }

 public static void doTask(String description, String user, Date d)
            throws SQLException, ClassNotFoundException, IOException {
            List l = new ArrayList();
        l.add(description);
        l.add(user);
        l.add(d);
        sqlMap.update("doTask", l);
    }

    // ------------------------------------------------------------------
    public static List<User> consultaUsers()
            throws SQLException, ClassNotFoundException, IOException {
        return sqlMap.queryForList("getUsers");
    }
    public static List<User> consultaUsersByCoordinator(String email)
            throws SQLException, ClassNotFoundException, IOException {
        return sqlMap.queryForList("getUsersByCoordinator",email);
    }
     public static User consultaUser(String email)
            throws SQLException, ClassNotFoundException, IOException {
        return (User)sqlMap.queryForObject("getUser",email);
    }
      public static List<User> consultaUsersByType(int i)
            throws SQLException, ClassNotFoundException, IOException {
        return sqlMap.queryForList("getUsersByType",i);
    }

     public static int consultaType(String email)
            throws SQLException, ClassNotFoundException, IOException {
        return (Integer) sqlMap.queryForObject("getType",email);
    }

   public static String loginUser(String email, String password)
            throws SQLException, ClassNotFoundException, IOException {
       List <String> l = new ArrayList<String>(2);
       l.add(email);
       l.add(password);
        return (String) sqlMap.queryForObject("loginUser",l);
    }
    public static void createUser(User u)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.insert("insertUser", u);
    }

    public static void deleteUser(String email)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.delete("deleteUser", email);
    }

    public static void updateUser(User u)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.update("updateUser", u);
    }
    // ------------------------------------------------------------------

    public static List<Log> consultaLogs()
            throws SQLException, ClassNotFoundException, IOException {
        return sqlMap.queryForList("getLogs");
    }

    public static void createLog(Log l)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.insert("insertLog", l);
    }

    public static List<Log> consultaLogsForUser(String email)
            throws SQLException, ClassNotFoundException, IOException {
        return sqlMap.queryForList("getLogsForUser",email);
    }
    
    public static void deleteLog(Log l)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.delete("deleteLog", l);
    }

        // ------------------------------------------------------------------

     public static List<Incident> consultaIncidents()
            throws SQLException, ClassNotFoundException, IOException {
        return sqlMap.queryForList("getIncidents");
    }

    public static void createIncident(Incident i)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.insert("insertIncident", i);
    }

    public static List<Incident> consultaIncidentsForUser(String email)
            throws SQLException, ClassNotFoundException, IOException {
        return sqlMap.queryForList("getIncidentsForUser",email);
    }

    public static void deleteIncident(Incident i)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.delete("deleteIncident", i);
    }


       // ------------------------------------------------------------------



    public static void createBlackList(BlackList b)
            throws SQLException, ClassNotFoundException, IOException {

        sqlMap.insert("insertBlackList", b);
    }

    public static void deleteBlackList(BlackList b)
            throws SQLException, ClassNotFoundException, IOException {
        sqlMap.delete("deleteBlackList", b);
    }

      public static BlackList consultaBlacklist(String ip)
            throws SQLException, ClassNotFoundException, IOException {
        return (BlackList)sqlMap.queryForObject("getBlackList",ip);
    }

}
