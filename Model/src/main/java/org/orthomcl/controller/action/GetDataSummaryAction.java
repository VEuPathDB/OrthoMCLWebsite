/**
 * 
 */
package org.orthomcl.controller.action;

import java.util.Map;

import org.gusdb.fgputil.runtime.InstanceManager;
import org.gusdb.fgputil.validation.ValidObjectFactory.RunnableObj;
import org.gusdb.fgputil.validation.ValidationLevel;
import org.gusdb.wdk.controller.CConstants;
import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamDef;
import org.gusdb.wdk.controller.actionutil.ParamDef.Required;
import org.gusdb.wdk.controller.actionutil.ParamDefMapBuilder;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.gusdb.wdk.controller.actionutil.WdkAction;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.answer.factory.AnswerValueFactory;
import org.gusdb.wdk.model.answer.spec.AnswerSpec;
import org.gusdb.wdk.model.jspwrap.AnswerValueBean;
import org.gusdb.wdk.model.jspwrap.QuestionBean;
import org.gusdb.wdk.model.jspwrap.RecordBean;
import org.gusdb.wdk.model.jspwrap.RecordClassBean;
import org.gusdb.wdk.model.jspwrap.WdkModelBean;
import org.gusdb.wdk.model.record.TableValue;
import org.gusdb.wdk.model.user.StepContainer;
import org.orthomcl.model.Taxon;
import org.orthomcl.model.TaxonManager;

/**
 * @author jerric
 */
public class GetDataSummaryAction extends WdkAction {

  private static final String PARAM_SUMMARY = "summary";

  //private static final String SUMMARY_DATA = "data";
  private static final String SUMMARY_RELEASE = "release";

  private static final String ATTR_HELPER_RECORD = CConstants.WDK_RECORD_KEY;
  private static final String ATTR_TAXONS = "taxons";
  private static final String ATTR_SUMMARY = "summaryTable";
  private static final String ATTR_RECORD_CLASS = "recordClass";

  //private static final String MAP_DATA = SUMMARY_DATA;
  private static final String MAP_RELEASE = SUMMARY_RELEASE;

  @Override
  protected boolean shouldValidateParams() {
    return true;
  }

  @Override
  protected Map<String, ParamDef> getParamDefs() {
    return new ParamDefMapBuilder().addParam(PARAM_SUMMARY,
        new ParamDef(Required.OPTIONAL)).toMap();
  }

  @Override
  protected ActionResult handleRequest(ParamGroup params) throws Exception {

    // get the data param to determine view
    String summary = params.getValueOrEmpty(PARAM_SUMMARY);
    ActionResult result = new ActionResult().setViewName(MAP_RELEASE);

    // load helper record into request
    WdkModelBean wdKModel = getWdkModel();
    QuestionBean question = wdKModel.getQuestion(TaxonManager.HELPER_QUESTION);
    RecordClassBean recordClass = question.getRecordClass();
    RunnableObj<AnswerSpec> answerSpec = AnswerSpec
        .builder(getWdkModel().getModel())
        .setQuestionName(TaxonManager.HELPER_QUESTION)
        .build(getCurrentUser().getUser(), StepContainer.emptyContainer(), ValidationLevel.RUNNABLE)
        .getRunnable()
        .getOrThrow(spec -> new WdkModelException(TaxonManager.HELPER_QUESTION + " is no longer in question or requires params."));
    AnswerValueBean answerValue = new AnswerValueBean(
        AnswerValueFactory.makeAnswer(getCurrentUser().getUser(), answerSpec));

    RecordBean record = answerValue.getRecords().next();

    result.setRequestAttribute(ATTR_RECORD_CLASS, recordClass);

    Map<String, TableValue> tables = record.getTables();
    TableValue summaryTable = tables.get(summary.equalsIgnoreCase(SUMMARY_RELEASE) ? "ReleaseSummary" : "DataSummary");
    result.setRequestAttribute(ATTR_SUMMARY, summaryTable);

    TaxonManager taxonManager = InstanceManager.getInstance(TaxonManager.class, wdKModel.getProjectId());
    Map<String, Taxon> taxons = taxonManager.getTaxons();
    result.setRequestAttribute(ATTR_TAXONS, taxons);
    return result.setRequestAttribute(ATTR_HELPER_RECORD, record);

  }

}
