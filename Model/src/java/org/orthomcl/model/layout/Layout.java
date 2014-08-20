package org.orthomcl.model.layout;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.orthomcl.data.layout.Graph;
import org.orthomcl.model.Gene;
import org.orthomcl.model.GenePair;
import org.orthomcl.model.Group;
import org.orthomcl.model.Taxon;

public class Layout implements Graph {

  private final Group group;
  private final Map<String, Taxon> taxons;
  private final Map<Integer, Node> nodes;
  private final Map<GenePair, Edge> edges;
  private final Map<String, Integer> taxonCounts;
  private final int size;

  private int minEvalueExp;
  private int maxEvalueExp;

  public Layout(Group group, int size) {
    this.group = group;
    this.taxons = new LinkedHashMap<>();
    this.edges = new LinkedHashMap<>();
    this.nodes = new LinkedHashMap<>();
    this.taxonCounts = new HashMap<>();
    this.size = size;
    this.minEvalueExp = Integer.MAX_VALUE;
    this.maxEvalueExp = Integer.MIN_VALUE;
  }

  public int getMaxSize() {
    return GeneSetLayoutGenerator.MAX_GENES;
  }
  
  public int getSize() {
    return size;
  }

  public Group getGroup() {
    return group;
  }

  public void addTaxon(Taxon taxon) {
    this.taxons.put(taxon.getAbbrev(), taxon);
  }

  public Collection<Taxon> getTaxons() {
    return taxons.values();
  }

  public Edge getEdge(GenePair genePair) {
    return edges.get(genePair);
  }

  @Override
  public Collection<Edge> getEdges() {
    // sort edges
    List<Edge> list = new ArrayList<>(edges.values());
    Collections.sort(list);
    return list;
  }

  public Map<String, List<Edge>> getEdgesByType() {
    Map<String, List<Edge>> edges = new HashMap<>();
    for (Edge edge : getEdges()) {
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
    // also calculate the evalue range
    String evalueA = edge.getEvalueA(), evalueB = edge.getEvalueB();
    int expA = Integer.valueOf(evalueA.split("[eE]")[1]);
    if (evalueB == null || evalueA.equals(evalueB)) {
      if (minEvalueExp > expA)
        minEvalueExp = expA;
      if (maxEvalueExp < expA)
        maxEvalueExp = expA;
    }
    else {
      int expB = Integer.valueOf(evalueB.split("[eE]")[1]);
      int minExp = Math.min(expA, expB);
      if (minEvalueExp > minExp)
        minEvalueExp = minExp;
      int maxExp = Math.max(expA, expB);
      if (maxEvalueExp < maxExp)
        maxEvalueExp = maxExp;
    }
  }

  @Override
  public Collection<Node> getNodes() {
    // sort the nodes, so that the client can bind it by array;
    Integer[] keys = nodes.keySet().toArray(new Integer[0]);
    Arrays.sort(keys);
    List<Node> list = new ArrayList<>(nodes.size());
    for (int key : keys) {
      list.add(nodes.get(key));
    }
    return list;
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
    // also calculate the gene counts by taxons
    String abbrev = node.getGene().getTaxon().getAbbrev();
    if (taxonCounts.containsKey(abbrev)) {
      int count = taxonCounts.get(abbrev);
      taxonCounts.put(abbrev, count + 1);
    }
    else {
      taxonCounts.put(abbrev, 1);
    }
  }

  public Map<Taxon, Integer> getTaxonCounts() {
    // get the taxons with genes
    List<Taxon> list = new ArrayList<>(taxonCounts.size());
    for (String abbrev : taxonCounts.keySet()) {
      list.add(taxons.get(abbrev));
    }
    Collections.sort(list);

    // prepare the map, with the order of taxons preserved
    Map<Taxon, Integer> map = new LinkedHashMap<>(taxonCounts.size());
    for (Taxon taxon : list) {
      map.put(taxon, taxonCounts.get(taxon.getAbbrev()));
    }
    return map;
  }

  public int getMinEvalueExp() {
    return minEvalueExp;
  }

  public int getMaxEvalueExp() {
    return maxEvalueExp;
  }

  @Override
  public double getMaxPreferredLength() {
    return org.orthomcl.data.core.Group.MAX_PREFERRED_LENGTH;
  }

  @Override
  public String toString() {
    JSONObject jsLayout = new JSONObject();

    try {
      // output genes
      JSONArray jsNodes = new JSONArray();
      for (Node node : nodes.values()) {
        jsNodes.put(node.toJSON());
      }
      jsLayout.put("N", jsNodes);

      // output scores
      JSONArray jsEdges = new JSONArray();
      for (Edge edge : edges.values()) {
        jsEdges.put(edge.toJSON());
      }
      jsLayout.put("E", jsEdges);
      return jsLayout.toString();
    }
    catch (JSONException ex) {
      throw new RuntimeException(ex);
    }

  }
}
