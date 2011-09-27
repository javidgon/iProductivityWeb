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
public class UserImpl implements User{
    
    private String email;
    
    private String name;
    
    private String surname;
    
    private String password;
    
    private int type;

    private String boss;

    private Date creation_date;

    public UserImpl(String email, String password, String name, String surname, int type, String boss) {
        this.email = email;
        this.name = name;
        this.surname = surname;
        this.password = password;
        this.type = type;
        this.boss = boss;
    }

     public UserImpl(String email, String password, String name, String surname, int type, String boss, Date creation_date) {
        this.email = email;
        this.name = name;
        this.surname = surname;
        this.password = password;
        this.type = type;
        this.boss = boss;
        this.creation_date = creation_date;
    }

    public UserImpl(){}

    public Date getCreation_date() {
        return creation_date;
    }

    public void setCreation_date(Date creation_date) {
        this.creation_date = creation_date;
    }

    public String getBoss() {
        return boss;
    }

    public void setBoss(String boss) {
        this.boss = boss;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    
  

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String getSurname() {
        return surname;
    }

    @Override
    public void setSurname(String surname) {
        this.surname = surname;
    }

    @Override
    public int getType() {
        return type;
    }

    @Override
    public void setType(int type) {
        this.type = type;
    }
    
    
    
}
