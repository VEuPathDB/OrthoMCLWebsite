package org.orthomcl.web.model.layout;

import org.gusdb.fgputil.runtime.InstanceManager;
import org.gusdb.fgputil.runtime.Manageable;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.answer.factory.AnswerValue;
import org.orthomcl.model.GeneSet;
import org.orthomcl.model.GeneSetManager;

public class GeneSetLayoutManager extends LayoutManager implements Manageable<GeneSetLayoutManager> {
  
  @Override
  public GeneSetLayoutManager getInstance(String projectId, String gusHome) throws WdkModelException {
    GeneSetLayoutManager layoutManager = new GeneSetLayoutManager();
    layoutManager._projectId = projectId;
    return layoutManager;
  }

  public GroupLayout getLayout(AnswerValue answer, String layoutString) throws WdkModelException, WdkUserException {

    // load gene set
    GeneSetManager geneSetManager = InstanceManager.getInstance(GeneSetManager.class, _projectId);
    GeneSet geneSet = geneSetManager.getGeneSet(answer);
    GroupLayout layout = new GroupLayout(geneSet, getSize());

    loadLayout(layout, layoutString);

    return layout;
  }
}
