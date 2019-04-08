package org.orthomcl.model.analysis;

import org.gusdb.fgputil.runtime.InstanceManager;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.analysis.AbstractStepAnalyzer;
import org.gusdb.wdk.model.answer.AnswerValue;
import org.gusdb.wdk.model.user.analysis.ExecutionStatus;
import org.gusdb.wdk.model.user.analysis.StatusLogger;
import org.json.JSONObject;
import org.orthomcl.web.model.layout.GeneSetLayoutGenerator;
import org.orthomcl.web.model.layout.GeneSetLayoutManager;
import org.orthomcl.web.model.layout.GroupLayout;

/**
 * @author Jerric
 *
 */
public class SequenceClusterAnalyzer extends AbstractStepAnalyzer {

  public static class ClusterFormViewModel {

    private final int resultSize;

    public ClusterFormViewModel(int resultSize) {
      this.resultSize = resultSize;
    }

    public int getResultSize() {
      return resultSize;
    }

    public int getMaxSize() {
      return GeneSetLayoutGenerator.MAX_GENES;
    }

    public boolean isHasLayout() {
      return (resultSize <= getMaxSize());
    }
    
    public JSONObject toJson() {
      JSONObject json = new JSONObject();
      json.put("resultSize", resultSize);
      return json;
    }
  }

  @Override
  public JSONObject getFormViewModelJson() throws WdkModelException {
    try {
      return createFormViewModel().toJson();
    } catch(WdkUserException e) {
      throw new WdkModelException(e);
    }
  }

  private ClusterFormViewModel createFormViewModel() throws WdkModelException, WdkUserException {
    return new ClusterFormViewModel(getAnswerValue().getResultSizeFactory().getResultSize());
  }

  @Override 
  public JSONObject getResultViewModelJson() throws WdkModelException {
    return createResultViewModel().toJson();
  }
  
  private GroupLayout createResultViewModel() throws WdkModelException {
    String layoutString = getPersistentCharData();
    String projectId = getWdkModel().getProjectId();
    GeneSetLayoutManager manager = InstanceManager.getInstance(GeneSetLayoutManager.class, projectId);
    try {
      GroupLayout layout = manager.getLayout(getAnswerValue(), layoutString);
      return layout;
    }
    catch (WdkUserException ex) {
      throw new WdkModelException(ex);
    }
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.gusdb.wdk.model.analysis.StepAnalyzer#runAnalysis(org.gusdb.wdk.model.answer.AnswerValue,
   * org.gusdb.wdk.model.user.analysis.StatusLogger)
   */
  @Override
  public ExecutionStatus runAnalysis(AnswerValue answerValue, StatusLogger log) throws WdkModelException,
      WdkUserException {
    GeneSetLayoutGenerator generator = new GeneSetLayoutGenerator();
    GroupLayout layout = generator.generateLayout(answerValue);
    this.setPersistentCharData(layout.toString());
    return ExecutionStatus.COMPLETE;
  }

}
