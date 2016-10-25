package org.orthomcl.model.report;

import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.Map;

import org.apache.log4j.Logger;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.answer.AnswerValue;
import org.gusdb.wdk.model.answer.stream.RecordStream;
import org.gusdb.wdk.model.record.RecordInstance;
import org.gusdb.wdk.model.report.PagedAnswerReporter;
import org.json.JSONObject;

/**
 * @author xingao
 */
public class FastaReporter extends PagedAnswerReporter {

  private static Logger logger = Logger.getLogger(FastaReporter.class);

  public static final String FIELD_DOWNLOAD_TYPE = "downloadType";
  public static final String FIELD_HAS_ORGANISM = "hasOrganism";
  public static final String FIELD_HAS_DESCRIPTION = "hasDescription";

  private static final String ATTR_FULL_ID = "full_id";
  private static final String ATTR_ORGANISM = "taxon_name";
  private static final String ATTR_DESCRIPTION = "product";
  private static final String ATTR_SEQUENCE = "sequence";

  private static final int FASTA_LINE_LENGTH = 60;

  private boolean hasOrganism;
  private boolean hasDescription;
  private String downloadType;

  public FastaReporter(AnswerValue answerValue) {
    super(answerValue);
  }

  @Override
  public FastaReporter configure(Map<String, String> config) throws WdkUserException {

    // get basic configurations
    downloadType = config.get(FIELD_DOWNLOAD_TYPE);

    String strOrganism = config.get(FIELD_HAS_ORGANISM);
    hasOrganism = (strOrganism != null && (strOrganism.equals("yes") || strOrganism.equals("true")));

    String strDescription = config.get(FIELD_HAS_DESCRIPTION);
    hasDescription = (strDescription != null && (strDescription.equals("yes") || strDescription.equals("true")));

    return this;
  }

  @Override
  public FastaReporter configure(JSONObject config) throws WdkUserException {
    // FIXME: this reporter must be updated to comply with answer service
    return this;
  }

  @Override
  public String getDownloadFileName() {
    if (downloadType.equalsIgnoreCase("text")) {
      logger.info("Internal format: " + downloadType);
      String name = getQuestion().getName();
      return name + ".fasta";
    }
    else {
      // use the default content type defined in the parent class
      return super.getDownloadFileName();
    }
  }

  @Override
  public void write(OutputStream out) throws WdkModelException {
    try (RecordStream records = getRecords()) {
      PrintWriter writer = new PrintWriter(new OutputStreamWriter(out));
  
      for (RecordInstance record : records) {
        // output source id
        String fullId = record.getAttributeValue(ATTR_FULL_ID).getValue().toString().trim();
        writer.print(">" + fullId);

        // output organism if selected
        if (hasOrganism) {
          String organism = record.getAttributeValue(ATTR_ORGANISM).getValue().toString().trim();
          writer.print(" | organism=" + organism);
        }

        // output description if selected
        if (hasDescription) {
          Object value = record.getAttributeValue(ATTR_DESCRIPTION).getValue();
          String description = (value == null) ? "" : value.toString().trim();
          writer.print(" | " + description);
        }

        writer.println();

        // output sequence
        String sequence = record.getAttributeValue(ATTR_SEQUENCE).getValue().toString();
        sequence = format(sequence);
        writer.println(sequence);

        writer.println();
        writer.flush();
      }
    }
    catch (WdkUserException e) {
      throw new WdkModelException("Unable to produce FASTA report", e);
    }
  }

  private static String format(String sequence) {
    StringBuilder buffer = new StringBuilder();
    int pos = 0;
    while (pos < sequence.length()) {
      int end = Math.min(sequence.length(), pos + FASTA_LINE_LENGTH);
      buffer.append(sequence.subSequence(pos, end));
      if (end < sequence.length())
        buffer.append("\n");
      pos = end;
    }
    return buffer.toString();
  }
}
