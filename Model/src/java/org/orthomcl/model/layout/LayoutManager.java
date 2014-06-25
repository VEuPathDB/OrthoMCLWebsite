package org.orthomcl.model.layout;

import java.util.Collection;

import org.eupathdb.common.model.InstanceManager;
import org.gusdb.wdk.model.Manageable;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.record.RecordInstance;
import org.gusdb.wdk.model.user.User;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.orthomcl.model.Group;
import org.orthomcl.model.GroupManager;

public class LayoutManager implements Manageable<LayoutManager> {

  private static final String LAYOUT_ATTRIBUTE = "layout";

  private static final int DEFAULT_SIZE = 800;

  private String projectId;

  @Override
  public LayoutManager getInstance(String projectId, String gusHome) throws WdkModelException {
    LayoutManager layoutManager = new LayoutManager();
    layoutManager.projectId = projectId;
    return layoutManager;
  }

  public int getSize() {
    return DEFAULT_SIZE;
  }

  public Layout getLayout(User user, String name) throws WdkModelException, WdkUserException {
    // first load group
    GroupManager groupManager = InstanceManager.getInstance(GroupManager.class, projectId);
    RecordInstance groupRecord = groupManager.getGroupRecord(user, name);
    Group group = groupManager.getGroup(groupRecord);
    Layout layout = new Layout(name);
    // load layout content
    String layoutString = (String) groupRecord.getAttributeValue(LAYOUT_ATTRIBUTE).getValue();
    if (layoutString == null)
      return null;

    try {
      JSONObject jsLayout = new JSONObject(layoutString);
      JSONArray jsNodes = jsLayout.getJSONArray("N");
      for (int i = 0; i < jsNodes.length(); i++) {
        JSONObject jsNode = jsNodes.getJSONObject(i);

        String sourceId = jsNode.getString("id");
        Node node = new Node(group.getGene(sourceId));
        node.setIndex(jsNode.getInt("i"));

        double x = Double.valueOf(jsNode.getString("x"));
        double y = Double.valueOf(jsNode.getString("y"));
        node.setLocation(x, y);
        layout.addNode(node);
      }

      JSONArray jsEdges = jsLayout.getJSONArray("E");
      for (int i = 0; i < jsEdges.length(); i++) {
        JSONObject jsEdge = jsEdges.getJSONObject(i);
        Node queryNode = layout.getNode(jsEdge.getInt("Q"));
        Node subjectNode = layout.getNode(jsEdge.getInt("S"));
        Edge edge = new Edge(queryNode.getGene().getSourceId(), subjectNode.getGene().getSourceId());
        edge.setType(EdgeType.get(jsEdge.getString("T")));

        // set nodes
        edge.setNodeA(queryNode);
        edge.setNodeB(subjectNode);

        // evalue(s)
        String evalue = jsEdge.getString("E");
        String[] evalues = evalue.split("/");
        edge.setEvalueA(evalues[0]);
        if (evalues.length == 2)
          edge.setEvalueB(evalues[1]);

        layout.addEdge(edge);
      }

      scaleLayout(layout, getSize());

      return layout;
    }
    catch (JSONException ex) {
      throw new WdkModelException(ex);
    }
  }

  private void scaleLayout(Layout layout, int size) {
    Collection<Node> nodes = layout.getNodes();

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
    double ratio = size / Math.max(width, height);
    double dx = (width > height) ? 0 : (height - width) / 2;
    double dy = (width > height) ? (width - height) / 2 : 0;

    // scale the coordinates to a range of [0...size];
    for (Node node : nodes) {
      double x = (node.getX() - minx + dx) * ratio;
      double y = (node.getY() - miny + dy) * ratio;
      node.setLocation(x, y);
    }
  }
}
