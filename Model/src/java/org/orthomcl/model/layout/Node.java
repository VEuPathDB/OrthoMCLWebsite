package org.orthomcl.model.layout;

import org.orthomcl.data.layout.Vector;
import org.orthomcl.model.Gene;

public class Node implements org.orthomcl.data.layout.Node{

  private final Gene gene;
  
  private int index;
  private double x;
  private double y;
  
  public Node(Gene gene) {
    this.gene = gene;
  }
  
  public Gene getGene() {
    return gene;
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

  public void setLocation(double x, double y) {
    this.x = x;
    this.y = y;
  }
  
  public double getX() {
    return x;
  }
  
  public String getXFormatted() {
    return GroupLayoutManager.FORMAT.format(x);
  }
  
  public double getY() {
    return y;
  }
  
  public String getYFormatted() {
    return GroupLayoutManager.FORMAT.format(y);
  }

  @Override
  public Vector getPoint() {
    return new Vector(x, y);
  }
}
