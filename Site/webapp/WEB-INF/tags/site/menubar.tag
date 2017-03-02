<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
  xmlns:jsp="http://java.sun.com/JSP/Page"
  xmlns:c="http://java.sun.com/jsp/jstl/core"
  xmlns:common="urn:jsptagdir:/WEB-INF/tags/site-common"
  xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <jsp:directive.attribute name="refer" required="false" 
    description="Page calling this tag"/>


  <c:set var="base" value="${pageContext.request.contextPath}"/>
  <c:set var="project" value="${applicationScope.wdkModel.name}" />
  <c:set var="modelName" value="${applicationScope.wdkModel.name}" />
  <c:set var="wdkModel" value="${applicationScope.wdkModel}"/>
  <c:set var="wdkUser" value="${sessionScope.wdkUser}"/>


  <!-- for external links -->
  <jsp:useBean id="constants" class="org.eupathdb.common.model.JspConstants"/>

  <c:set var="xqSetMap" value="${wdkModel.xmlQuestionSetsMap}"/>
  <c:set var="xqSet" value="${xqSetMap['XmlQuestions']}"/>
  <c:set var="xqMap" value="${xqSet.questionsMap}"/>
  <c:set var="extlQuestion" value="${xqMap['ExternalLinks']}"/>
  <c:catch var="extlAnswer_exception">
    <c:set var="extlAnswer" value="${extlQuestion.fullAnswer}"/>
  </c:catch>

  <c:choose>
    <c:when test="${wdkUser.stepCount == null}">
      <c:set var="count" value="0"/>
    </c:when>
    <c:otherwise>
      <c:set var="count" value="${wdkUser.strategyCount}"/>
    </c:otherwise>
  </c:choose>
  <c:set var="basketCount" value="${wdkUser.basketCount}"/>



  <common:menubar refer="${refer}">
    <li><a><span>Tools</span></a>
      <ul>
        <li><a href="${base}/showQuestion.do?questionFullName=SequenceQuestions.ByBlast"><span>BLAST</span></a></li>
        <li><a href="${base}/proteomeUpload.do"><span>Assign your proteins to groups</span></a></li>
        <li><a href="/common/downloads/software"><span>Download OrthoMCL software</span></a></li>
        <li><a href="${base}/serviceList.jsp"><span>Web Services</span></a></li>
        <li><a href="${constants.orthoGoogleUrl}">Publications that mention OrthoMCL</a></li>
      </ul>
    </li>

    <li><a><span>Data Summary</span></a>
      <ul>
        <li><a href="${base}/getDataSummary.do?summary=release"><span>Genome Statistics</span></a></li>
        <li><a href="${base}/getDataSummary.do?summary=data"><span>Genome Sources</span></a></li>
      </ul>
    </li>

    <li><a href="/common/downloads"><span>Downloads</span></a></li>

    <li><a><span>Community</span></a>
      <ul>
        <li><a href="javascript:wdk.publicStrats.goToPublicStrats()">Public Strategies</a></li>
        <imp:socialMedia small="true" label="true"/>
      </ul>
    </li>
  </common:menubar>
</jsp:root>
