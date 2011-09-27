/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;
import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.TreeMap;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

/**
 *
 * @author javidgon
 */
public class Graphs {

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

    public static double calculateCoefficient(String email)
            throws SQLException, ClassNotFoundException, IOException {
        double alpha = 0.0;
        double minutes = 0.0;
        User u = null;
        double years = 0.0;
        double days = 0.0;
        Calendar d = new GregorianCalendar();
        Calendar e = new GregorianCalendar();
        List l = new ArrayList();
        d.getInstance();

        List<Task> tasks = iProductivity.consultaTasksForUser(email);

        if(tasks.size() > 0){

        Iterator it = tasks.iterator();

        while (it.hasNext()) {

            Task t = (Task) it.next();

            if (t.getDone().equalsIgnoreCase("Yes")) {

                minutes += t.getMinutes();

            }

        }
        }else{

            minutes = 0.0;
        }

        u = iProductivity.consultaUser(email);
        e.setTime(u.getCreation_date());
        years = d.get(Calendar.YEAR) - e.get(Calendar.YEAR);
        days = (d.get(Calendar.DAY_OF_YEAR)+1) - e.get(Calendar.DAY_OF_YEAR);
        alpha = ((minutes / 1440.0) / (days + (365.25 * years)));
        return alpha;

    }

    public static DefaultPieDataset calculateGlobalProductivity()
            throws SQLException, ClassNotFoundException, IOException {
        HashMap<String, Double> map = new HashMap<String, Double>();
        DefaultPieDataset piedataset = new DefaultPieDataset();
        List<User> users = null;
        List<Task> tasks = null;
        Double globalTime = 0D;
        Double time = 0D;
        int counter = 0;
        users = iProductivity.consultaUsersByType(1);

        Iterator it = users.iterator();

        while (it.hasNext()) {
            User u = (User) it.next();
            tasks = iProductivity.consultaTasksForUser(u.getEmail());

            Iterator it2 = tasks.iterator();

            while (it2.hasNext()) {

                Task t = (Task) it2.next();

                if (t.getDone().equalsIgnoreCase("Yes")) {
                    time += t.getMinutes();
                    globalTime += t.getMinutes();
                }
            }
            map.put(u.getEmail(), time);
            time = 0D;
        }


        for (String key : map.keySet()) {
            piedataset.insertValue(counter, key + " (" + String.format("%.2f", (map.get(key) / globalTime) * 100) + "%)", map.get(key) / globalTime);
            counter++;
        }

        return piedataset;

    }
}
