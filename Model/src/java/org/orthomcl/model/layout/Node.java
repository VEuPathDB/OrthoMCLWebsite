package org.orthomcl.model.layout;

import org.orthomcl.data.layout.Vector;
import org.orthomcl.model.Gene;

public class Node implements org.orthomcl.data.layout.Node{

  private final Gene gene;
  
  private int index;
  private Vector point = new Vector();
  
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
    this.point.setLocation(x, y);
  }
  
  public double getX() {
    return point.x;
  }
  
  public String getXFormatted() {
    return LayoutManager.FORMAT.format(getX());
  }
  
  public double getY() {
    return point.y;
  }
  
  public String getYFormatted() {
    return LayoutManager.FORMAT.format(getY());
  }

  @Override
  public Vector getPoint() {
    return point;
  }
}
