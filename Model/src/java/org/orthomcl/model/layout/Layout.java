package org.orthomcl.model.layout;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.orthomcl.model.Gene;
import org.orthomcl.model.GenePair;
import org.orthomcl.model.Taxon;

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

  public Map<String, List<Edge>> getEdgesByType() {
    Map<String, List<Edge>> edges = new HashMap<>();
    for (Edge edge : this.edges.values()) {
      List<Edge> list = edges.get(edge.getType().name());
      if (list == null) {
        list = new ArrayList<>();
        edges.put(edge.getType().name(), list);
      }
      list.add(edge);
    }
    return edges;
  }

  public void addEdge(Edge edge) {
    this.edges.put(edge, edge);
  }

  public Collection<Node> getNodes() {
    return nodes.values();
  }

  public Map<String, List<Node>> getNodesByTaxon() {
    Map<String, List<Node>> nodes = new HashMap<>();
    for (Node node : this.nodes.values()) {
      Gene gene = node.getGene();
      Taxon taxon = gene.getTaxon();
      String abbrev = taxon.getAbbrev();
      List<Node> list = nodes.get(abbrev);
      if (list == null) {
        list = new ArrayList<>();
        nodes.put(node.getGene().getTaxon().getAbbrev(), list);
      }
      list.add(node);
    }
    return nodes;
  }

  public Node getNode(int index) {
    return nodes.get(index);
  }

  public void addNode(Node node) {
    this.nodes.put(node.getIndex(), node);
  }
}
