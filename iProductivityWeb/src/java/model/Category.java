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
public interface Category {

    String getName();

    void setName(String name);

    public Date getCreation_date();

    public void setCreation_date(Date creation_date);
}
