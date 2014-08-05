package org.orthomcl.model.layout;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.sql.DataSource;

import org.eupathdb.common.model.InstanceManager;
import org.gusdb.fgputil.db.SqlUtils;
import org.gusdb.wdk.model.Manageable;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.user.Step;
import org.orthomcl.data.layout.GraphicsException;
import org.orthomcl.data.layout.SpringLayout;
import org.orthomcl.model.Gene;
import org.orthomcl.model.GenePair;
import org.orthomcl.model.GeneSet;
import org.orthomcl.model.GeneSetManager;

public class GeneSetLayoutManager extends LayoutManager implements Manageable<GeneSetLayoutManager> {

  private static final int MAX_GENES = 200;
  
  private final Random random = new Random();
  
  @Override
  public GeneSetLayoutManager getInstance(String projectId, String gusHome) throws WdkModelException {
    GeneSetLayoutManager layoutManager = new GeneSetLayoutManager();
    layoutManager.projectId = projectId;
    return layoutManager;
  }

  public Layout getLayout(Step step) throws WdkModelException, WdkUserException {
    // only do layout for the step with genes of MAX_GENES or less
    if (step.getResultSize() > MAX_GENES)
      return null;

    // load gene set
    GeneSetManager geneSetManager = InstanceManager.getInstance(GeneSetManager.class, projectId);
    GeneSet geneSet = geneSetManager.getGeneSet(step);
    Layout layout = new Layout(geneSet, getSize());

    Map<String, Node> nodes = loadNodes(layout);
    loadEdges(layout, step, nodes);
    loadEdgeTypes(layout, step);
    computeLocations(layout);

    // do further processings.
    processLayout(layout);

    return layout;
  }

  private Map<String, Node> loadNodes(Layout layout) {
    Map<String, Node> nodes = new HashMap<>();
    int index = 0;
    for (Gene gene : layout.getGroup().getGenes()) {
      Node node = new Node(gene);
      node.setIndex(index);

      // assign random location to the node; the actual locations will be computed later
      double x = random.nextInt(getSize());
      double y = random.nextInt(getSize());
      node.setLocation(x, y);
      layout.addNode(node);
      nodes.put(gene.getSourceId(), node);

      index++;
    }
    return nodes;
  }

  private void loadEdges(Layout layout, Step step, Map<String, Node> nodes) throws WdkModelException,
      WdkUserException {
    // contruct an SQL to get blast scores
    String idSql = step.getAnswerValue(false).getIdSql();
    String sql = "WITH sequences AS (SELECT * FROM (" + idSql + ")) " +
        " SELECT query_id, subject_id, evalue_mant, evalue_exp FROM apidb.SimilarSequences " +
        " WHERE query_id IN (SELECT full_id FROM sequences) " +
        "  AND subject_id IN (SELECT full_id FROM sequences) ";
    WdkModel wdkModel = step.getQuestion().getWdkModel();
    DataSource dataSource = wdkModel.getAppDb().getDataSource();
    ResultSet resultSet = null;
    try {
      resultSet = SqlUtils.executeQuery(dataSource, sql, step.getQuestionName() + "__ortho-blast-scores",
          1000);
      while (resultSet.next()) {
        String queryId = resultSet.getString("query_id");
        String subjectId = resultSet.getString("subject_id");
        float evalueMant = resultSet.getFloat("evalue_mant");
        if (evalueMant < 0.1) evalueMant = 1;
        int evalueExp = resultSet.getInt("evalue_exp");
        String evalue = evalueMant + "E" + evalueExp;

        Edge edge = new Edge(queryId, subjectId);
        Edge oldEdge = layout.getEdge(edge);
        if (oldEdge != null) { // old edge exists, combine the value
          if (!evalue.equals(oldEdge.getEvalueA())) {
            oldEdge.setEvalueB(evalue);
            double scoreB = Math.log10(Double.valueOf(evalue));
            oldEdge.setScore((oldEdge.getScore() + scoreB) / 2);
          }
        }
        else { // old edge doesn't exist
          edge.setEvalueA(evalue);
          edge.setScore(Math.log10(Double.valueOf(evalue)));
          edge.setNodeA(nodes.get(queryId));
          edge.setNodeB(nodes.get(subjectId));
          // set the edge as default normal type, will be updated later
          edge.setType(EdgeType.Normal);
          layout.addEdge(edge);
        }
      }
    }
    catch (SQLException ex) {
      throw new WdkModelException(ex);
    }
    finally {
      SqlUtils.closeResultSetAndStatement(resultSet);
    }
  }

  private void loadEdgeTypes(Layout layout, Step step) throws WdkModelException, WdkUserException {
    loadEdgeTypes(layout, EdgeType.Ortholog, step, "Ortholog");
    loadEdgeTypes(layout, EdgeType.Coortholog, step, "Coortholog");
    loadEdgeTypes(layout, EdgeType.Inparalog, step, "Inparalog");
  }

  private void loadEdgeTypes(Layout layout, EdgeType type, Step step, String tableName)
      throws WdkModelException, WdkUserException {
    WdkModel wdkModel = step.getQuestion().getWdkModel();
    String idSql = step.getAnswerValue().getIdSql();
    String sql = "WITH sequences AS (SELECT * FROM (" + idSql + ")) " +
        " SELECT sequence_id_a AS query_id, sequence_id_b AS subject_id FROM apidb." + tableName +
        " WHERE sequence_id_a IN (SELECT full_id FROM sequences) " +
        "   AND sequence_id_b IN (SELECT full_id FROM sequences)";
    DataSource dataSource = wdkModel.getAppDb().getDataSource();
    ResultSet resultSet = null;
    try {
      resultSet = SqlUtils.executeQuery(dataSource, sql, step.getQuestionName() + "__orthomcl-get-" +
          tableName, 1000);
      while (resultSet.next()) {
        String queryId = resultSet.getString("query_id");
        String subjectId = resultSet.getString("subject_id");
        Edge edge = layout.getEdge(new GenePair(queryId, subjectId));
        edge.setType(type);
      }
    }
    catch (SQLException ex) {
      throw new WdkModelException(ex);
    }
    finally {
      SqlUtils.closeResultSetAndStatement(resultSet);
    }
  }

  private void computeLocations(Layout layout) throws WdkModelException {
    try {
      SpringLayout springLayout = new SpringLayout(layout);
      springLayout.process(null);
    }
    catch (GraphicsException ex) {
      throw new WdkModelException(ex);
    }
  }
}
