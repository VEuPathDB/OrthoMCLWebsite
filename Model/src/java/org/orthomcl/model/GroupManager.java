package org.orthomcl.model;

import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

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
  private static final String PFAMS_TABLE = "ProteinPFams";
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

    // TODO - process ec numbers to form tree
    processEcNumbers(group, ecNumbers);

    return group;
  }

  public Map<String, PFamDomain> getPFamDomains(User user, String groupName) throws WdkModelException,
      WdkUserException {
    // load pfam domian information
    Map<String, PFamDomain> pfams = new LinkedHashMap<>();
    RecordInstance groupRecord = getGroupRecord(user, groupName);
    TableValue pfamsTable = groupRecord.getTableValue(PFAMS_TABLE);
    for (Map<String, AttributeValue> row : pfamsTable) {
      PFamDomain pfam = new PFamDomain((String) row.get("accession").getValue());
      pfam.setSymbol((String) row.get("symbol").getValue());
      pfam.setDescription((String) row.get("description").getValue());
      pfam.setCount(Integer.valueOf(row.get("occurrences").getValue().toString()));
      pfam.setIndex(Integer.valueOf(row.get("domain_index").getValue().toString()));
    }

    // generate random color for the domains
    RenderingHelper.assignColors(pfams.values());

    return pfams;
  }

  public Map<String, Set<String>> getProteinPFamDomains(User user, String groupName)
      throws WdkModelException, WdkUserException {
    // load protein pfam information
    Map<String, Set<String>> proteinPfams = new HashMap<String, Set<String>>();
    RecordInstance groupRecord = getGroupRecord(user, groupName);
    TableValue proteinPFamsTable = groupRecord.getTableValue(PROTEIN_PFAMS_TABLE);
    for (Map<String, AttributeValue> row : proteinPFamsTable) {
      String sourceId = (String) row.get("full_id").getValue();
      String accession = (String) row.get("accession").getValue();
      Set<String> pfams = proteinPfams.get(sourceId);
      if (pfams == null) {
        pfams = new HashSet<>();
        proteinPfams.put(sourceId, pfams);
      }
      pfams.add(accession);
    }
    return proteinPfams;
  }

  private void processEcNumbers(Group group, Map<String, Integer> ecNumberCodes) {
    String[] codes = ecNumberCodes.keySet().toArray(new String[0]);
    Arrays.sort(codes);

    // determine the index of each ecNumber
    for (int i = 0; i < codes.length; i++) {
      EcNumber ecNumber = new EcNumber(codes[i]);
      ecNumber.setIndex(i);
      ecNumber.setCount(ecNumberCodes.get(ecNumber));
      group.addEcNumbers(ecNumber);
    }

    // determine the color of each ecNumber; current it's a flat list, and color is scaled from 360 degree to
    // 256 * 6 space.
    for (String code : codes) {
      EcNumber ecNumber = group.getEcNumber(code);
      int color = Math.round(ecNumber.getIndex() * 256 * 6F / codes.length);
      int range = color / 256;
      int subRange = color % 256;
      String colorCode;
      if (range == 0 || range == 6) { // on blue, increasing green
        colorCode = "#00" + RenderingHelper.toHex(subRange) + "FF";
      }
      else if (range == 1) { // on green, decreasing blue
        colorCode = "#00FF" + RenderingHelper.toHex(256 - subRange);
      }
      else if (range == 2) { // on green, increasing red
        colorCode = "#" + RenderingHelper.toHex(subRange) + "FF00";
      }
      else if (range == 3) { // on red, decreasing green
        colorCode = "#FF" + RenderingHelper.toHex(256 - subRange) + "00";
      }
      else if (range == 4) { // on red, increasing blue
        colorCode = "#FF00" + RenderingHelper.toHex(subRange);
      }
      else { // on blue, decreasing red
        colorCode = "#" + RenderingHelper.toHex(256 - subRange) + "00FF";
      }
      ecNumber.setColor(colorCode);
    }
  }
}
