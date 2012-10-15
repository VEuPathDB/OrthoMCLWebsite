<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>  
  <imp:pageFrame title="${wdkModel.displayName} :: Registration" refer="register">
    <div class="user-form-frame">
		  <!-- display the success information if the user registered successfully -->
		  <c:choose>
		    <c:when test="${requestScope.registerSucceed ne null}">
		      <h1>You have registered successfully.</h1>
		      <p>We have sent you an email with a temporary password.</p>
		      <p>Please <a href="${pageContext.request.contextPath}/login.do">log in</a> and change your password to one that you'll remember.</p>
		    </c:when>
		    <c:otherwise>
	        <div align="left" style="font-size:1.2em; width:700px; margin-left:auto; margin-right:auto; border:1px solid black; padding:5px; line-height:1.5em;">
		        <p><b>Why register/subscribe?</b> So you can:</p>
		        <div id="cirbulletlist">
		          <ul>
		            <li>Have your strategies back the next time you login</li>
		            <li>Add a comment on genes and sequences</li>
		            <li>Set site preferences, such as items per page displayed in the query result</li>
		          </ul>
		        </div>
	        </div>
	        <br/>
          <!-- registration form -->
          <form name="registerForm" method="post" action="processRegister.do" >
		        <table width="650" class="user-form-table">
		          <c:choose>
		            <c:when test="${wdkUser ne null and wdkUser.guest ne true}">
		              <tr>
		                <td colspan="2">
		                  <p>You are logged in.</p>
		                  <p>To change your password or profile go <a href="${pageContext.request.contextPath}/showProfile.do">here</a>.</p>
		                </td>
		              </tr>
		            </c:when>
		            <c:otherwise>
		              <!-- check if there's an error message to display -->
							    <c:if test="${requestScope.registerError ne null}">
							      <tr>
							        <td colspan="2">
							          <font color="red">${requestScope.registerError}</font>
							        </td>
							      </tr>
							    </c:if>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Email: </td>
							      <td align="left"><input type="text" name="email" value="${requestScope.email}" size="20"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Confirm Email: </td>
							      <td align="left"><input type="text" name="confirmEmail" value="${requestScope.email}" size="20"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> First Name: </td>
							      <td align="left"><input type="text" name="firstName" value="${requestScope.firstName}" size="20"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap">Middle Name: </td>
							      <td align="left"><input type="text" name="middleName" value="${requestScope.middleName}" size="20"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Last Name: </td>
							      <td align="left"><input type="text" name="lastName" value="${requestScope.lastName}" size="20"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Institution: </td>
							      <td align="left"><input type="text" name="organization" value="${requestScope.organization}" size="50"/></td>
							    </tr>
							    <!-- <tr>
							      <td align="right" width="50%" nowrap="nowrap"> OpenID (<a class="open-dialog-about-openid" href="javascript:void(0)">What is this?</a>): </td>
							      <td align="left"><input type="text" name="openId" value="${requestScope.openId}" size="50"/></td>
							    </tr> -->
							    <tr>
							      <td colspan="2" align="center">
							        <input type="submit" name="registerButton" value="Submit"  onclick="return User.validateRegistrationForm();"/>
							      </td>
							    </tr>
							  </c:otherwise>
		          </c:choose>
		        </table>
		      </form>
		    </c:otherwise>
		  </c:choose>
		  <br/>
		  <div align="left" style="line-height:1.5em;">
        <hr/>
			  <div style="font-size:1.2em;">
			    <b>&#160;&#160;&#160;Privacy Policy</b>
			  </div>
			  <table style="margin-left:10px;">
			    <tr>
			      <td width="40%">
			        <p><b>How we will use your email:</b></p>
			        <div id="cirbulletlist">
			          <ul>
			            <li>Confirm your subscription</li>
			            <li>Send you infrequent alerts if you subscribe to receive them</li>
			            <li>NOTHING ELSE.  We will not release the email list.</li>
			          </ul>
			        </div>
			      </td>
			      <td>
			        <p><b>How we will use your name and institution:</b></p>
			        <div id="cirbulletlist">
			          <ul>
			            <li>If you add a comment to a Gene or a Sequence, your name and institution will be displayed with the comment</li>
			            <li>NOTHING ELSE.  We will not release your name or institution.</li>
			          </ul>
			        </div>
			      </td>
			    </tr>
			  </table>
        <hr/>
		  </div>  <!-- div align left -->
		</div> <!-- div align center -->
  </imp:pageFrame>
</jsp:root>
