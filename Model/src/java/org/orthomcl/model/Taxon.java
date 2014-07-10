package org.orthomcl.model;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class Taxon implements Comparable<Taxon>, Renderable {

  private final int id;
  private String abbrev;
  private String name;
  private String commonName;
  private int sortIndex;
  private boolean species;
  private Taxon parent;
  private Taxon root;
  private String groupColor;
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

  public String getFullName() {
    String fullName = name;
    if (commonName != null && !commonName.equals(name)) {
      fullName += " (" + commonName + ")";
    }
    return fullName;
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

  @Override
  public String getColor() {
    return color;
  }

  @Override
  public void setColor(String color) {
    this.color = color;
  }

  /**
   * @return the groupColor
   */
  public String getGroupColor() {
    if (groupColor == null && parent != null)
      groupColor = parent.getGroupColor(); 
    return groupColor;
  }

  /**
   * @param groupColor
   *          the groupColor to set
   */
  public void setGroupColor(String groupColor) {
    this.groupColor = groupColor;
  }

  @Override
  public int compareTo(Taxon taxon) {
    int diff = this.sortIndex - taxon.sortIndex;
    if (diff != 0)
      return diff;
    return this.abbrev.compareTo(taxon.abbrev);
  }

}
