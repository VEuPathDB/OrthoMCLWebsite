<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>

<c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>
<c:set var="groupName" value="${wdkRecord.attributes['group_name']}" />

<link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/svg.css' />">

<embed src="http://jerric.orthomcl.org/orthomcl.jerric/getSvgContent.do?group=${groupName}"
       width="1000" height="700" type="image/svg+xml"></embed>
