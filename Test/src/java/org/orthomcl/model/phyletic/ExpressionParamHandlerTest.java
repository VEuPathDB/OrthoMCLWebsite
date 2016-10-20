package org.orthomcl.model.phyletic;

import java.util.HashMap;

import org.gusdb.wdk.model.Utilities;
import org.gusdb.wdk.model.WdkModel;
import org.gusdb.wdk.model.WdkModelException;
import org.gusdb.wdk.model.user.User;
import org.junit.Test;

public class ExpressionParamHandlerTest {

  private static class ExpressionTester {

    private final User user;
    private final ExpressionParamHandler handler;

    public ExpressionTester(WdkModel wdkModel) throws WdkModelException {
      user = wdkModel.getSystemUser();
      handler = new ExpressionParamHandler();
      handler.setWdkModel(wdkModel);
    }

    public void test(String exp) throws WdkModelException {
      System.out.println("Expression: " + exp);
      String sql = handler.toInternalValue(user, exp, new HashMap<String,String>());
      System.out.println("SQL: " + sql);
    }
  }

  @Test
  public void testTransform() throws WdkModelException {
    String projectId = System.getProperty(Utilities.ARGUMENT_PROJECT_ID);
    String gusHome = System.getProperty(Utilities.SYSTEM_PROPERTY_GUS_HOME);
    try (WdkModel wdkModel = WdkModel.construct(projectId, gusHome)) {
      ExpressionTester tester = new ExpressionTester(wdkModel);
      tester.test("pviv = 2");
      tester.test("pfal >3T");
      tester.test("pber<= 5");
      tester.test("pyoe+pkno>=4T");
      tester.test("(pcha+PIRO)= 6");
      tester.test("(BASI+ tann+bbov <7T)");
      tester.test("COCC = 2 AND cmur>3T");
      tester.test("tgon<= 2T or ncan= 4");
      tester.test("cpar = 2 AND chom+ FUNG +ASCO>3T OR aory =4T");
      tester.test("(ylip +spom = 2 and psti>3T) OR ncra =4T");
      tester.test("((egos = 2 AND (cimm + cpos)>3T) Or (calb =4T And mgri>=5))");
    }
  }
}
