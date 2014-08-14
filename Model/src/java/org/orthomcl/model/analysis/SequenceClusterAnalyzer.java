/**
 * 
 */
package org.orthomcl.model.analysis;

import org.eupathdb.common.model.InstanceManager;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.analysis.AbstractStepAnalyzer;
import org.gusdb.wdk.model.answer.AnswerValue;
import org.gusdb.wdk.model.user.analysis.ExecutionStatus;
import org.gusdb.wdk.model.user.analysis.StatusLogger;
import org.orthomcl.model.layout.GeneSetLayoutGenerator;
import org.orthomcl.model.layout.GeneSetLayoutManager;
import org.orthomcl.model.layout.Layout;

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
  }

  @Override
  public Object getFormViewModel() throws WdkModelException, WdkUserException {
    return new ClusterFormViewModel(getAnswerValue().getResultSize());
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.gusdb.wdk.model.analysis.StepAnalyzer#getResultViewModel()
   */
  @Override
  public Object getResultViewModel() throws WdkModelException {
    String layoutString = getPersistentCharData();
    String projectId = getWdkModel().getProjectId();
    GeneSetLayoutManager manager = InstanceManager.getInstance(GeneSetLayoutManager.class, projectId);
    try {
      Layout layout = manager.getLayout(getAnswerValue(), layoutString);
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
    Layout layout = generator.generateLayout(answerValue);
    this.setPersistentCharData(layout.toString());
    return ExecutionStatus.COMPLETE;
  }

}