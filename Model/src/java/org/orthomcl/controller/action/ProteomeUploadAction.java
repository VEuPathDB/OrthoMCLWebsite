/**
 * 
 */
package org.orthomcl.controller.action;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author xingao
 * 
 */
public class ProteomeUploadAction extends Action {

    private static final String FORWARD_UPLOAD_FORM = "upload-form";

    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        return mapping.findForward(FORWARD_UPLOAD_FORM);
    }
}
