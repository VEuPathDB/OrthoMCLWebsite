package org.orthomcl.web.model.layout;

import java.text.DecimalFormat;
import java.util.Collection;
import java.util.Map;

import org.gusdb.fgputil.runtime.InstanceManager;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.json.JSONArray;
import org.json.JSONObject;
import org.orthomcl.model.Group;
import org.orthomcl.model.Taxon;
import org.orthomcl.model.TaxonManager;

public abstract class LayoutManager {

  public static final DecimalFormat FORMAT = new DecimalFormat("0.00");

  protected static final int DEFAULT_SIZE = 700;

  protected static final int MARGIN = 25;

  protected String _projectId;

  public int getSize() {
    return DEFAULT_SIZE;
  }

  protected void loadLayout(GroupLayout layout, String layoutString) throws WdkModelException, WdkUserException {
    JSONObject jsLayout = new JSONObject(layoutString);
    JSONArray jsNodes = jsLayout.getJSONArray("N");
    Group group = layout.getGroup();
    for (int i = 0; i < jsNodes.length(); i++) {
      JSONObject jsNode = jsNodes.getJSONObject(i);

      String sourceId = jsNode.getString("id");
      GeneNode node = new GeneNode(group.getGene(sourceId));
      node.setIndex(jsNode.getInt("i"));

      double x = Double.valueOf(jsNode.getString("x"));
      double y = Double.valueOf(jsNode.getString("y"));
      node.setLocation(x, y);
      layout.addNode(node);
    }

    JSONArray jsEdges = jsLayout.getJSONArray("E");
    for (int i = 0; i < jsEdges.length(); i++) {
      JSONObject jsEdge = jsEdges.getJSONObject(i);
      GeneNode queryNode = layout.getNode(jsEdge.getInt("Q"));
      GeneNode subjectNode = layout.getNode(jsEdge.getInt("S"));
      BlastEdge edge = new BlastEdge(queryNode.getGene().getSourceId(), subjectNode.getGene().getSourceId());
      edge.setType(EdgeType.get(jsEdge.getString("T")));

      // set nodes
      edge.setNodeA(queryNode);
      edge.setNodeB(subjectNode);

      // evalue(s)
      String evalue = jsEdge.getString("E");
      String[] evalues = evalue.split("/");
      edge.setEvalueA(evalues[0]);
      edge.setScore(Math.log10(Double.valueOf(evalues[0])));
      if (evalues.length == 2) {
        edge.setEvalueB(evalues[1]);
        double scoreB = Math.log10(Double.valueOf(evalues[1]));
        edge.setScore((edge.getScore() + scoreB) / 2);
      }

      layout.addEdge(edge);
    }

    processLayout(layout);
  }

  private void processLayout(GroupLayout layout) throws WdkModelException, WdkUserException {
    // load taxons into layout
    TaxonManager taxonManager = InstanceManager.getInstance(TaxonManager.class, _projectId);
    Map<String, Taxon> taxons = taxonManager.getTaxons();
    for (Taxon taxon : taxons.values()) {
      layout.addTaxon(taxon);
    }

    scaleLayout(layout, getSize());
  }

  private void scaleLayout(GroupLayout layout, int size) {
    Collection<GeneNode> nodes = layout.getNodes();

    size -= MARGIN * 2;

    // find min & max coordinates
    double minx = Integer.MAX_VALUE, miny = Integer.MAX_VALUE;
    double maxx = Integer.MIN_VALUE, maxy = Integer.MIN_VALUE;
    for (GeneNode node : nodes) {
      if (minx > node.getX())
        minx = node.getX();
      if (maxx < node.getX())
        maxx = node.getX();
      if (miny > node.getY())
        miny = node.getY();
      if (maxy < node.getY())
        maxy = node.getY();
    }

    double width = maxx - minx, height = maxy - miny;
    double ratio = 100D * size / Math.max(width, height);
    double dx = (width > height) ? 0 : (height - width) / 2;
    double dy = (width > height) ? (width - height) / 2 : 0;

    // scale the coordinates to a range of [0...size];
    for (GeneNode node : nodes) {
      double x = Math.round((node.getX() - minx + dx) * ratio) / 100D + MARGIN;
      double y = Math.round((node.getY() - miny + dy) * ratio) / 100D + MARGIN;
      node.setLocation(x, y);
    }
  }

}
