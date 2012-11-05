package org.orthomcl.controller.config;

import java.io.File;

import org.apache.log4j.Logger;
import org.gusdb.wdk.model.PropFileReader;

public class ProteomeClusterConfig extends PropFileReader {
  
  @SuppressWarnings("unused")
  private static final Logger LOG = Logger.getLogger(ProteomeConfig.class.getName());
  
  private static final String FS = System.getProperty("file.separator");
  
  private static final String RELATIVE_CONFIG_FILE = "config/orthomclProteomeSvcCluster.prop";

  private static final String CONTROL_DIR = "serverControlDir";

  private static final String[] REQUIRED_PROPS =
    { CONTROL_DIR };

  private String _gusHome;
  
  public ProteomeClusterConfig(String gusHome) {
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
  public String  getResultsDir()      { return getStringValue(CONTROL_DIR) + FS + "results"; }
  
}
