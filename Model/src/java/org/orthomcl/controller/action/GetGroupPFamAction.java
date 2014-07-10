package org.orthomcl.controller.action;

import java.io.ByteArrayInputStream;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.eupathdb.common.model.InstanceManager;
import org.gusdb.wdk.controller.action.standard.GenericPageAction;
import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamDef;
import org.gusdb.wdk.controller.actionutil.ParamDef.Required;
import org.gusdb.wdk.controller.actionutil.ParamDefMapBuilder;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.gusdb.wdk.controller.actionutil.ResponseType;
import org.gusdb.wdk.model.user.User;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.orthomcl.model.GroupManager;
import org.orthomcl.model.PFamDomain;

public class GetGroupPFamAction extends GenericPageAction {

  private static final Logger LOG = Logger.getLogger(ShowLayoutAction.class.getName());

  private static final String PARAM_GROUP_NAME = "group_name";

  @Override
  protected Map<String, ParamDef> getParamDefs() {
    return new ParamDefMapBuilder().addParam(PARAM_GROUP_NAME, new ParamDef(Required.REQUIRED)).toMap();
  }

  @Override
  protected ActionResult handleRequest(ParamGroup params) throws Exception {
    LOG.debug("Entering GetGroupPFamAction...");

    User user = getCurrentUser().getUser();

    // get the layout data
    String groupName = params.getValue(PARAM_GROUP_NAME);
    GroupManager groupManager = InstanceManager.getInstance(GroupManager.class, getWdkModel().getProjectId());
    
    Map<String, PFamDomain> pfams = groupManager.getPFamDomains(user, groupName);
    Map<String, Set<String>> proteinPfams = groupManager.getProteinPFamDomains(user, groupName);
    
    // prepare result
    byte[] data = convertToJSON(pfams, proteinPfams).toString().getBytes();
    return new ActionResult(ResponseType.json).setStream(new ByteArrayInputStream(data));
  }
  
  private JSONObject convertToJSON(Map<String, PFamDomain> pfams, Map<String, Set<String>> proteinPfams) throws JSONException {
    JSONObject jsGroup = new JSONObject();
    
    JSONArray jsPfams = new JSONArray();
    for (PFamDomain pfam: pfams.values()) {
      JSONObject jsPfam = new JSONObject();
      jsPfam.put("accession", pfam.getAccession());
      jsPfam.put("symbol", pfam.getSymbol());
      jsPfam.put("description", pfam.getDescription());
      jsPfam.put("count", pfam.getCount());
      jsPfam.put("index", pfam.getIndex());
      jsPfam.put("color", pfam.getColor());
      jsPfams.put(jsPfam);
    }
    jsGroup.put("pfamDomains", jsPfams);
    
    JSONArray jsProteins = new JSONArray();
    for (String sourceId : proteinPfams.keySet()) {
      JSONObject jsProtein = new JSONObject();
      jsProtein.put("sourceId", sourceId);
      jsProtein.put("accessions", new JSONArray(proteinPfams.get(sourceId)));
      jsProteins.put(jsProtein);
    }
    jsGroup.put("proteins", jsProteins);
    
    return jsGroup;
  }
}
