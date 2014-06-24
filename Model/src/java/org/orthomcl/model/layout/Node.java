package org.orthomcl.model.layout;

import org.orthomcl.model.Gene;

public class Node {

  private final Gene gene;
  
  private double x;
  private double y;
  
  public Node(Gene gene) {
    this.gene = gene;
  }
  
  public Gene getGene() {
    return gene;
  }
  
  public void setLocation(double x, double y) {
    this.x = x;
    this.y = y;
  }
  
  public double getX() {
    return x;
  }
  
  public double getY() {
    return y;
  }
}
