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
public class CategoryImpl implements Category {
    
    private String name;
    private Date creation_date;

    public CategoryImpl(String name, Date creation_date) {
        this.name = name;
        setCreation_date(creation_date);
    }

    public CategoryImpl(){}

    public Date getCreation_date() {
        return creation_date;
    }

    public void setCreation_date(Date creation_date) {
        this.creation_date = creation_date;
    }

    

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }
    
    
    
}
