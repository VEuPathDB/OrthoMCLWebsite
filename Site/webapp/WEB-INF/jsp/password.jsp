<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>
  <imp:pageFrame bufferContent="false" title="${wdkModel.displayName} :: Change Password" refer="password">
    <div class="user-form-frame">
		  <!-- show error messages, if any -->
      <imp:errors/>
			
		  <!-- display the success information, if the user registered successfully -->
		  <c:choose>
		    <c:when test="${requestScope.changePasswordSucceed ne null}">
				  <p><font color="blue">You have changed your password successfully.</font></p>
				</c:when>
		
		    <c:otherwise>
			    <!-- continue change password form -->
			    <form name="passwordForm" method="post" action="processPassword.do">
					  <table width="400" class="user-form-table">
					    <tr>
					      <th colspan="2"> Change Your Password </th>
					    </tr>
							<c:choose>
							  <c:when test="${wdkUser.guest eq true}">
							    <tr>
							      <td colspan="2"> 
							        You cannot change password as a guest.<br/>
							        Please login first before you change your password. 
							        If you lost your password, please <a href="${pageContext.request.contextPath}/resetpwd.do">click here</a>.
							      </td>
							    </tr>
							  </c:when>
							  <c:otherwise>
                  <!-- check if there's an error message to display -->
                  <c:if test="${not empty changePasswordError}">
                    <tr><td colspan="2"><font color="red">${changePasswordError}</font></td></tr>
                  </c:if>
                  <c:if test="${validator.errorsPresent}}">
                    <c:forEach var="error" items="${validator.errorList}">
                      <tr>
                        <td colspan="2">
                          <font color="red">${error}</font>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:if>
							    <tr>
							      <td align="right" width="200" nowrap="nowrap">&#160;<br/>Current User: </td>
							      <td align="left">&#160;<br/>${wdkUser.firstName} ${wdkUser.lastName}</td>
							    </tr>
							    <tr>
							      <td align="right" width="200" nowrap="nowrap">Email: </td>
							      <td align="left">${wdkUser.email}</td>
							    </tr>
							    <tr>
							      <td align="right" width="200" nowrap="nowrap">Current Password: </td>
							      <td align="left"><input type="password" name="oldPassword"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="200" nowrap="nowrap">New Password: </td>
							      <td align="left"><input type="password" name="newPassword"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="200" nowrap="nowrap">Retype Password: </td>
							      <td align="left"><input type="password" name="confirmPassword"/></td>
							    </tr>
							    <tr>
							      <td colspan="2" align="center">
							        <input type="submit" value="Change" onclick="return User.validatePasswordFields();"/>
							      </td>
							    </tr>
							    <tr>
							      <td colspan="2">
							        <div class="small">
							          <font color="red">
							            The password you use here may be intercepted by others during transmission. 
							            Choose a different password from any you use for sensitive accounts such as online banking or your university account. 
							          </font>
							        </div>
							      </td>
							    </tr>
							  </c:otherwise>
							</c:choose>
			      </table>
			    </form>
		    </c:otherwise>
		  </c:choose>
		</div>
  </imp:pageFrame>
</jsp:root>
