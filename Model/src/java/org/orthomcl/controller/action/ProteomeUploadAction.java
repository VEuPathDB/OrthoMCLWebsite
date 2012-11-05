/**
 * 
 */
package org.orthomcl.controller.action;

import org.gusdb.wdk.controller.action.standard.GenericPageAction;
import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.orthomcl.controller.config.ProteomeServerConfig;

/**
 * @author rdoherty
 */
public class ProteomeUploadAction extends GenericPageAction {

  @Override
  protected ActionResult handleRequest(ParamGroup params) throws Exception {
    return new ActionResult().setViewName(SUCCESS)
        .setRequestAttribute("isServiceAvailable",
            new ProteomeServerConfig(getGusHome()).isServiceAvailable());
  }

}
