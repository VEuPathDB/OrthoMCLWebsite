package org.orthomcl.model.layout;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.sql.DataSource;

import org.gusdb.fgputil.db.SqlUtils;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.answer.AnswerValue;
import org.orthomcl.data.layout.GraphicsException;
import org.orthomcl.data.layout.SpringLayout;
import org.orthomcl.model.Gene;
import org.orthomcl.model.GenePair;
import org.orthomcl.model.GeneSet;
import org.orthomcl.model.Taxon;

public class GeneSetLayoutGenerator {
  
  private static final int DEFAULT_SIZE = LayoutManager.DEFAULT_SIZE;
  
  private final Random random = new Random();

  public Layout generateLayout(AnswerValue answer) throws WdkModelException, WdkUserException {
    GeneSet geneSet = new GeneSet(answer.getQuestion().getDisplayName());
    Layout layout = new Layout(geneSet, DEFAULT_SIZE);
    Map<String, Node> nodes = loadNodes(layout, answer);
    loadEdges(layout, answer, nodes);
    loadEdgeTypes(layout, answer);
    computeLocations(layout);
    return layout;
  }
  
  private Map<String, Node> loadNodes(Layout layout, AnswerValue answer) throws WdkModelException, WdkUserException {
    Map<String, Node> nodes = new HashMap<>();
    int index = 0;

    // create a dummy taxon
    Taxon taxon = new Taxon(0);
    taxon.setAbbrev("dummy");

    String idSql = answer.getIdSql();
    String sql = "SELECT full_id FROM (" + idSql + ")";
    WdkModel wdkModel = answer.getQuestion().getWdkModel();
    DataSource dataSource = wdkModel.getAppDb().getDataSource();
    ResultSet resultSet = null;
    try {
      resultSet = SqlUtils.executeQuery(dataSource, sql, answer.getQuestion().getFullName() + "__ortho-gene-ids",
          1000);
      while (resultSet.next()) {
        String fullId = resultSet.getString("full_id");
        Gene gene = new Gene(fullId);
        gene.setTaxon(taxon);
        Node node = new Node(gene);
        node.setIndex(index);

        // assign random location to the node; the actual locations will be computed later
        double x = random.nextInt(DEFAULT_SIZE);
        double y = random.nextInt(DEFAULT_SIZE);
        node.setLocation(x, y);
        layout.addNode(node);
        nodes.put(fullId, node);

        index++;
      }
    }
    catch (SQLException ex) {
      throw new WdkModelException(ex);
    }
    finally {
      SqlUtils.closeResultSetAndStatement(resultSet);
    }
    return nodes;
  }

  private void loadEdges(Layout layout, AnswerValue answer, Map<String, Node> nodes) throws WdkModelException,
      WdkUserException {
    // contruct an SQL to get blast scores
    String idSql = answer.getIdSql();
    String sql = "WITH sequences AS (SELECT * FROM (" + idSql + ")) " +
        " SELECT query_id, subject_id, evalue_mant, evalue_exp FROM apidb.SimilarSequences " +
        " WHERE query_id IN (SELECT full_id FROM sequences) " +
        "  AND subject_id IN (SELECT full_id FROM sequences) ";
    WdkModel wdkModel = answer.getQuestion().getWdkModel();
    DataSource dataSource = wdkModel.getAppDb().getDataSource();
    ResultSet resultSet = null;
    try {
      resultSet = SqlUtils.executeQuery(dataSource, sql, answer.getQuestion().getFullName() + "__ortho-blast-scores",
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

  private void loadEdgeTypes(Layout layout, AnswerValue answer) throws WdkModelException, WdkUserException {
    loadEdgeTypes(layout, EdgeType.Ortholog, answer, "Ortholog");
    loadEdgeTypes(layout, EdgeType.Coortholog, answer, "Coortholog");
    loadEdgeTypes(layout, EdgeType.Inparalog, answer, "Inparalog");
  }

  private void loadEdgeTypes(Layout layout, EdgeType type, AnswerValue answer, String tableName)
      throws WdkModelException, WdkUserException {
    WdkModel wdkModel = answer.getQuestion().getWdkModel();
    String idSql = answer.getIdSql();
    String sql = "WITH sequences AS (SELECT * FROM (" + idSql + ")) " +
        " SELECT sequence_id_a AS query_id, sequence_id_b AS subject_id FROM apidb." + tableName +
        " WHERE sequence_id_a IN (SELECT full_id FROM sequences) " +
        "   AND sequence_id_b IN (SELECT full_id FROM sequences)";
    DataSource dataSource = wdkModel.getAppDb().getDataSource();
    ResultSet resultSet = null;
    try {
      resultSet = SqlUtils.executeQuery(dataSource, sql, answer.getQuestion().getFullName()+ "__orthomcl-get-" +
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
