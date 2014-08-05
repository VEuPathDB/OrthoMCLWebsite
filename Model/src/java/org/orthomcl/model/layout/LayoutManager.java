package org.orthomcl.model.layout;

import java.text.DecimalFormat;
import java.util.Collection;
import java.util.Map;

import org.eupathdb.common.model.InstanceManager;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.orthomcl.model.Taxon;
import org.orthomcl.model.TaxonManager;

public abstract class LayoutManager {
  
  public static final DecimalFormat FORMAT = new DecimalFormat("0.00");

  protected static final int DEFAULT_SIZE = 700;

  protected static final int MARGIN = 25;

  protected String projectId;

  public int getSize() {
    return DEFAULT_SIZE;
  }
  
  protected void processLayout(Layout layout) throws WdkModelException, WdkUserException {
    // load taxons into layout
    TaxonManager taxonManager = InstanceManager.getInstance(TaxonManager.class, projectId);
    Map<String, Taxon> taxons = taxonManager.getTaxons();
    for (Taxon taxon : taxons.values()) {
      layout.addTaxon(taxon);
    }

    scaleLayout(layout, getSize());
  }

  private void scaleLayout(Layout layout, int size) {
    Collection<Node> nodes = layout.getNodes();

    size -= MARGIN * 2;

    // find min & max coordinates
    double minx = Integer.MAX_VALUE, miny = Integer.MAX_VALUE;
    double maxx = Integer.MIN_VALUE, maxy = Integer.MIN_VALUE;
    for (Node node : nodes) {
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
    for (Node node : nodes) {
      double x = Math.round((node.getX() - minx + dx) * ratio) / 100D + MARGIN;
      double y = Math.round((node.getY() - miny + dy) * ratio) / 100D + MARGIN;
      node.setLocation(x, y);
    }
  }

}
