package org.orthomcl.controller.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamDef;
import org.gusdb.wdk.controller.actionutil.ParamDef.Required;
import org.gusdb.wdk.controller.actionutil.ParamDefMapBuilder;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.gusdb.wdk.controller.actionutil.ResponseType;
import org.gusdb.wdk.controller.actionutil.WdkAction;
import org.gusdb.wdk.model.dbms.SqlUtils;

public class GetSvgContentAction extends WdkAction {

    private static final Logger logger = Logger.getLogger(GetSvgContentAction.class.getName());
  
    private static final String PARAM_GROUP_NAME = "group";
    
    private static final String ATTR_SVG_CONTENT = "svgContent";

    private static final String IMAGE_FIELD_NAME = "svg_content";
    private static final String IMAGE_QUERY_SQL =
        "SELECT " + IMAGE_FIELD_NAME + " FROM apidb.OrthologGroup WHERE name = ?";

    @Override
    protected ResponseType getResponseType() {
      return ResponseType.svg;
    }

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
              return new ActionResult()
                  .setRequestAttribute(ATTR_SVG_CONTENT, svgContent)
                  .setViewName(SUCCESS);
          }
          return ActionResult.EMPTY_RESULT;
      }
      finally {
          SqlUtils.closeQuietly(resultSet, statement, conn);
      }
    }
}
