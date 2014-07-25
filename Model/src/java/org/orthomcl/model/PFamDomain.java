package org.orthomcl.model;

import org.orthomcl.model.layout.Renderable;

public class PFamDomain implements Renderable, Comparable<PFamDomain> {

  private final String accession;
  private String symbol;
  private String description;
  private int index;
  private int count;
  private String color;

  public PFamDomain(String accession) {
    this.accession = accession;
  }

  /**
   * @return the accession
   */
  public String getAccession() {
    return accession;
  }

  /**
   * @return the symbol
   */
  public String getSymbol() {
    return symbol;
  }

  /**
   * @param symbol
   *          the symbol to set
   */
  public void setSymbol(String symbol) {
    this.symbol = symbol;
  }

  /**
   * @return the description
   */
  public String getDescription() {
    return description;
  }

  /**
   * @param description
   *          the description to set
   */
  public void setDescription(String description) {
    this.description = description;
  }

  /**
   * @return the index
   */
  public int getIndex() {
    return index;
  }

  /**
   * @param index
   *          the index to set
   */
  public void setIndex(int index) {
    this.index = index;
  }

  /**
   * @return the count
   */
  public int getCount() {
    return count;
  }

  /**
   * @param count
   *          the count to set
   */
  public void setCount(int count) {
    this.count = count;
  }

  /**
   * @return the color
   */
  @Override
  public String getColor() {
    return color;
  }

  /**
   * @param color
   *          the color to set
   */
  @Override
  public void setColor(String color) {
    this.color = color;
  }

  @Override
  public int compareTo(PFamDomain pfamDomain) {
    return pfamDomain.index - index;
  }

}
