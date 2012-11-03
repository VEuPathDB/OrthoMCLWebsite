package org.orthomcl.controller.action;

import java.io.File;
import java.io.FileInputStream;
import java.util.Map;

import org.apache.log4j.Logger;
import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamDef;
import org.gusdb.wdk.controller.actionutil.ParamDef.Required;
import org.gusdb.wdk.controller.actionutil.ParamDefMapBuilder;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.gusdb.wdk.controller.actionutil.ResponseType;
import org.gusdb.wdk.controller.actionutil.WdkAction;
import org.orthomcl.controller.config.ProteomeConfig;

/**
 * Facilitates download of completed proteome job.  Returns 'input' if file
 * cannot be found or job id is missing.
 * 
 * @author rdoherty
 */
public class ProteomeDownloadAction extends WdkAction {

  private static final Logger LOG = Logger.getLogger(ProteomeDownloadAction.class.getName());
  
  private static final String PROTEOME_ID = "jobId";
  private static final String PURGE_WINDOW = "purgeWindow";
  
  @Override
  protected boolean shouldValidateParams() {
    return true;
  }

  @Override
  protected Map<String, ParamDef> getParamDefs() {
    return new ParamDefMapBuilder().addParam(PROTEOME_ID, new ParamDef(Required.REQUIRED)).toMap();
  }

  @Override
  protected ActionResult handleRequest(ParamGroup params) throws Exception {
    
    ProteomeConfig config = new ProteomeConfig(getGusHome());
    String proteomeId = params.getValue(PROTEOME_ID);
    File zipFile = config.getZipFile(proteomeId);
    LOG.debug("Looking for file: " + zipFile.getAbsolutePath());
    
    return (zipFile.exists() && zipFile.isFile() && zipFile.canRead()) ?

        new ActionResult(ResponseType.zip)
          .setStream(new FileInputStream(zipFile))
          .setFileName(zipFile.getName()) :

        new ActionResult()
          .setViewName(INPUT)
          .setRequestAttribute(PROTEOME_ID, proteomeId)
          .setRequestAttribute(PURGE_WINDOW, config.getPurgeWindow());

  }
}
