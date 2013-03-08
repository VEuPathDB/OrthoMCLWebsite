package org.orthomcl.controller.action;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class Taxon implements Comparable<Taxon> {

  private final int id;
  private String abbrev;
  private String name;
  private String commonName;
  private int sortIndex;
  private boolean species;
  private Taxon parent;
  private Taxon root;
  private String color;
  private Map<Integer, Taxon> children;

  public Taxon(int id) {
    this.id = id;
    this.children = new HashMap<Integer, Taxon>();
  }

  public int getId() {
    return id;
  }

  public String getAbbrev() {
    return abbrev;
  }

  public void setAbbrev(String abbrev) {
    this.abbrev = abbrev;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getCommonName() {
    return commonName;
  }

  public void setCommonName(String commonName) {
    this.commonName = commonName;
  }

  public int getSortIndex() {
    return sortIndex;
  }

  public void setSortIndex(int sortIndex) {
    this.sortIndex = sortIndex;
  }

  public boolean isSpecies() {
    return species;
  }

  public void setSpecies(boolean species) {
    this.species = species;
  }

  public Taxon getParent() {
    return parent;
  }

  public void setParent(Taxon parent) {
    this.parent = parent;
  }

  public Map<Integer, Taxon> getChildrenMap() {
    return children;
  }

  public Taxon[] getChildren() {
    Taxon[] array = new Taxon[children.size()];
    children.values().toArray(array);
    Arrays.sort(array);
    return array;
  }

  public void addChildren(Taxon child) {
    this.children.put(child.getId(), child);
  }

  public Taxon getRoot() {
    return root;
  }

  public void setRoot(Taxon root) {
    this.root = root;
  }

  public String getColor() {
    return color;
  }

  public void setColor(String color) {
    this.color = color;
  }

  @Override
  public int compareTo(Taxon taxon) {
    int diff = this.sortIndex - taxon.sortIndex;
    if (diff != 0)
      return diff;
    return this.abbrev.compareTo(taxon.abbrev);
  }

}
