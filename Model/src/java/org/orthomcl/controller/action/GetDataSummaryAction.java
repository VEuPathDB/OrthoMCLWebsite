/**
 * 
 */
package org.orthomcl.controller.action;

import java.util.LinkedHashMap;
import java.util.Map;

import org.gusdb.wdk.controller.CConstants;
import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamDef;
import org.gusdb.wdk.controller.actionutil.ParamDef.Required;
import org.gusdb.wdk.controller.actionutil.ParamDefMapBuilder;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.gusdb.wdk.controller.actionutil.ResponseType;
import org.gusdb.wdk.controller.actionutil.WdkAction;
import org.gusdb.wdk.model.jspwrap.AnswerValueBean;
import org.gusdb.wdk.model.jspwrap.QuestionBean;
import org.gusdb.wdk.model.jspwrap.RecordBean;

/**
 * @author jerric
 */
public class GetDataSummaryAction extends WdkAction {

    private static final String PARAM_SUMMARY = "summary";
    
    private static final String SUMMARY_DATA = "data";
    private static final String SUMMARY_RELEASE = "release";
    
    private static final String ATTR_HELPER_RECORD = CConstants.WDK_RECORD_KEY;
    
    private static final String MAP_DATA = SUMMARY_DATA;
    private static final String MAP_RELEASE = SUMMARY_RELEASE;
  
    private static final String HELPER_QUESTION = "HelperQuestions.ByDefault";

    @Override
    protected ResponseType getResponseType() {
      return ResponseType.html;
    }

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
      ActionResult result = new ActionResult()
        .setViewName(summary.equalsIgnoreCase(SUMMARY_RELEASE) ?
            MAP_RELEASE : MAP_DATA);
      
      // load helper record into request
      QuestionBean question = getWdkModel().getQuestion(HELPER_QUESTION);
      AnswerValueBean answerValue = question.makeAnswerValue(getCurrentUser(),
          new LinkedHashMap<String, String>(), true, 0);
      RecordBean record = answerValue.getRecords().next();
      
      return result.setRequestAttribute(ATTR_HELPER_RECORD, record);
      
    }
}
