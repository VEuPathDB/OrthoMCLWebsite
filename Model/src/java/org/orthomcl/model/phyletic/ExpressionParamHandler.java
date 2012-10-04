package org.orthomcl.model.phyletic;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.dbms.SqlUtils;
import org.gusdb.wdk.model.query.param.Param;
import org.gusdb.wdk.model.query.param.ParamHandler;
import org.gusdb.wdk.model.user.User;

public class ExpressionParamHandler implements ParamHandler {

    private static final String TAXON_SQL = "SELECT three_letter_abbrev "
            + " FROM apidb.orthomcltaxon ORDER BY three_letter_abbrev";
    private static final String GROUP_SQL = "SELECT ortholog_group_id "
            + " FROM apidb.GroupTaxonMatrix";

    private static final String COLUMN_PREFIX = "column";

    private static final Logger logger = Logger.getLogger(ExpressionParamHandler.class);

    private final ExpressionParser parser;
    private Map<String, Integer> terms;
    private WdkModel wdkModel;

    // private Param param;

    public ExpressionParamHandler() {
        this.parser = new ExpressionParser();
    }

    public void setParam(Param param) {
        // this.param = param;
    }

    public void setWdkModel(WdkModel wdkModel) throws WdkUserException,
            WdkModelException {
        this.wdkModel = wdkModel;
        this.terms = getTerms();
    }

    public String transform(User user, String internalValue)
            throws WdkModelException {
        logger.debug("transforming phyletic param: " + internalValue);

        // remove the enclosing quotes
        if (internalValue.startsWith("'") && internalValue.endsWith("'"))
            internalValue =
                    internalValue.substring(1, internalValue.length() - 1);

        // parse the expression and get the tree structure
        ExpressionNode root = parser.parse(internalValue);

        StringBuilder sql = new StringBuilder(GROUP_SQL);
        sql.append(" WHERE " + composeSql(root));

        return sql.toString();
    }

    private Map<String, Integer> getTerms() throws WdkUserException,
            WdkModelException {
        Map<String, Integer> terms = new LinkedHashMap<String, Integer>();
        DataSource dataSource = wdkModel.getQueryPlatform().getDataSource();
        ResultSet resultSet = null;
        try {
            resultSet =
                    SqlUtils.executeQuery(wdkModel, dataSource, TAXON_SQL,
                            "ortho-exp-param-handler-taxon", 1000);
            int order = 0;
            while (resultSet.next()) {
                String term = resultSet.getString(1);
                terms.put(term.toLowerCase(), order++);
            }
        }
        catch (SQLException ex) {
            throw new WdkModelException(ex);
        }
        finally {
            SqlUtils.closeResultSet(resultSet);
        }
        return terms;
    }

    private String composeSql(ExpressionNode node) throws WdkModelException {
        StringBuilder sql = new StringBuilder("(");
        if (node instanceof BooleanNode) {
            BooleanNode booleanNode = (BooleanNode) node;
            sql.append(composeSql(booleanNode.getLeft()));
            sql.append(" " + booleanNode.getOperator() + " ");
            sql.append(composeSql(booleanNode.getRight()));
        } else {
            LeafNode leaf = (LeafNode) node;
            List<String> terms = leaf.getTerms();
            if (terms.size() > 0) sql.append("(");
            StringBuilder sqlTerms = new StringBuilder();
            for (String term : terms) {
                if (sqlTerms.length() > 1) sqlTerms.append(" + ");
                String column = getColumn(term, leaf.isOnSpecies());
                sqlTerms.append(column);
            }
            sql.append(sqlTerms);
            if (terms.size() > 0) sql.append(")");
            sql.append(" " + leaf.getCondition() + leaf.getCount());
        }
        sql.append(")");
        return sql.toString();
    }

    private String getColumn(String term, boolean onSpecies)
            throws WdkModelException {
        if (!terms.containsKey(term))
            throw new WdkModelException("Invalid expression. Unknown term: "
                    + term);
        int columnIndex = terms.get(term) * 2 + 1;
        if (onSpecies) columnIndex++;
        return COLUMN_PREFIX + columnIndex;
    }
}
