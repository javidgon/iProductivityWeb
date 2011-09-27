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
public interface Incident {

    public Date getCreation_date();

    public void setCreation_date(Date creation_date);

    public String getMessage();

    public void setMessage(String message);

    public String getUser();

    public void setUser(String user);


}
