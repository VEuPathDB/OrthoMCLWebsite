package org.orthomcl.model.layout;

import org.eupathdb.common.model.InstanceManager;
import org.gusdb.wdk.model.Utilities;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.user.Step;
import org.gusdb.wdk.model.user.User;
import org.junit.Assert;
import org.junit.Test;

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
    Step step = user.getStep(100069240);
    GeneSetLayoutManager layoutManager = InstanceManager.getInstance(GeneSetLayoutManager.class, projectId);
    Layout layout = layoutManager.getLayout(step);
    Assert.assertEquals(6, layout.getNodes().size());
  }
}
