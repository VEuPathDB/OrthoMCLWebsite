package org.orthomcl.model.layout;

import org.gusdb.fgputil.runtime.InstanceManager;
import org.gusdb.wdk.model.Utilities;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.user.Step;
import org.gusdb.wdk.model.user.User;
import org.json.JSONObject;
import org.junit.Assert;
import org.junit.Test;
import org.orthomcl.web.model.layout.GeneSetLayoutManager;
import org.orthomcl.web.model.layout.GroupLayout;

public class GeneSetLayoutTest {

  private final String projectId;
  private final User user;

  public GeneSetLayoutTest() throws WdkModelException {
    projectId = System.getProperty(Utilities.ARGUMENT_PROJECT_ID);
    WdkModel wdkModel = InstanceManager.getInstance(WdkModel.class, projectId);
    user = wdkModel.getUserFactory().getUserByEmail("jerric@pcbi.upenn.edu");
  }

  @Test
  public void testLoadLayout() throws WdkModelException, WdkUserException {
    // this step has 6 sequences from 2 groups with the same PFam domain;
    Step step = user.getWdkModel().getStepFactory().getStepById(100069240);
    GeneSetLayoutManager layoutManager = InstanceManager.getInstance(GeneSetLayoutManager.class, projectId);
    GroupLayout layout = layoutManager.getLayout(step.getAnswerValue(), getLayoutJson().toString());
    Assert.assertEquals(6, layout.getNodes().size());
  }

  // FIXME: configure layout to fix this test!!!
  private JSONObject getLayoutJson() {
    JSONObject json = new JSONObject();
    return json;
  }
}