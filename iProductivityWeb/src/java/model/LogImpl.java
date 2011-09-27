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
public class LogImpl implements Log {

    
    private String message;
    
    private String user;

    private Date creation_date;

    public LogImpl(String message, String user) {
        this.message = message;
        this.user = user;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final LogImpl other = (LogImpl) obj;
        if ((this.message == null) ? (other.message != null) : !this.message.equals(other.message)) {
            return false;
        }
        if ((this.user == null) ? (other.user != null) : !this.user.equals(other.user)) {
            return false;
        }
        if (this.creation_date != other.creation_date && (this.creation_date == null || !this.creation_date.equals(other.creation_date))) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 37 * hash + (this.message != null ? this.message.hashCode() : 0);
        hash = 37 * hash + (this.user != null ? this.user.hashCode() : 0);
        hash = 37 * hash + (this.creation_date != null ? this.creation_date.hashCode() : 0);
        return hash;
    }

    public LogImpl(String message, String user, Date creation_date) {
        this.message = message;
        this.user = user;
        this.creation_date = creation_date;
    }


    public LogImpl(){}

    public Date getCreation_date() {
        return creation_date;
    }

    public void setCreation_date(Date creation_date) {
        this.creation_date = creation_date;
    }

    @Override
    public String getMessage() {
        return message;
    }

    @Override
    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String getUser() {
        return user;
    }

    @Override
    public void setUser(String user) {
        this.user = user;
    }
    
    
    
}
