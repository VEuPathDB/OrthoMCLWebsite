package org.orthomcl.model;

import org.orthomcl.web.model.layout.Renderable;

public class EcNumber implements Renderable, Comparable<EcNumber> {

  private final String code;
  private int index;
  private String color;
  private int count = 0;
  
  public EcNumber(String code) {
    this.code = code;
  }

  /**
   * @return the code
   */
  public String getCode() {
    return code;
  }

  /**
   * @return the index
   */
  public int getIndex() {
    return index;
  }

  /**
   * @param index the index to set
   */
  public void setIndex(int index) {
    this.index = index;
  }

  /**
   * @return the color
   */
  @Override
  public String getColor() {
    return color;
  }

  /**
   * @param color the color to set
   */
  @Override
  public void setColor(String color) {
    this.color = color;
  }

  /**
   * @return the count
   */
  public int getCount() {
    return count;
  }

  /**
   * @param count the count to set
   */
  public void setCount(int count) {
    this.count = count;
  }

  @Override
  public int compareTo(EcNumber ecNumber) {
    return code.compareToIgnoreCase(ecNumber.code);
  }
}