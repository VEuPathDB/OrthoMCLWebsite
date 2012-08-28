package org.orthomcl.controller.action;

import java.io.OutputStream;
import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.gusdb.wdk.controller.actionutil.ActionUtility;
import org.gusdb.wdk.model.WdkModel;
import org.orthomcl.data.GroupLoader;

/**
 * Hello world!
 * 
 */
public class GetGroupAction extends Action {

    private static final String PROP_GROUP = "group";

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String groupName = request.getParameter(PROP_GROUP);

        // get connection
        WdkModel wdkModel = ActionUtility.getWdkModel(servlet).getModel();
        DataSource dataSource = wdkModel.getQueryPlatform().getDataSource();
        Connection connection = dataSource.getConnection();

        try {
            GroupLoader loader = new GroupLoader(connection);
            byte[] data = loader.getGroupData(groupName);

            OutputStream output = response.getOutputStream();
            output.write(data);
            output.flush();
            output.close();
        } finally {
            connection.close();
        }

        return null;
    }
}
