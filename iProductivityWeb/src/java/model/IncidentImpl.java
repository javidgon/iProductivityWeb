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
public class IncidentImpl implements Incident{

    private String user;
    private String message;
    private Date creation_date;

    public IncidentImpl(String message, String user, Date creation_date){

        this.setUser(user);
        this.setMessage(message);
        this.setCreation_date(creation_date);


    }

    public IncidentImpl(){}

    public Date getCreation_date() {
        return creation_date;
    }

    public void setCreation_date(Date creation_date) {
        this.creation_date = creation_date;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }



}
