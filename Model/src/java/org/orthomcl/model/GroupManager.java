package org.orthomcl.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
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
  private static final String PFAMS_TABLE = "PFams";
  private static final String PROTEIN_PFAMS_TABLE = "ProteinPFams";

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
    Map<String, Integer> ecNumbers = new HashMap<>();
    TableValue genesTable = groupRecord.getTableValue(GENES_TABLE);
    for (Map<String, AttributeValue> row : genesTable) {
      Gene gene = new Gene((String) row.get("full_id").getValue());
      gene.setDescription((String) row.get("description").getValue());
      gene.setLength(Long.valueOf(row.get("length").getValue().toString()));

      // get taxon
      String taxonAbbrev = (String) row.get("taxon_abbrev").getValue();
      gene.setTaxon(taxons.get(taxonAbbrev));

      String ecNumberString = (String) row.get("ec_numbers").getValue();
      if (ecNumberString != null) {
        for (String ecNumber : ecNumberString.split(",")) {
          ecNumber = ecNumber.trim();
          if (ecNumber.length() > 0) {
            gene.addEcNumber(ecNumber);
            if (ecNumbers.containsKey(ecNumber)) {
              ecNumbers.put(ecNumber, ecNumbers.get(ecNumber) + 1);
            }
            else {
              ecNumbers.put(ecNumber, 1);
            }
          }
        }
      }
      group.addGene(gene);
    }

    // load pfam info
    loadPFamDomains(group, groupRecord);

    // TODO - process ec numbers to form tree
    processEcNumbers(group, ecNumbers);

    return group;
  }

  private void loadPFamDomains(Group group, RecordInstance groupRecord) throws WdkModelException,
      WdkUserException {
    // load pfam domian information
    List<PFamDomain> pfams = new ArrayList<>();
    TableValue pfamsTable = groupRecord.getTableValue(PFAMS_TABLE);
    for (Map<String, AttributeValue> row : pfamsTable) {
      PFamDomain pfam = new PFamDomain((String) row.get("accession").getValue());
      pfam.setSymbol((String) row.get("symbol").getValue());
      pfam.setDescription((String) row.get("description").getValue());
      pfam.setCount(Integer.valueOf(row.get("occurrences").getValue().toString()));
      pfam.setIndex(Integer.valueOf(row.get("domain_index").getValue().toString()));
      group.addPFamDomain(pfam);
      pfams.add(pfam);
    }

    // generate random color for the domains
    Collections.sort(pfams);
    RenderingHelper.assignSpectrumColors(pfams);

    // load protein pfam information to each gene
    TableValue proteinPFamsTable = groupRecord.getTableValue(PROTEIN_PFAMS_TABLE);
    for (Map<String, AttributeValue> row : proteinPFamsTable) {
      String sourceId = (String) row.get("full_id").getValue();
      String accession = (String) row.get("accession").getValue();
      if (accession != null) {
        int[] location = new int[3];
        location[0] = Integer.valueOf(row.get("start_min").getValue().toString());
        location[1] = Integer.valueOf(row.get("end_max").getValue().toString());
        location[2] = Integer.valueOf(row.get("length").getValue().toString());
        Gene gene = group.getGene(sourceId);
        gene.addPFamDomain(accession, location);
      }
    }
  }

  private void processEcNumbers(Group group, Map<String, Integer> ecNumberCodes) {
    // determine the index of each ecNumber
    List<EcNumber> ecNumbers = new ArrayList<>();
    for (String code : ecNumberCodes.keySet()) {
      EcNumber ecNumber = new EcNumber(code);
      ecNumber.setCount(ecNumberCodes.get(code));
      group.addEcNumbers(ecNumber);
      ecNumbers.add(ecNumber);
    }

    Collections.sort(ecNumbers);
    for (int i = 0; i < ecNumbers.size(); i++) {
      ecNumbers.get(i).setIndex(i);
    }

    // assign spectrum colors to the ec numbers
    RenderingHelper.assignSpectrumColors(ecNumbers);
  }
}
