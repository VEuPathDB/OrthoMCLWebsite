<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<c:set var="depth" value="${param.depth}"/>
<c:if test="${!(depth > 0)}">
  <font color="red">no depth found from url param, using default: 7</font>
  <c:set var="depth" value="7"/>
</c:if>

<h1>Testing jsp recursion</h1>

Expect to see [${depth}..1], one per line, with increasing indentation: <br>

<imp:toyrecurse current_depth="${depth}" current_indent="0"/>

<br> ~~ end of test ~~ <br>
