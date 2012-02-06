<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>


<c:set var="wdkStep" value="${requestScope.wdkStep}" />
<c:set var="wdkAnswer" value="${wdkStep.answerValue}"/>


<pre>
${wdkAnswer.resultMessage}
</pre>
