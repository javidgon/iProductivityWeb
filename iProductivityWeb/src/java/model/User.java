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
public interface User {

    String getName();

    String getPassword();

    String getSurname();

    int getType();

    public String getEmail();

    public void setEmail(String email);

    void setName(String name);

    void setPassword(String password);

    void setSurname(String surname);

    void setType(int type);

    public String getBoss();

    public void setBoss(String boss);

        public Date getCreation_date();

    public void setCreation_date(Date creation_date);
}
