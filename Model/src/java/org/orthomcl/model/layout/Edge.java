package org.orthomcl.model.layout;

import org.orthomcl.model.GenePair;

public class Edge extends GenePair {

  private String evalueA;
  private String evalueB;
  private EdgeType type;
  private Node nodeA;
  private Node nodeB;

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
}
