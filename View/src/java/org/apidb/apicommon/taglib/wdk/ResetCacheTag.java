package org.apidb.apicommon.taglib.wdk;


import javax.servlet.jsp.JspException;
import javax.servlet.ServletContext;
import org.apidb.apicommon.taglib.wdk.WdkTagBase;
import org.gusdb.wdk.model.dbms.CacheFactory;
import org.gusdb.wdk.model.Utilities;
import org.gusdb.wdk.model.WdkModel;

public class ResetCacheTag extends WdkTagBase {

    public void doTag() throws JspException {
        super.doTag();

        ServletContext context = getContext();
        String projectId = context.getInitParameter(Utilities.ARGUMENT_PROJECT_ID);
        String gusHome = context.getRealPath(
            context.getInitParameter(Utilities.SYSTEM_PROPERTY_GUS_HOME));;

        try {
            WdkModel wdkModel = WdkModel.construct(projectId, gusHome);
            CacheFactory factory = wdkModel.getResultFactory().getCacheFactory();
            
            factory.resetCache(true, true);
            
        } catch (Exception e) {
            throw new JspException(e);
        }
        
    }

}