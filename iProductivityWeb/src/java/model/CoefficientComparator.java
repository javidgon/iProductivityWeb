/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package model;

import java.io.Serializable;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Hokasito
 */
public class CoefficientComparator implements Comparator {

  HashMap base;
  public CoefficientComparator(HashMap base) {
      this.base = base;
  }

  public int compare(Object a, Object b) {

    if((Double)base.get(a) < (Double)base.get(b)) {
      return 1;
    } else if((Double)base.get(a) == (Double)base.get(b)) {
      return 0;
    } else {
      return -1;
    }
  }
}