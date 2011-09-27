/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author javidgon
 */
public interface BlackList {

    public Date getDate();

    public void setDate(Date date);

    String getIp();

    void setIp(String ip);
}
