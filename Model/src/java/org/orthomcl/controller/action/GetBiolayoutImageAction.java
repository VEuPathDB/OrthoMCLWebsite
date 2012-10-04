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
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.dbms.DatabaseResultStream;
import org.gusdb.wdk.model.dbms.SqlUtils;

public class GetBiolayoutImageAction extends WdkAction {
  
    @SuppressWarnings("unused")
    private static final Logger LOG = Logger.getLogger(GetBiolayoutImageAction.class.getName());

    private static final String PARAM_GROUP_NAME = "group";

    private static final String BIOLAYOUT_DEFAULT_FILENAME = "biolayout.jpg";
    
    private static final String IMAGE_FIELD_NAME = "biolayout_image";
    
    private static final String IMAGE_SQL =
        "SELECT " + IMAGE_FIELD_NAME + " FROM apidb.OrthologGroup " +
        "WHERE name = ? AND " + IMAGE_FIELD_NAME + " IS NOT NULL";

    @Override
    protected ResponseType getResponseType() {
      return ResponseType.jpeg;
    }

    @Override
    protected boolean shouldValidateParams() {
      return true;
    }

    @Override
    protected Map<String, ParamDef> getParamDefs() {
      return new ParamDefMapBuilder().addParam(PARAM_GROUP_NAME, new ParamDef(Required.REQUIRED)).toMap();
    }

    @Override
    protected ActionResult handleRequest(ParamGroup params) throws Exception {
      
      // read image from database
      DataSource dataSource = getWdkModel().getModel().getQueryPlatform().getDataSource();
      Connection conn = null;
      PreparedStatement statement = null;
      ResultSet resultSet = null;
      try {
          conn = dataSource.getConnection();
          statement = conn.prepareStatement(IMAGE_SQL);
          statement.setString(1, params.getValue(PARAM_GROUP_NAME));
          resultSet = statement.executeQuery();
          if (resultSet.next()) {
              // find image, add to response
              return new ActionResult().setFileName(BIOLAYOUT_DEFAULT_FILENAME)
                  .setStream(new DatabaseResultStream(resultSet, IMAGE_FIELD_NAME));
          }
          // otherwise throw exception; file should be found
          throw new WdkModelException("Biolayout image for param group " +
              params.getValue(PARAM_GROUP_NAME) + " NOT FOUND!");
      }
      catch (Exception e) {
        // only make sure to close open objects if exception is thrown;
        //   if code above was successful, objects will be closed by WdkAction
        SqlUtils.closeQuietly(resultSet, statement, conn);
        throw e;
      }
    }
}
