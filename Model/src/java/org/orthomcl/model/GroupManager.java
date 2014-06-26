package org.orthomcl.model;

import java.util.LinkedHashMap;
import java.util.Map;

import org.eupathdb.common.model.InstanceManager;
import org.gusdb.wdk.model.Manageable;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.record.RecordClass;
import org.gusdb.wdk.model.record.RecordInstance;
import org.gusdb.wdk.model.record.TableValue;
import org.gusdb.wdk.model.record.attribute.AttributeValue;
import org.gusdb.wdk.model.user.User;

public class GroupManager implements Manageable<GroupManager> {

  private static final String RECORD_CLASS = "GroupRecordClasses.GroupRecordClass";
  private static final String GROUP_NAME_KEY = "group_name";
  private static final String GENES_TABLE = "Sequences";

  private WdkModel wdkModel;

  @Override
  public GroupManager getInstance(String projectId, String gusHome) throws WdkModelException {
    GroupManager manager = new GroupManager();
    manager.wdkModel = InstanceManager.getInstance(WdkModel.class, projectId);
    return manager;
  }

  public RecordInstance getGroupRecord(User user, String name) throws WdkModelException, WdkUserException {
    RecordClass recordClass = wdkModel.getRecordClass(RECORD_CLASS);
    Map<String, Object> pkValues = new LinkedHashMap<>();
    pkValues.put(GROUP_NAME_KEY, name);
    RecordInstance instance = new RecordInstance(user, recordClass, pkValues);
    return instance;
  }

  public Group getGroup(User user, String name) throws WdkModelException, WdkUserException {
    RecordInstance groupRecord = getGroupRecord(user, name);
    return getGroup(groupRecord);
  }

  public Group getGroup(RecordInstance groupRecord) throws WdkModelException, WdkUserException {
    String name = groupRecord.getPrimaryKey().getValues().get(GROUP_NAME_KEY);
    Group group = new Group(name);

    // get Taxons
    TaxonManager taxonManager = InstanceManager.getInstance(TaxonManager.class, wdkModel.getProjectId());
    Map<String, Taxon> taxons = taxonManager.getTaxons();

    // load genes
    TableValue genesTable = groupRecord.getTableValue(GENES_TABLE);
    for (Map<String, AttributeValue> row : genesTable) {
      Gene gene = new Gene((String) row.get("full_id").getValue());
      gene.setDescription((String) row.get("description").getValue());
      gene.setEcNumbers((String) row.get("ec_numbers").getValue());
      gene.setLength(Long.valueOf(row.get("length").getValue().toString()));

      // get taxon
      String taxonAbbrev = (String) row.get("taxon_abbrev").getValue();
      gene.setTaxon(taxons.get(taxonAbbrev));
      group.addGene(gene);
    }

    return group;
  }
}
