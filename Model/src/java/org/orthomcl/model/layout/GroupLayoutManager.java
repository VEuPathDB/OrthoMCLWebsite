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
import org.orthomcl.model.Group;
import org.orthomcl.model.GroupManager;

public class GroupLayoutManager extends LayoutManager implements Manageable<GroupLayoutManager> {

  private static final String LAYOUT_ATTRIBUTE = "layout";

  @Override
  public GroupLayoutManager getInstance(String projectId, String gusHome) throws WdkModelException {
    GroupLayoutManager layoutManager = new GroupLayoutManager();
    layoutManager.projectId = projectId;
    return layoutManager;
  }

  public Layout getLayout(User user, String name) throws WdkModelException, WdkUserException {
    GroupManager groupManager = InstanceManager.getInstance(GroupManager.class, projectId);
    RecordInstance groupRecord = groupManager.getGroupRecord(user, name);

    // load layout content
    String layoutString = (String) groupRecord.getAttributeValue(LAYOUT_ATTRIBUTE).getValue();
    if (layoutString == null)
      return null;

    // load group
    Group group = groupManager.getGroup(groupRecord);
    Layout layout = new Layout(group, getSize());

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
        edge.setScore(Math.log10(Double.valueOf(evalues[0])));
        if (evalues.length == 2) {
          edge.setEvalueB(evalues[1]);
          double scoreB = Math.log10(Double.valueOf(evalues[1]));
          edge.setScore((edge.getScore() + scoreB) / 2);
        }

        layout.addEdge(edge);
      }
      
      // do further processing on the layout.
      processLayout(layout);

      return layout;
    }
    catch (JSONException ex) {
      throw new WdkModelException(ex);
    }
  }
}
