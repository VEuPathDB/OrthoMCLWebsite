package org.orthomcl.model.layout;

import org.orthomcl.model.GenePair;

public class Edge extends GenePair {

  public static final int MIN_EVALUE = -180;
  public static final int MAX_EVALUE = -5;

  private String evalueA;
  private String evalueB;
  private double score;
  private EdgeType type;
  private Node nodeA;
  private Node nodeB;
  private String color;

  public Edge(String sourceIdA, String sourceIdB) {
    super(sourceIdA, sourceIdB);
  }

  public String getEvalue() {
    String evalue = evalueA;
    if (evalueB != null && evalueA.equals(evalueB))
      evalue += " / " + evalueB;
    return evalue;
  }

  /**
   * @return the evalueA
   */
  public String getEvalueA() {
    return evalueA;
  }

  /**
   * @param evalueA
   *          the evalueA to set
   */
  public void setEvalueA(String evalueA) {
    this.evalueA = evalueA;
  }

  /**
   * @return the evalueB
   */
  public String getEvalueB() {
    return evalueB;
  }

  /**
   * @param evalueB
   *          the evalueB to set
   */
  public void setEvalueB(String evalueB) {
    this.evalueB = evalueB;
  }

  /**
   * @return the type
   */
  public EdgeType getType() {
    return type;
  }

  /**
   * @param type
   *          the type to set
   */
  public void setType(EdgeType type) {
    this.type = type;
  }

  /**
   * @return the nodeA
   */
  public Node getNodeA() {
    return nodeA;
  }

  /**
   * @param nodeA
   *          the nodeA to set
   */
  public void setNodeA(Node nodeA) {
    this.nodeA = nodeA;
  }

  /**
   * @return the nodeB
   */
  public Node getNodeB() {
    return nodeB;
  }

  /**
   * @param nodeB
   *          the nodeB to set
   */
  public void setNodeB(Node nodeB) {
    this.nodeB = nodeB;
  }

  /**
   * @return the score
   */
  public double getScore() {
    return score;
  }

  public String getScoreFormatted() {
    return LayoutManager.FORMAT.format(score);
  }

  /**
   * @param score
   *          the score to set
   */
  public void setScore(double score) {
    this.score = score;
  }

  /**
   * @return the color
   */
  public String getColor() {
    if (color == null) {
      int value = (int) Math.round((score - MIN_EVALUE) * 256 / (MAX_EVALUE - MIN_EVALUE + 1));
      if (value > 255)
        value = 255;
      else if (value < 0)
        value = 0;
      color = "#" + toHex(value) + "00" + toHex(255 - value);
    }
    return color;
  }
  
  private String toHex(int value) {
    String hex = Integer.toHexString(value);
    if (hex.length() == 1) hex = "0" + hex;
    return hex;
  }
}
