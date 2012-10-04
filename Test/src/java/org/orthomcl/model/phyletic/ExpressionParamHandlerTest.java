package org.orthomcl.model.phyletic;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactoryConfigurationError;

import org.gusdb.wdk.model.Utilities;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.WdkUserException;
import org.gusdb.wdk.model.user.User;
import org.json.JSONException;
import org.junit.Test;
import org.xml.sax.SAXException;

public class ExpressionParamHandlerTest {

    private final User user;
    private final ExpressionParamHandler handler;

    public ExpressionParamHandlerTest() throws WdkModelException,
            NoSuchAlgorithmException, WdkModelException, InstantiationException,
            IllegalAccessException, ClassNotFoundException,
            ParserConfigurationException, TransformerFactoryConfigurationError,
            TransformerException, IOException, SAXException, SQLException,
            JSONException, WdkUserException {
        String projectId = System.getProperty(Utilities.ARGUMENT_PROJECT_ID);
        String gusHome = System.getProperty(Utilities.SYSTEM_PROPERTY_GUS_HOME);
        WdkModel wdkModel = WdkModel.construct(projectId, gusHome);
        user = wdkModel.getSystemUser();
        handler = new ExpressionParamHandler();
        handler.setWdkModel(wdkModel);
    }

    @Test
    public void testTransform() throws WdkModelException {
        testExpression("pviv = 2");
        testExpression("pfal >3T");
        testExpression("pber<= 5");
        testExpression("pyoe+pkno>=4T");
        testExpression("(pcha+PIRO)= 6");
        testExpression("(BASI+ tann+bbov <7T)");
        testExpression("COCC = 2 AND cmur>3T");
        testExpression("tgon<= 2T or ncan= 4");
        testExpression("cpar = 2 AND chom+ FUNG +ASCO>3T OR aory =4T");
        testExpression("(ylip +spom = 2 and psti>3T) OR ncra =4T");
        testExpression("((egos = 2 AND (cimm + cpos)>3T) Or (calb =4T And mgri>=5))");

    }

    private void testExpression(String exp) throws WdkModelException {
        System.out.println("Expression: " + exp);
        String sql = handler.transform(user, exp);
        System.out.println("SQL: " + sql);
    }
}
