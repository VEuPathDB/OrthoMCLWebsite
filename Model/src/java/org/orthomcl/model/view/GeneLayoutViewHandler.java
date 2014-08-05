package org.orthomcl.model.view;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.eupathdb.common.model.InstanceManager;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.answer.SummaryViewHandler;
import org.gusdb.wdk.model.user.Step;
import org.orthomcl.model.layout.GeneSetLayoutManager;
import org.orthomcl.model.layout.Layout;

public class GeneLayoutViewHandler implements SummaryViewHandler {

  private static final String ATTR_LAYOUT = "layout";

  private static final Logger LOG = Logger.getLogger(GeneLayoutViewHandler.class.getName());

  @Override
  public Map<String, Object> process(Step step) throws WdkModelException, WdkUserException {
    LOG.debug("Entering GeneLayoutViewHandler...");

    // get the layout data
    WdkModel wdkModel = step.getQuestion().getWdkModel();
    GeneSetLayoutManager layoutManager = InstanceManager.getInstance(GeneSetLayoutManager.class,
        wdkModel.getProjectId());
    Layout layout = layoutManager.getLayout(step);

    Map<String, Object> result = new HashMap<>();
    result.put(ATTR_LAYOUT, layout);

    LOG.debug("Leaving GeneLayoutViewHandler...");
    return result;
  }

}
