package org.orthomcl.controller.action;

import java.sql.Connection;
import java.util.Map;

import javax.sql.DataSource;

import org.gusdb.wdk.controller.actionutil.ActionResult;
import org.gusdb.wdk.controller.actionutil.ParamDef;
import org.gusdb.wdk.controller.actionutil.ParamGroup;
import org.gusdb.wdk.controller.actionutil.ResponseType;
import org.gusdb.wdk.controller.actionutil.WdkAction;
import org.gusdb.wdk.model.dbms.SqlUtils;
import org.orthomcl.data.GroupLoader;

public class GetOrganismAction extends WdkAction {

    @Override protected boolean shouldValidateParams() { return false; }
    @Override protected Map<String, ParamDef> getParamDefs() { return null; }

    @Override
    protected ActionResult handleRequest(ParamGroup params) throws Exception {
      // get connection
      DataSource dataSource = getWdkModel().getModel().getQueryPlatform().getDataSource();
      Connection connection = null;
      
      try {
        connection = dataSource.getConnection();

        GroupLoader loader = new GroupLoader(connection);
        byte[] data = loader.getOrganismsData();
        return new ActionResult(ResponseType.binary_data)
            .setStream(getStreamFromBytes(data));
      }
      finally {
        SqlUtils.closeQuietly(connection);
      }
    }
}
