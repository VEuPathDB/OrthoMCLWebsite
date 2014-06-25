package org.orthomcl.model.layout;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.orthomcl.model.GenePair;

public class Layout {

  private final String groupName;
  private final Map<Integer, Node> nodes;
  private final Map<GenePair, Edge> edges;
  private final int size;

  public Layout(String groupName, int size) {
    this.groupName = groupName;
    this.edges = new HashMap<>();
    this.nodes = new HashMap<>();
    this.size = size;
  }
  
  public int getSize() {
    return size;
  }
  
  public String getGroupName() {
    return groupName;
  }
  
  public Collection<Edge> getEdges() {
    return edges.values();
  }
  
  public void addEdge(Edge edge) {
    this.edges.put(edge, edge);
  }
  
  public Collection<Node> getNodes() {
    return nodes.values();
  }
  
  public Node getNode(int index) {
    return nodes.get(index);
  }
  
  public void addNode(Node node) {
    this.nodes.put(node.getIndex(), node);
  }
}
