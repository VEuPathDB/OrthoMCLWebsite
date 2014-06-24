package org.orthomcl.model.layout;

import org.eupathdb.common.model.InstanceManager;
import org.gusdb.wdk.model.Manageable;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.record.RecordInstance;
import org.gusdb.wdk.model.user.User;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.orthomcl.model.Gene;
import org.orthomcl.model.Group;
import org.orthomcl.model.GroupManager;

public class LayoutManager implements Manageable<LayoutManager> {

  private static final String LAYOUT_ATTRIBUTE = "layout";

  @Override
  public LayoutManager getInstance(String projectId, String gusHome) throws WdkModelException {
    LayoutManager layoutManager = new LayoutManager();
    return layoutManager;
  }

  public Layout getLayout(User user, String name) throws WdkModelException, WdkUserException {
    // first load group
    GroupManager groupManager = InstanceManager.getInstance(GroupManager.class, name);
    RecordInstance groupRecord = groupManager.getGroupRecord(user, name);
    Group group = groupManager.getGroup(groupRecord);
    Layout layout = new Layout(name);

    // create nodes from genes
    for (Gene gene : group.getGenes()) {
      layout.addNode(new Node(gene));
    }
    // load layout content
    String layoutString = (String) groupRecord.getAttributeValue(LAYOUT_ATTRIBUTE).getValue();
    if (layoutString == null)
      return null;

    try {
      JSONObject jsLayout = new JSONObject(layoutString);
      JSONArray jsNodes = jsLayout.getJSONArray("N");
      for (int i = 0; i < jsNodes.length(); i++) {
        JSONObject jsNode = jsNodes.getJSONObject(i);
        Node node = layout.getNode(jsNode.getString("id"));
        double x = Double.valueOf(jsNode.getString("x"));
        double y = Double.valueOf(jsNode.getString("y"));
        node.setLocation(x, y);
      }

      JSONArray jsEdges = jsLayout.getJSONArray("E");
      for (int i = 0; i < jsEdges.length(); i++) {
        JSONObject jsEdge = jsEdges.getJSONObject(i);
        String queryId = jsEdge.getString("Q");
        String subjectId = jsEdge.getString("S");
        Edge edge = new Edge(queryId, subjectId);
        edge.setType(EdgeType.get(jsEdge.getString("T")));
        
        // set nodes
        edge.setNodeA(layout.getNode(queryId));
        edge.setNodeB(layout.getNode(subjectId));
        
        // evalue(s)
        String evalue = jsEdge.getString("E");
        String[] evalues = evalue.split("/");
        edge.setEvalueA(evalues[0]);
        if (evalues.length == 2)
          edge.setEvalueB(evalues[1]);
        
        layout.addEdge(edge);
      }

      return layout;
    }
    catch (JSONException ex) {
      throw new WdkModelException(ex);
    }
  }
}
