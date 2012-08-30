<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="logic" uri="http://jakarta.apache.org/struts/tags-logic" %>
<%@ taglib prefix="bean" uri="http://jakarta.apache.org/struts/tags-bean" %>

<%@ attribute name="showError"
              required="false"
%>

<c:set var="wdkUser" value="${sessionScope.wdkUser}"/>
<span id="user-control">
  <c:choose>
    <c:when test="${wdkUser != null && wdkUser.guest != true}">
      <c:set var="userName" value="${wdkUser.firstName} ${wdkUser.lastName}" />
      <a href="<c:url value='/profile.jsp'/>"><span id="user-name">${userName}</span>'s Profile</a> |
      <a href="javascript:void(0)" onclick="logout()">Logout</a>
      <div id="logout" data-location="<c:url value='/processLogout.do'/>"></div>
    </c:when>

    <c:otherwise>
      <a href="javascript:void(0)" onclick="login(this)">Login</a> |
      <a href="<c:url value='/register.do'/>">Register</a>
      <div id="login">
        <div class="title">OrthoMCL Account Login</div>
        <form name="loginForm" method="POST" action="<c:url value='/processLogin.do'/>">
          <table>
            <tr>
              <th>Email:</th>
              <td><input id="email" type="text" size="20" name="email" /></td>
            </tr>
            <tr>
              <th>Password:</th>
              <td><input id="password" type="password" size="20" name="password"></td>
            </tr>
            <tr>
              <td align="center" colspan="2">
                <input type="checkbox" size="11" name="remember" id="remember">Remember me on this computer.
              </td>
            </tr>
            <tr>
              <td align="center" colspan="2">
                <span class="small">
                  <input type="submit" class="button" value="Login">  
                  <input id="login-cancel-button" type="button" class="button" value="Cancel">             
                </span>
              </td>
            </tr>
            <tr>
              <td valign="top" align="center" colspan="2">
                <span class="small">
                  <a href="<c:url value='/showResetPassword.do'/>">Forgot Password?</a>&nbsp;&nbsp;
                  <a href="<c:url value='/showRegister.do'/>">Register/Subscribe</a>
                </span>
              </td>
            </tr>
        </table>
      </form>
      </div>
    </c:otherwise>
  </c:choose>
</span>
