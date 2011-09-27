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
public interface Task {

    public Date getCreation_date();

    public void setCreation_date(Date creation_date);

    String getDescription();

    String getDone();

    int getMinutes();


    String getType();

    String getUser();

    void setDescription(String description);

    void setDone(String done);

    void setMinutes(int minutes);

    void setType(String type);

    void setUser(String user);

    public Date getFinalization_date();

    public void setFinalization_date(Date finalization_date);
}
