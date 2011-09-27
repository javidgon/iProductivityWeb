/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package model;

import java.util.Date;


/**
 *
 * @author javidgon
 */
public class TaskImpl implements Task{

    private String description;
    
    private String type;
    
    private String done;
    
    private int minutes; 
    
    private String user;

    private Date creation_date;

    private Date finalization_date;


    public TaskImpl(String description, String type, String done,int minutes, String user) {
        this.description = description;
        this.type = type;
        this.done = done;
        this.minutes = minutes;
        this.user = user;
    }
     public TaskImpl(String description, String type, String done,int minutes, String user,Date creation_date) {
        this.description = description;
        this.type = type;
        this.done = done;
        this.minutes = minutes;
        this.user = user;
        this.creation_date = creation_date;
    }

      public TaskImpl(){}

    public Date getCreation_date() {
        return creation_date;
    }

    public void setCreation_date(Date creation_date) {
        this.creation_date = creation_date;
    }

    public Date getFinalization_date() {
        return finalization_date;
    }

    public void setFinalization_date(Date finalization_date) {
        this.finalization_date = finalization_date;
    }


    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDone() {
        return done;
    }

    public void setDone(String done) {
        this.done = done;
    }

    public int getMinutes() {
        return minutes;
    }

    public void setMinutes(int minutes) {
        this.minutes = minutes;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }
    
    

}
