package org.orthomcl.controller;

import org.gusdb.wdk.controller.ApplicationInitListener;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.orthomcl.model.InstanceManager;

public class OrthoMCLContextListener extends ApplicationInitListener {

  /**
   * get wdk model from singleton manager instead.
   * 
   * @see org.gusdb.wdk.controller.ApplicationInitListener#createWdkModel(java.lang.String, java.lang.String)
   */
  @Override
  protected WdkModel createWdkModel(String project, String gusHome) throws WdkModelException {
    return InstanceManager.getWdkModel(project);
  }

}
