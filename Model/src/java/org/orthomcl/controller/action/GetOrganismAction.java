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
import org.gusdb.wdk.controller.action.ActionUtility;
import org.gusdb.wdk.model.WdkModel;
import org.orthomcl.data.GroupLoader;

/**
 * Hello world!
 * 
 */
public class GetOrganismAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // get connection
        WdkModel wdkModel = ActionUtility.getWdkModel(servlet).getModel();
        DataSource dataSource = wdkModel.getQueryPlatform().getDataSource();
        Connection connection = dataSource.getConnection();

        GroupLoader loader = new GroupLoader(connection);
        byte[] data = loader.getOrganismsData();

        OutputStream output = response.getOutputStream();
        output.write(data);
        output.flush();
        output.close();

        return null;
    }
}
