package org.orthomcl.controller.action;

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
import org.gusdb.wdk.controller.action.ActionUtility;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.dbms.SqlUtils;
import org.gusdb.wdk.model.jspwrap.WdkModelBean;

public class GetSvgContentAction extends Action {

    private static final String PARAM_GROUP_NAME = "group";
    private static final String FORWARD_DISPLAY = "display";
    private static final String ATTR_SVG_CONTENT = "svgContent";

    private static final Logger logger = Logger.getLogger(GetSvgContentAction.class);

    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        logger.debug("Entering GetSvgContentAction...");
        WdkModelBean wdkModelBean = ActionUtility.getWdkModel(servlet);

        // get the input group name
        String groupName = request.getParameter(PARAM_GROUP_NAME);
        if (groupName == null || groupName.length() == 0)
            throw new WdkUserException("group parameter is required");

        // set the responce content type
        response.reset();
        response.setContentType("image/svg+xml");

        // read svg_content from database
        String sql = "SELECT svg_content FROM apidb.OrthologGroup "
                + " WHERE name = ? ";
        WdkModel wdkModel = wdkModelBean.getModel();
        DataSource dataSource = wdkModel.getQueryPlatform().getDataSource();
        PreparedStatement statement = null;
        try {
            statement = SqlUtils.getPreparedStatement(dataSource, sql);
            statement.setString(1, groupName);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                String svgContent = resultSet.getString("svg_content");
                request.setAttribute(ATTR_SVG_CONTENT, svgContent);
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
        logger.debug("Leaving GetSvgContentAction...");
        return mapping.findForward(FORWARD_DISPLAY);
    }

}
