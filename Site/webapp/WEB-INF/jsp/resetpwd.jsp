<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>
  <imp:pageFrame title="${wdkModel.displayName} :: Reset Password" refer="resetpwd">
    <div class="user-form-frame">
      <!-- display the success information, if the user registered successfully -->
			<c:choose>
			  <c:when test="${resetPasswordSucceed ne null}">
			    <font color="blue">
			      <p>An email has been sent to authorizing you to set your password.</p>
    			  <p>Please change your password as soon as you receive the email.</p>
			      <p>
			        <b>Note:</b>Some junk mail filters may mistake the mail for junk.
			        If you do not see the mail, check your junk mail folder.
			      </p>
  			  </font>
			  </c:when>
			  <c:otherwise>
			    <!-- continue reset password form -->
			    <form method="post" action="processResetPassword.do">
					  <table width="500" class="user-form-table">
					    <tr>
					      <th colspan="2">
					        Please type your email, and we will send you an
					        email with a new temporary password.
					      </th>
					    </tr>
					    <!-- check if there's an error message to display -->
					    <c:if test="${requestScope.resetPasswordError ne null}">
					      <tr>
					        <td colspan="2">
					          <font color="red">${requestScope.resetPasswordError}</font>
					        </td>
					      </tr>
					    </c:if>
					    <tr>
					      <td align="right" width="180" nowrap="nowrap">Your email: </td>
					      <td align="left"><input type="text" name="email"/></td>
					    </tr>
					    <tr>
					      <td colspan="2" align="center">
					        <input type="submit" value="Reset Password"/>
					      </td>
					    </tr>
					  </table>
			    </form>
			  </c:otherwise>
			</c:choose>
    </div>
  </imp:pageFrame>
</jsp:root>
