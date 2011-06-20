<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>

<!-- get wdkModel saved in application scope -->
<c:set var="wdkModel" value="${applicationScope.wdkModel}"/>

<!-- get wdkModel name to display as page header -->
<c:set value="${wdkModel.displayName}" var="wdkModelDispName"/>
<site:header banner="WDK ${wdkModelDispName} Home page" />

<!-- display wdkModel introduction text -->
<p style="padding-left:1em;">
<b><i>${wdkModel.introduction}</i></b>
</pn>
<hr>

<!-- show all questionSets in model -->
<table width="100%" style="margin-left:10px;">
<c:set value="${wdkModel.questionSets}" var="questionSets"/>
<c:forEach items="${questionSets}" var="qSet">
  <c:if test="${qSet.internal == false}">
  <tr><td bgcolor="lightblue">${qSet.description}</td></tr>
  <tr><td><!-- list of questions in a questionSet -->
          <html:form method="get" action="/showQuestion.do">
          <html:select property="questionFullName">
            <c:set value="${qSet.name}" var="qSetName"/>
            <c:set value="${qSet.questions}" var="questions"/>
            <c:forEach items="${questions}" var="q">
              <c:if test="${q.isCombined == false}">
                <c:set value="${q.name}" var="qName"/>
                <c:set value="${q.displayName}" var="qDispName"/>
                <html:option value="${qSetName}.${qName}">${qDispName}</html:option>
              </c:if>
            </c:forEach>
          </html:select>
          <html:submit value="Select Search"/>
          </html:form>
	<br>
       </td>
   </c:if>
</c:forEach>
</table>

<site:footer/>
