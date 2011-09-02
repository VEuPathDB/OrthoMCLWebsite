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
      <c:set var="userName" value="${wdkUser.firstName} ${wdkUser.lastName}}" />
      <a href="<c:url value='/profile.jsp'/>">${userName}'s Profile</a> |
      <a href="<c:url value='/processLogout.do'/>">Logout</a>
    </c:when>

    <c:otherwise>
      <a href="<c:url value='/login.do'/>">Login</a> |
      <a href="<c:url value='/register.do'/>">Register</a>
    </c:otherwise>
  </c:choose>
</span>
