package org.orthomcl.controller.action;

import java.io.File;
import java.io.FileInputStream;
import java.util.Map;

import org.apache.log4j.Logger;
import org.gusdb.fgputil.PropFileReader;
import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamDef;
import org.gusdb.wdk.controller.actionutil.ParamDef.Required;
import org.gusdb.wdk.controller.actionutil.ParamDefMapBuilder;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.gusdb.wdk.controller.actionutil.ResponseType;
import org.gusdb.wdk.controller.actionutil.WdkAction;
import org.orthomcl.controller.config.ProteomeServerConfig;

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
  private static final String RESULT_FILE_PREFIX = "orthomclResult-";
  
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
    
    ProteomeServerConfig serverConfig = new ProteomeServerConfig(getGusHome());
    String proteomeId = params.getValue(PROTEOME_ID);
    File zipFile = getZipFile(serverConfig, proteomeId);
    LOG.debug("Looking for file: " + zipFile.getAbsolutePath());
    
    return (zipFile.exists() && zipFile.isFile() && zipFile.canRead()) ?

        new ActionResult(ResponseType.zip)
          .setStream(new FileInputStream(zipFile))
          .setFileName(zipFile.getName()) :

        new ActionResult()
          .setViewName(INPUT)
          .setRequestAttribute(PROTEOME_ID, proteomeId)
          .setRequestAttribute(PURGE_WINDOW, serverConfig.getPurgeWindow());

  }

  protected File getZipFile(ProteomeServerConfig config, String id) {
    return new File(config.getResultsDir() + PropFileReader.FS + RESULT_FILE_PREFIX + id + ".zip");
  }
}
