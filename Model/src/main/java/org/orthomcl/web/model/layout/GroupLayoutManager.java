package org.orthomcl.web.model.layout;

import org.gusdb.fgputil.runtime.InstanceManager;
import org.gusdb.fgputil.runtime.Manageable;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.record.RecordInstance;
import org.gusdb.wdk.model.user.User;
import org.json.JSONException;
import org.orthomcl.model.Group;
import org.orthomcl.model.GroupManager;

public class GroupLayoutManager extends LayoutManager implements Manageable<GroupLayoutManager> {

  private static final String LAYOUT_ATTRIBUTE = "layout";

  @Override
  public GroupLayoutManager getInstance(String projectId, String gusHome) throws WdkModelException {
    GroupLayoutManager layoutManager = new GroupLayoutManager();
    layoutManager._projectId = projectId;
    return layoutManager;
  }

  public GroupLayout getLayout(User user, String name) throws WdkModelException, WdkUserException {
    GroupManager groupManager = InstanceManager.getInstance(GroupManager.class, _projectId);
    RecordInstance groupRecord = groupManager.getGroupRecord(user, name);

    // load layout content
    String layoutString = (String) groupRecord.getAttributeValue(LAYOUT_ATTRIBUTE).getValue();
    if (layoutString == null)
      return null;

    // load group
    Group group = groupManager.getGroup(groupRecord);
    GroupLayout layout = new GroupLayout(group, getSize());

    try {
      loadLayout(layout, layoutString);

      return layout;
    }
    catch (JSONException ex) {
      throw new WdkModelException(ex);
    }
  }
}
