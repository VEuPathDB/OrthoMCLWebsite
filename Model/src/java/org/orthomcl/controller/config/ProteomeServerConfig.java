package org.orthomcl.controller.config;

import org.apache.log4j.Logger;
import org.gusdb.wdk.model.PropFileReader;

public class ProteomeServerConfig extends PropFileReader {
  
  @SuppressWarnings("unused")
  private static final Logger LOG = Logger.getLogger(ProteomeServerConfig.class.getName());
  
  private static final String FS = System.getProperty("file.separator");
  
  private static final String RELATIVE_CONFIG_FILE = "config/orthomclProteomeSvcServer.prop";

  private static final int DEFAULT_PURGE_WINDOW = 7;

  private static final String PURGE_WINDOW = "purgeWindow";
  private static final String NOT_AVAILABLE = "uploadIsOffline";
  
  private static final String[] REQUIRED_PROPS =
    { PURGE_WINDOW, NOT_AVAILABLE };

  private String _gusHome;
  
  public ProteomeServerConfig(String gusHome) {
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
}
