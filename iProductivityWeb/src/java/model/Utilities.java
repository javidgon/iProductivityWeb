/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author javidgon
 */
import java.text.DateFormat;
import java.text.ParseException;
import java.util.Date;

public class Utilities {

    public static int diferenciasDeFechas(Date fechaInicial, Date fechaFinal) {
        DateFormat df = DateFormat.getDateInstance(DateFormat.MEDIUM);
        String fechaInicioString = df.format(fechaInicial);
        try {
            fechaInicial = df.parse(fechaInicioString);
        } catch (ParseException ex) {
        }
        String fechaFinalString = df.format(fechaFinal);
        try {
            fechaFinal = df.parse(fechaFinalString);
        } catch (ParseException ex) {
        }
        long fechaInicialMs = fechaInicial.getTime();
        long fechaFinalMs = fechaFinal.getTime();
        long diferencia = fechaFinalMs - fechaInicialMs;
        double dias = Math.floor(diferencia / (1000 * 60 * 60 * 24));
        return ((int) dias);
    }

    public static int numberOfDaysInAMonth(int month) {
        int days = 0;
        switch (month) {

            case 0: {

                days = 31;
                break;
            }
            case 1: {

                days = 28;
                break;
            }
            case 2: {

                days = 31;
                break;
            }
            case 3: {

                days = 30;
                break;
            }
            case 4: {

                days = 31;
                break;
            }
            case 5: {

                days = 30;
                break;
            }
            case 6: {

                days = 31;
                break;
            }
            case 7: {

                days = 30;
                break;
            }
            case 8: {

                days = 31;
                break;
            }
            case 9: {

                days = 31;
                break;
            }
            case 10: {

                days = 30;
                break;
            }
            case 11: {

                days = 31;
                break;
            }
}
            return days;

        }

    public static double truncate(double x){
  if ( x > 0 )
    return Math.floor(x * 100)/100;

  else
    return Math.ceil(x * 100)/100;
}

    }

