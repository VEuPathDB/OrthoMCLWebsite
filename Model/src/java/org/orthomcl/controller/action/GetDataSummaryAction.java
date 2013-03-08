/**
 * 
 */
package org.orthomcl.controller.action;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import org.gusdb.wdk.controller.CConstants;
import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamDef;
import org.gusdb.wdk.controller.actionutil.ParamDef.Required;
import org.gusdb.wdk.controller.actionutil.ParamDefMapBuilder;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.gusdb.wdk.controller.actionutil.WdkAction;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.jspwrap.AnswerValueBean;
import org.gusdb.wdk.model.jspwrap.QuestionBean;
import org.gusdb.wdk.model.jspwrap.RecordBean;
import org.gusdb.wdk.model.record.TableValue;
import org.gusdb.wdk.model.record.attribute.AttributeValue;
import org.json.JSONException;

/**
 * @author jerric
 */
public class GetDataSummaryAction extends WdkAction {

  private static final String PARAM_SUMMARY = "summary";

  private static final String SUMMARY_DATA = "data";
  private static final String SUMMARY_RELEASE = "release";

  private static final String ATTR_HELPER_RECORD = CConstants.WDK_RECORD_KEY;
  private static final String ATTR_TAXONS = "taxons";
  private static final String ATTR_SUMMARY = "summaryTable";

  private static final String MAP_DATA = SUMMARY_DATA;
  private static final String MAP_RELEASE = SUMMARY_RELEASE;

  private static final String HELPER_QUESTION = "HelperQuestions.ByDefault";

  private static final String TABLE_TAXONS = "Taxons";
  private static final String TABLE_ROOTS = "RootTaxons";

  @Override
  protected boolean shouldValidateParams() {
    return true;
  }

  @Override
  protected Map<String, ParamDef> getParamDefs() {
    return new ParamDefMapBuilder().addParam(PARAM_SUMMARY,
        new ParamDef(Required.OPTIONAL)).toMap();
  }

  @Override
  protected ActionResult handleRequest(ParamGroup params) throws Exception {

    // get the data param to determine view
    String summary = params.getValueOrEmpty(PARAM_SUMMARY);
    ActionResult result = new ActionResult().setViewName(MAP_RELEASE);

    // load helper record into request
    QuestionBean question = getWdkModel().getQuestion(HELPER_QUESTION);
    AnswerValueBean answerValue = question.makeAnswerValue(getCurrentUser(),
        new LinkedHashMap<String, String>(), true, 0);
    RecordBean record = answerValue.getRecords().next();
    Map<String, Taxon> taxons = loadTaxons(record);

    Map<String, TableValue> tables = record.getTables();
    TableValue summaryTable = tables.get(summary.equalsIgnoreCase(SUMMARY_RELEASE) ? "ReleaseSummary" : "DataSummary");
    result.setRequestAttribute(ATTR_SUMMARY, summaryTable);

    result.setRequestAttribute(ATTR_TAXONS, taxons);
    return result.setRequestAttribute(ATTR_HELPER_RECORD, record);

  }

  private Map<String, Taxon> loadTaxons(RecordBean record)
      throws NoSuchAlgorithmException, WdkModelException, WdkUserException,
      SQLException, JSONException {
    Map<String, Taxon> taxons = new LinkedHashMap<>();
    Map<Integer, Integer> parents = new HashMap<>();
    Map<Integer, String> abbreviations = new HashMap<>();
    Map<String, TableValue> tables = record.getTables();

    TableValue taxonTable = tables.get(TABLE_TAXONS);
    for (Map<String, AttributeValue> row : taxonTable) {
      Taxon taxon = new Taxon(Integer.valueOf((String)row.get("taxon_id").getValue()));
      taxon.setAbbrev((String) row.get("abbreviation").getValue());
      taxon.setSpecies(row.get("is_species").getValue().toString().equals("1"));
      taxon.setName((String) row.get("name").getValue());
      taxon.setCommonName((String) row.get("name").getValue());
      taxon.setSortIndex(Integer.valueOf((String)row.get("sort_index").getValue()));
      taxons.put(taxon.getAbbrev(), taxon);
      abbreviations.put(taxon.getId(), taxon.getAbbrev());

      int parentId = Integer.valueOf((String)row.get("parent_id").getValue());
      parents.put(taxon.getId(), parentId);
    }

    // resolve parent/children
    for (Taxon taxon : taxons.values()) {
      int parentId = parents.get(taxon.getId());
      if (abbreviations.containsKey(parentId)) {
        Taxon parent = taxons.get(abbreviations.get(parentId));
        taxon.setParent(parent);
        parent.addChildren(taxon);
      }
    }

    // assign root to each taxon
    TableValue rootTable = tables.get(TABLE_ROOTS);
    assignRoots(taxons, rootTable);

    return taxons;
  }

  private void assignRoots(Map<String, Taxon> taxons, TableValue rootTable)
      throws WdkModelException {
    Map<String, String> roots = new HashMap<>();
    for (Map<String, AttributeValue> row : rootTable) {
      String abbrev = (String) row.get("taxon_abbrev").getValue();
      String color = (String) row.get("color").getValue();
      roots.put(abbrev, color);
      taxons.get(abbrev).setColor(color);
    }

    for (Taxon taxon : taxons.values()) {
      if (!taxon.isSpecies())
        continue;
      Taxon parent = taxon.getParent();
      while (parent != null) {
        if (roots.containsKey(parent.getAbbrev())) {
          taxon.setRoot(parent);
          break;
        }
        parent = parent.getParent();
      }
    }
  }
}
