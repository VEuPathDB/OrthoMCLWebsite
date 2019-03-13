package org.orthomcl.controller.action;

import java.util.Map;

import org.gusdb.fgputil.runtime.InstanceManager;
import org.gusdb.fgputil.validation.ValidationLevel;
import org.gusdb.wdk.controller.CConstants;
import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamDef;
import org.gusdb.wdk.controller.actionutil.ParamDef.Required;
import org.gusdb.wdk.controller.actionutil.ParamDefMapBuilder;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.gusdb.wdk.controller.actionutil.WdkAction;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.answer.AnswerValue;
import org.gusdb.wdk.model.answer.factory.AnswerValueFactory;
import org.gusdb.wdk.model.answer.spec.AnswerSpec;
import org.gusdb.wdk.model.question.Question;
import org.gusdb.wdk.model.record.RecordClass;
import org.gusdb.wdk.model.record.RecordInstance;
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
    WdkModel wdkModel = getWdkModel().getModel();
    Question question = wdkModel.getQuestionByFullName(TaxonManager.HELPER_QUESTION)
        .orElseThrow(() -> new WdkModelException(TaxonManager.HELPER_QUESTION + " can not be found in this WDK model."));
    RecordClass recordClass = question.getRecordClass();
    AnswerValue answerValue = AnswerValueFactory
        .makeAnswer(getCurrentUser(), AnswerSpec.builder(wdkModel)
        .setQuestionFullName(TaxonManager.HELPER_QUESTION)
        .build(getCurrentUser(), StepContainer.emptyContainer(), ValidationLevel.RUNNABLE)
        .getRunnable()
        .getOrThrow(answerSpec -> new WdkModelException(TaxonManager.HELPER_QUESTION + " did not produce a runnable answer spec.")));
    RecordInstance record = answerValue.getRecordInstances()[0];

    // FIXME: this was previously setting a RecordClassBean; the RecordClass API may not match perfectly
    result.setRequestAttribute(ATTR_RECORD_CLASS, recordClass);

    Map<String, TableValue> tables = record.getTableValueMap();
    TableValue summaryTable = tables.get(summary.equalsIgnoreCase(SUMMARY_RELEASE) ? "ReleaseSummary" : "DataSummary");
    result.setRequestAttribute(ATTR_SUMMARY, summaryTable);

    TaxonManager taxonManager = InstanceManager.getInstance(TaxonManager.class, wdkModel.getProjectId());
    Map<String, Taxon> taxons = taxonManager.getTaxons();
    result.setRequestAttribute(ATTR_TAXONS, taxons);
    return result.setRequestAttribute(ATTR_HELPER_RECORD, record);

  }

}
