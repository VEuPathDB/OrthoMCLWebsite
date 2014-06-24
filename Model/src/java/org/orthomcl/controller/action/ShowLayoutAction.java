package org.orthomcl.controller.action;

import java.util.Map;

import org.apache.log4j.Logger;
import org.eupathdb.common.model.InstanceManager;
import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamDef;
import org.gusdb.wdk.controller.actionutil.ParamDef.Required;
import org.gusdb.wdk.controller.actionutil.ParamDefMapBuilder;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.gusdb.wdk.controller.actionutil.WdkAction;
import org.gusdb.wdk.model.jspwrap.UserBean;
import org.orthomcl.model.layout.Layout;
import org.orthomcl.model.layout.LayoutManager;

public class ShowLayoutAction extends WdkAction {

  private static final Logger logger = Logger.getLogger(ShowLayoutAction.class.getName());

  private static final String PARAM_GROUP_NAME = "group_name";
  
  private static final String ATTR_LAYOUT = "layout";
  
  private static final String MAP_LAYOUT = "layout";

  @Override
  protected boolean shouldValidateParams() {
    return false;
  }

  @Override
  protected Map<String, ParamDef> getParamDefs() {
    return new ParamDefMapBuilder().addParam(PARAM_GROUP_NAME, new ParamDef(Required.REQUIRED)).toMap();
  }

  @Override
  protected ActionResult handleRequest(ParamGroup params) throws Exception {
    logger.debug("Entering ShowLayoutAction...");
    
    UserBean userBean = getCurrentUser();

    // get the layout data
    String groupName = params.getValue(PARAM_GROUP_NAME);
    LayoutManager layoutManager = InstanceManager.getInstance(LayoutManager.class, getWdkModel().getProjectId());
    Layout layout = layoutManager.getLayout(userBean.getUser(), groupName);
    
    ActionResult result = new ActionResult().setViewName(MAP_LAYOUT);
    result.setRequestAttribute(ATTR_LAYOUT, layout);
    
    return result;
  }
}
