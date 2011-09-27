/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Date;

/**
 *
 * @author Hokasito
 */
public interface Log {

    String getMessage();

    String getUser();

    void setMessage(String message);

    void setUser(String user);

       public Date getCreation_date();

    public void setCreation_date(Date creation_date);
    
}
