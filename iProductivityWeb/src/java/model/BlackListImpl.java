/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package model;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author javidgon
 */
public class BlackListImpl implements BlackList {

    private String ip;
    private Date date;

    public BlackListImpl(){

    }

    public BlackListImpl(String ip, Date date){

        this.setIp(ip);
        this.setDate(date);


    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }


}
