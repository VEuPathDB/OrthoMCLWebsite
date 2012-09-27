/**
 * 
 */
package org.orthomcl.controller.action;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.gusdb.wdk.controller.CConstants;
import org.gusdb.wdk.controller.action.ActionUtility;
import org.gusdb.wdk.model.jspwrap.AnswerValueBean;
import org.gusdb.wdk.model.jspwrap.QuestionBean;
import org.gusdb.wdk.model.jspwrap.RecordBean;
import org.gusdb.wdk.model.jspwrap.UserBean;
import org.gusdb.wdk.model.jspwrap.WdkModelBean;

/**
 * @author jerric
 *
 */
public class GetDataSummaryAction extends Action {

    private static final String PARAM_SUMMARY = "summary";
    
    private static final String SUMMARY_DATA = "data";
    private static final String SUMMARY_RELEASE = "release";
    
    private static final String ATTR_HELPER_RECORD = CConstants.WDK_RECORD_KEY;
    
    private static final String MAP_DATA = SUMMARY_DATA;
    private static final String MAP_RELEASE = SUMMARY_RELEASE;
  
    private static final String HELPER_QUESTION = "HelperQuestions.ByDefault";
    
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // get the data param
        String summary = request.getParameter(PARAM_SUMMARY);
        if (summary == null || !summary.equalsIgnoreCase(SUMMARY_RELEASE))
            summary = SUMMARY_DATA;
        
        // load helper record into request
        WdkModelBean wdkModel = ActionUtility.getWdkModel(servlet);
        QuestionBean question = wdkModel.getQuestion(HELPER_QUESTION);
        UserBean userBean = ActionUtility.getUser(servlet, request);
        Map<String, String> params = new LinkedHashMap<String, String>();
        AnswerValueBean answerValue = question.makeAnswerValue(userBean, params, true, 0);
        RecordBean record = answerValue.getRecords().next();
        request.setAttribute(ATTR_HELPER_RECORD, record);
        
        ActionForward forward = null;
        if (summary.equalsIgnoreCase(SUMMARY_DATA)) {
            forward = mapping.findForward(MAP_DATA);
        } else if (summary.equalsIgnoreCase(SUMMARY_RELEASE)) {
            forward = mapping.findForward(MAP_RELEASE);
        }
        return forward;
    }
}
