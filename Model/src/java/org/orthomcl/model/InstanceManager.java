package org.orthomcl.model;

import java.util.HashMap;
import java.util.Map;

import org.gusdb.fgputil.runtime.GusHome;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;

public class InstanceManager {

  private static final Map<String, WdkModel> wdkModels = new HashMap<>();

  public static WdkModel getWdkModel(String projectId) throws WdkModelException {
    projectId = projectId.intern();
    synchronized (projectId) {
      WdkModel wdkModel = wdkModels.get(projectId);
      if (wdkModel == null) {
        String gusHome = GusHome.getGusHome();
        wdkModel = WdkModel.construct(projectId, gusHome);
        wdkModels.put(projectId, wdkModel);
      }
      return wdkModel;
    }
  }
}
