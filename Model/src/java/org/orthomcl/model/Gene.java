package org.orthomcl.model;

public class Gene {

  private final String sourceId;
  private Taxon taxon;
  private String description;
  private long length;
  private String ecNumbers;

  public Gene(String sourceId) {
    this.sourceId = sourceId;
  }

  public String getSourceId() {
    return sourceId;
  }

  /**
   * @return the taxon
   */
  public Taxon getTaxon() {
    return taxon;
  }

  /**
   * @param taxon
   *          the taxon to set
   */
  public void setTaxon(Taxon taxon) {
    this.taxon = taxon;
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
   * @return the length
   */
  public long getLength() {
    return length;
  }

  /**
   * @param length
   *          the length to set
   */
  public void setLength(long length) {
    this.length = length;
  }

  /**
   * @return the ecNumbers
   */
  public String getEcNumbers() {
    return ecNumbers;
  }

  /**
   * @param ecNumbers
   *          the ecNumbers to set
   */
  public void setEcNumbers(String ecNumbers) {
    this.ecNumbers = ecNumbers;
  }

}