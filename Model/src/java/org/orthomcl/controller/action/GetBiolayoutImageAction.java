package org.orthomcl.controller.action;

import java.io.InputStream;
import java.io.OutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.gusdb.wdk.controller.actionutil.ActionUtility;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.dbms.SqlUtils;
import org.gusdb.wdk.model.jspwrap.WdkModelBean;

public class GetBiolayoutImageAction extends Action {

    private static final String PARAM_GROUP_NAME = "group";

    private static final Logger logger = Logger.getLogger(GetBiolayoutImageAction.class);

    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        WdkModelBean wdkModelBean = ActionUtility.getWdkModel(servlet);

        // get the input group name
        String groupName = request.getParameter(PARAM_GROUP_NAME);
        if (groupName == null || groupName.length() == 0)
            throw new WdkUserException("group parameter is required");

        // set the responce content type
        response.reset();
        response.setContentType("image/jpg");
        
        // read image from database
        String sql = "SELECT biolayout_image FROM apidb.OrthologGroup "
                + " WHERE name = ? AND biolayout_image IS NOT NULL";
        WdkModel wdkModel = wdkModelBean.getModel();
        DataSource dataSource = wdkModel.getQueryPlatform().getDataSource();
        PreparedStatement statement = null;
        try {
            statement = SqlUtils.getPreparedStatement(dataSource, sql);
            statement.setString(1, groupName);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                // find image, write it to the output
                InputStream input = resultSet.getBinaryStream("biolayout_image");
                OutputStream output = response.getOutputStream();
                int b;
                while ((b = input.read()) >= 0) {
                    output.write(b);
                }
                input.close();
                output.flush();
                output.close();
            }
        }
        catch (Exception ex) {
            logger.error(ex);
            ex.printStackTrace();
            throw ex;
        }
        finally {
            SqlUtils.closeStatement(statement);
        }
        return null;
    }

}
