package org.orthomcl.controller.config;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

public class ProteomeConfig {

  public static final String CONFIG_FILE =
      System.getenv("GUS_HOME") + "/config/orthomcl-svc.config";

  public static final String[] REQUIRED_PROPS =
    { "isAvailable" };
  
  public static final Properties _props;
  
  static {
    try {
      _props = new Properties();
      _props.load(new FileReader(CONFIG_FILE));
      for (String key : REQUIRED_PROPS) {
        if (!_props.containsKey(key)) {
          throw new IOException("Proteome config file missing property [ " + key + "].");
        }
      }
    }
    catch (IOException ioe) {
      throw new RuntimeException("Cannot load config file [ " + CONFIG_FILE + " ]", ioe);
    }
  }

  public static boolean isServiceAvailable() {
    String val = (String)_props.get("isAvailable");
    return ("true").equalsIgnoreCase(val) || ("yes").equalsIgnoreCase(val);
  }
  
  
  
}
