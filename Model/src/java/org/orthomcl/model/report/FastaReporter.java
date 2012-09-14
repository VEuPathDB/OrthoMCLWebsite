/**
 * 
 */
package org.orthomcl.model.report;

import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Map;

import org.apache.log4j.Logger;
import org.gusdb.wdk.model.AnswerValue;
import org.gusdb.wdk.model.RecordInstance;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.report.Reporter;
import org.json.JSONException;

/**
 * @author xingao
 * 
 */
public class FastaReporter extends Reporter {

  private static Logger logger = Logger.getLogger(FastaReporter.class);

  public static final String FIELD_HAS_ORGANISM = "hasOrganism";
  public static final String FIELD_HAS_DESCRIPTION = "hasDescription";

  private static final String ATTR_FULL_ID = "full_id";
  private static final String ATTR_ORGANISM = "taxon_name";
  private static final String ATTR_DESCRIPTION = "product";
  private static final String ATTR_SEQUENCE = "sequence";

  private static final int FASTA_LINE_LENGTH = 60;

  private boolean hasOrganism;
  private boolean hasDescription;

  public FastaReporter(AnswerValue answerValue, int startIndex, int endIndex) {
    super(answerValue, startIndex, endIndex);
  }

  /*
     * 
     */
  @Override
  public void configure(Map<String, String> config) {
    super.configure(config);

    // get basic configurations
    String strOrganism = config.get(FIELD_HAS_ORGANISM);
    hasOrganism = (strOrganism != null && (strOrganism.equals("yes") || strOrganism.equals("true")));

    String strDescription = config.get(FIELD_HAS_DESCRIPTION);
    hasDescription = (strDescription != null && (strDescription.equals("yes") || strDescription.equals("true")));
  }

  public String getConfigInfo() {
    return "You can choose to include organism or descriptions into the defline of FASTA file";
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.gusdb.wdk.model.report.Reporter#getHttpContentType()
   */
  @Override
  public String getHttpContentType() {
      return "text/plain";
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.gusdb.wdk.model.report.Reporter#getDownloadFileName()
   */
  @Override
  public String getDownloadFileName() {
    if (format.equalsIgnoreCase("text")) {
      logger.info("Internal format: " + format);
      String name = getQuestion().getName();
      return name + ".fasta";
    } else { // use the default content type defined in the parent class
      return super.getDownloadFileName();
    }
  }

  /*
   * (non-Javadoc)
   * 
   * @see
   * org.gusdb.wdk.model.report.IReporter#format(org.gusdb.wdk.model.Answer)
   */
  @Override
  protected void write(OutputStream out) throws WdkModelException,
      NoSuchAlgorithmException, SQLException, JSONException, WdkUserException {
    PrintWriter writer = new PrintWriter(new OutputStreamWriter(out));

    // get page based answers with a maximum size (defined in
    // PageAnswerIterator)
    for (AnswerValue answerValue : this) {
      for (RecordInstance record : answerValue.getRecordInstances()) {
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
  }

  private String format(String sequence) {
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

  @Override
  protected void complete() {
    // do nothing
  }

  @Override
  protected void initialize() throws SQLException {
    // do nothing
  }
}
