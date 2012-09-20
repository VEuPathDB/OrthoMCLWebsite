<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.servletsuite.com/servlets/wraptag" %>

<!-- get wdkRecord from proper scope -->
<c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>

<c:set var="msa" value="${wdkRecord.attributes['msa']}" />

<div id="msa">
  <c:choose>
    <c:when test="${msa.value == null || mas.value eq ''}">
      Multiple Sequence Alignment not available for this ortholog group, <br />
      since it contains more than 100 genes.
    </c:when>
    <c:otherwise>
      <pre>
        ${msa.value}
      </pre>
    </c:otherwise>
  </c:choose>
</div>
