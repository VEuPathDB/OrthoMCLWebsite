package org.orthomcl.controller.config;

import java.io.File;

import org.apache.log4j.Logger;
import org.gusdb.wdk.model.PropFileReader;

public class ProteomeConfig extends PropFileReader {
  
  @SuppressWarnings("unused")
  private static final Logger LOG = Logger.getLogger(ProteomeConfig.class.getName());
  
  private static final String FS = System.getProperty("file.separator");
  
  private static final String RELATIVE_CONFIG_FILE = "config/orthomclProteomeSvcServer.prop";

  private static final String RESULT_FILE_PREFIX = "orthomclResult-";
  private static final int DEFAULT_PURGE_WINDOW = 7;

  private static final String CONTROL_DIR = "controlDir";
  private static final String PURGE_WINDOW = "purgeWindow";
  private static final String NOT_AVAILABLE = "uploadIsOffline";
  
  private static final String[] REQUIRED_PROPS =
    { PURGE_WINDOW, NOT_AVAILABLE, CONTROL_DIR };

  private String _gusHome;
  
  public ProteomeConfig(String gusHome) {
    _gusHome = gusHome;
    loadProperties();
  };
  
  @Override
  protected String getPropertyFile() {
    return _gusHome + FS + RELATIVE_CONFIG_FILE;
  }

  @Override
  protected String[] getRequiredProps() {
    return REQUIRED_PROPS;
  }
  
  // getters for properties
  public boolean isServiceAvailable() { return !getBoolValue(NOT_AVAILABLE); }
  public int     getPurgeWindow()     { return getIntValue(PURGE_WINDOW, DEFAULT_PURGE_WINDOW); }
  public String  getResultsDir()      { return getStringValue(CONTROL_DIR) + FS + "results"; }
  
  public File getZipFile(String id) {
    return new File(getResultsDir() + FS + RESULT_FILE_PREFIX + id + ".zip");
  }

}
