<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="current_depth" description="current depth of recursion" %>
<%@ attribute name="current_indent" description="current depth of indentation" %>

<!-- %@ variable name-given="ident" variable-class="int" scope="NESTED" % -->

<c:if test="${current_depth > 0}">
  <c:if test="${current_indent > 0}">
    <c:forEach begin="1" end="${current_indent}" var="cur">&nbsp;</c:forEach>
  </c:if>
  <b>${current_depth}</b><br>
  <c:set var="current_depth" value="${current_depth-1}"/>
  <c:set var="current_indent" value="${current_indent+2}"/>
  <!-- site:toyrecurse current_depth="${current_depth}" current_indent="${current_indent}"/ -->
</c:if>
