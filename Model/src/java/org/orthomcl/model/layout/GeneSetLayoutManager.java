package org.orthomcl.model.layout;

import org.gusdb.fgputil.runtime.InstanceManager;
import org.gusdb.fgputil.runtime.Manageable;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.answer.AnswerValue;
import org.orthomcl.model.GeneSet;
import org.orthomcl.model.GeneSetManager;

public class GeneSetLayoutManager extends LayoutManager implements Manageable<GeneSetLayoutManager> {
  
  @Override
  public GeneSetLayoutManager getInstance(String projectId, String gusHome) throws WdkModelException {
    GeneSetLayoutManager layoutManager = new GeneSetLayoutManager();
    layoutManager.projectId = projectId;
    return layoutManager;
  }

  public Layout getLayout(AnswerValue answer, String layoutString) throws WdkModelException, WdkUserException {

    // load gene set
    GeneSetManager geneSetManager = InstanceManager.getInstance(GeneSetManager.class, projectId);
    GeneSet geneSet = geneSetManager.getGeneSet(answer);
    Layout layout = new Layout(geneSet, getSize());

    loadLayout(layout, layoutString);

    return layout;
  }
}
