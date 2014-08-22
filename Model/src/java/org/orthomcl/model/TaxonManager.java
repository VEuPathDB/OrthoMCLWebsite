package org.orthomcl.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.gusdb.fgputil.runtime.InstanceManager;
import org.gusdb.fgputil.runtime.Manageable;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.answer.AnswerValue;
import org.gusdb.wdk.model.question.Question;
import org.gusdb.wdk.model.record.RecordInstance;
import org.gusdb.wdk.model.record.TableValue;
import org.gusdb.wdk.model.record.attribute.AttributeValue;
import org.orthomcl.model.layout.RenderingHelper;

public class TaxonManager implements Manageable<TaxonManager> {

  public static final String HELPER_QUESTION = "HelperQuestions.ByDefault";

  private static final String TABLE_TAXONS = "Taxons";
  private static final String TABLE_ROOTS = "RootTaxons";

  private WdkModel wdkModel;
  private Map<String, Taxon> taxons;

  @Override
  public TaxonManager getInstance(String projectId, String gusHome) throws WdkModelException {
    TaxonManager manager = new TaxonManager();
    manager.wdkModel = InstanceManager.getInstance(WdkModel.class, projectId);
    return manager;
  }

  public synchronized Map<String, Taxon> getTaxons() throws WdkModelException, WdkUserException {
    if (taxons == null)
      taxons = loadTaxons(wdkModel);
    return taxons;
  }

  private Map<String, Taxon> loadTaxons(WdkModel wdkModel) throws WdkModelException, WdkUserException {
    // load helper record into request
    Question question = wdkModel.getQuestion(HELPER_QUESTION);
    AnswerValue answerValue = question.makeAnswerValue(wdkModel.getSystemUser(),
        new LinkedHashMap<String, String>(), true, 0);
    RecordInstance record = answerValue.getRecordInstances()[0];

    Map<String, Taxon> taxons = new LinkedHashMap<>();
    Map<Integer, Integer> parents = new HashMap<>();
    Map<Integer, String> abbreviations = new HashMap<>();
    Map<String, TableValue> tables = record.getTables();

    TableValue taxonTable = tables.get(TABLE_TAXONS);
    for (Map<String, AttributeValue> row : taxonTable) {
      Taxon taxon = new Taxon(Integer.valueOf((String) row.get("taxon_id").getValue()));
      taxon.setAbbrev((String) row.get("abbreviation").getValue());
      taxon.setSpecies(row.get("is_species").getValue().toString().equals("1"));
      taxon.setName((String) row.get("name").getValue());
      taxon.setCommonName((String) row.get("name").getValue());
      taxon.setSortIndex(Integer.valueOf((String) row.get("sort_index").getValue()));
      taxons.put(taxon.getAbbrev(), taxon);
      abbreviations.put(taxon.getId(), taxon.getAbbrev());

      int parentId = Integer.valueOf((String) row.get("parent_id").getValue());
      parents.put(taxon.getId(), parentId);
    }

    // resolve parent/children
    for (Taxon taxon : taxons.values()) {
      int parentId = parents.get(taxon.getId());
      if (taxon.getId() != parentId || abbreviations.containsKey(parentId)) {
        Taxon parent = taxons.get(abbreviations.get(parentId));
        if (taxon != parent) {
          taxon.setParent(parent);
          parent.addChildren(taxon);
        }
      }
    }

    // assign root to each taxon
    TableValue rootTable = tables.get(TABLE_ROOTS);
    assignRoots(taxons, rootTable);

    // assign colors
    assignColors(taxons);

    return taxons;
  }

  private void assignRoots(Map<String, Taxon> taxons, TableValue rootTable) throws WdkModelException,
      WdkUserException {
    Map<String, String> roots = new HashMap<>();
    for (Map<String, AttributeValue> row : rootTable) {
      String abbrev = (String) row.get("taxon_abbrev").getValue();
      String groupColor = (String) row.get("color").getValue();
      roots.put(abbrev, groupColor);
      taxons.get(abbrev).setGroupColor(groupColor);
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

  private void assignColors(Map<String, Taxon> taxons) {
    // only assign colors to species, and group species by roots
    Map<String, List<Taxon>> species = new HashMap<>();
    for (Taxon taxon : taxons.values()) {
      if (taxon.isSpecies()) {
        String rootId = taxon.getRoot().getAbbrev();
        List<Taxon> list = species.get(rootId);
        if (list == null) {
          list = new ArrayList<>();
          species.put(rootId, list);
        }
        list.add(taxon);
      }
    }
    for (List<Taxon> list : species.values()) {
      RenderingHelper.assignRandomColors(list);
    }
  }
}
