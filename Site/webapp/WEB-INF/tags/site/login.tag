<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="logic" uri="http://jakarta.apache.org/struts/tags-logic" %>
<%@ taglib prefix="bean" uri="http://jakarta.apache.org/struts/tags-bean" %>

<%@ attribute name="showError"
              required="false"
%>

<c:set var="wdkUser" value="${sessionScope.wdkUser}"/>

<table>
<c:choose>
  <c:when test="${wdkUser != null && wdkUser.guest != true}">
      <tr>
        <td valign="top" colspan="2" style="font-size:130%">
           <c:set var="firstName" value="${wdkUser.firstName}"/>
	   Welcome: ${firstName}! 
        </td>
     </tr>
     <tr>
        <td valign="top">
           <a href="<c:url value='/profile.jsp'/>">Your Profile</a>
        </td>
        <td>
	   <html:form method="POST" action='/processLogout.do' >
              <input type="submit" value="Logout">
           </html:form>
        </td>
      </tr>

  </c:when>

  <c:otherwise>
     <c:if test="${showError && sessionScope.loginError != null && sessionScope.loginError != ''}">
       <c:set var="errorMessage" value="${sessionScope.loginError}"/>
       <c:remove var="loginError" scope="session"/>
       <tr>
          <td align="center" colspan="2">
             <div class="small"><font color="red">${errorMessage}<br>
             Note email and password are case-sensitive.</font></div>
          </td>
       </tr>
     </c:if>
     <tr>
       <td align="left">
          <html:form method="POST" action='/processLogin.do' >
<table><tr><td>
	            <b>Email: </b> <input type="text" name="email" size="10%">
	    </td>
  	    <td>
        	    <b>Password: </b> <input type="password" name="password" size="10%">
            		<a href="<c:url value='/showResetPassword.do'/>">forgot?</a>
	    </td>
	</tr>

            <c:if test="${requestScope.refererUrl != null}">
               <input type="hidden" name="refererUrl" value="${requestScope.refererUrl}">
            </c:if>
	<tr><td colspan="2" >
             <input type="submit" value="Log In">&nbsp;&nbsp;     
		     <a href="<c:url value='/showRegister.do'/>">.....or Register</a>
	</td></tr>
</table>

          </html:form>
       </td>
    </tr>


  </c:otherwise>

</c:choose>

</table>
