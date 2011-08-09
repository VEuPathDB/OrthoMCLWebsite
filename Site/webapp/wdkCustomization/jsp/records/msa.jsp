<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.servletsuite.com/servlets/wraptag" %>

<!-- get wdkRecord from proper scope -->
<c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>

<c:set var="msa" value="${wdkRecord.attributes['msa']}" />

<div id="msa">
  <pre>
    ${msa.value}
  </pre>
</div>
