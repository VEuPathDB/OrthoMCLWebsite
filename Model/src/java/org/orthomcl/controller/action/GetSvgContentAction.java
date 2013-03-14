package org.orthomcl.controller.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.gusdb.fgputil.db.SqlUtil;
import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamDef;
import org.gusdb.wdk.controller.actionutil.ParamDef.Required;
import org.gusdb.wdk.controller.actionutil.ParamDefMapBuilder;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.gusdb.wdk.controller.actionutil.ResponseType;
import org.gusdb.wdk.controller.actionutil.WdkAction;

public class GetSvgContentAction extends WdkAction {

  private static final Logger logger = Logger.getLogger(GetSvgContentAction.class.getName());

  private static final String PARAM_GROUP_NAME = "group";

  private static final String ATTR_SVG_CONTENT = "svgContent";

  private static final String IMAGE_FIELD_NAME = "svg_content";
  private static final String IMAGE_QUERY_SQL = "SELECT " + IMAGE_FIELD_NAME
      + " FROM apidb.OrthologGroup WHERE name = ?";

  private static final Pattern DESC_PATTERN = Pattern.compile(
      "description=\"([^\"]+)\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);

  @Override
  protected boolean shouldValidateParams() {
    return true;
  }

  @Override
  protected Map<String, ParamDef> getParamDefs() {
    return new ParamDefMapBuilder().addParam(PARAM_GROUP_NAME,
        new ParamDef(Required.REQUIRED)).toMap();
  }

  @Override
  protected ActionResult handleRequest(ParamGroup params) throws Exception {
    logger.debug("Entering GetSvgContentAction...");

    // get the input group name
    String groupName = params.getValue(PARAM_GROUP_NAME);

    // read svg_content from database
    DataSource dataSource = getWdkModel().getModel().getQueryPlatform().getDataSource();
    Connection conn = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    try {
      conn = dataSource.getConnection();
      statement = conn.prepareStatement(IMAGE_QUERY_SQL);
      statement.setString(1, groupName);
      resultSet = statement.executeQuery();
      if (resultSet.next()) {
        String svgContent = resultSet.getString("svg_content");
        svgContent = processContent(svgContent);
        return new ActionResult(ResponseType.svg).setRequestAttribute(
            ATTR_SVG_CONTENT, svgContent).setViewName(SUCCESS);
      }
      return ActionResult.EMPTY_RESULT;
    } finally {
      SqlUtil.closeQuietly(resultSet, statement, conn);
    }
  }

  private String processContent(String content) {
    Matcher matcher = DESC_PATTERN.matcher(content);  
    StringBuilder buffer = new StringBuilder();
      int prev = 0;
      
      while (matcher.find()) {
        buffer.append(content.substring(prev, matcher.start()));
        buffer.append("description=\"");
        
        String description = matcher.group(1);
        description = description.replace("<", "&lt;").replace(">", "&gt;").replaceAll("\\s", " ");
        buffer.append(description);
        
        buffer.append("\"");
        
        prev = matcher.end();
      }
      
      buffer.append(content.substring(prev));
      return buffer.toString();
    }
}
