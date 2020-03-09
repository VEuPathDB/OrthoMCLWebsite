package org.orthomcl.model.phyletic;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.gusdb.fgputil.db.SqlUtils;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.query.param.Param;
import org.gusdb.wdk.model.query.param.ParamHandler;
import org.gusdb.wdk.model.query.param.StringParamHandler;
import org.gusdb.wdk.model.user.User;

public class ExpressionParamHandler extends StringParamHandler {

    private static final Logger LOG = Logger.getLogger(ExpressionParamHandler.class);

    private static final String GROUP_SQL = "SELECT ortholog_group_id FROM ( "
            + "SELECT ortholog_group_id, sum(number_of_taxa) as number_of_taxa, sum(number_of_proteins) as number_of_proteins "
	    + "FROM apidb.orthologgrouptaxon WHERE lower(three_letter_abbrev) IN (";

    private final ExpressionParser _parser = new ExpressionParser();
    private Map<String, Integer> _terms;

    public ExpressionParamHandler() { }

    public ExpressionParamHandler(ExpressionParamHandler handler, Param param) {
       super(handler, param);
    }

    @Override
    public ParamHandler clone(Param paramToClone) {
        return new ExpressionParamHandler(this, paramToClone);
    }

    @Override
    public String toInternalValue(User user, String stableValue, Map<String, String> contextValues)
            throws WdkModelException {
        LOG.debug("transforming phyletic param: " + stableValue);

         // parse the expression and get the tree structure
        ExpressionNode root = _parser.parse(stableValue);

        String sql = composeSql(GROUP_SQL,root);

	return sql;
    }


    private String composeSql(String coreSql, ExpressionNode node) throws WdkModelException {
        StringBuilder sql = new StringBuilder();
        if (node instanceof BooleanNode) {
            BooleanNode booleanNode = (BooleanNode) node;
            sql.append(composeSql(coreSql,booleanNode.getLeft()));
	    if (booleanNode.getOperator().equals("and")) { sql.append(" INTERSECT "); }
	    else if (booleanNode.getOperator().equals("or")) { sql.append(" UNION "); } 
            sql.append(composeSql(coreSql,booleanNode.getRight()));
        }
        else {
	    sql.append(coreSql);
            LeafNode leaf = (LeafNode) node;
            List<String> terms = leaf.getTerms();
            StringBuilder sqlTerms = new StringBuilder();
            for (String term : terms) {
		String species = "'" + term + "'";
                if (sqlTerms.length() > 1) sqlTerms.append(",");
                sqlTerms.append(species);
            }
            sql.append(sqlTerms + ")");
	    sql.append(" GROUP BY ortholog_group_id) WHERE "); 
	    if (leaf.isOnSpecies()) { sql.append("number_of_taxa"); }
	    else { sql.append("number_of_proteins"); }
	    sql.append(leaf.getCondition() + leaf.getCount());
        }
        return sql.toString();
    }

}
