<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>

<!-- get wdkModel saved in application scope -->
<c:set var="wdkModel" value="${applicationScope.wdkModel}"/>
<c:set var="wdkUser" value="${sessionScope.wdkUser}" />
<c:if test="${wdkUser == null}">
  <c:set var="wdkUser" value="${wdkModel.userFactory.guestUser}" />
</c:if>

<%-- load help record, and obtain statistics --%>
<%-- load the taxon info --%>
<c:set var="helperQuestions" value="${wdkModel.questionSetsMap['HelperQuestions']}" />
<c:set var="helperQuestion" value="${helperQuestions.questionsMap['ByDefault']}" />
<jsp:setProperty name="helperQuestion" property="user" value="${wdkUser}" />
<c:set var="helperRecords" value="${helperQuestion.answerValue.records}" />
<c:forEach items="${helperRecords}" var="item">
  <c:set var="helperRecord" value="${item}" />
</c:forEach>
<c:set var="attributes" value="${helperRecord.attributes}" />
<c:set var="organism_count" value="${attributes['organism_count']}" />
<c:set var="protein_count" value="${attributes['protein_count']}" />
<c:set var="group_count" value="${attributes['group_count']}" />


<imp:header title="OrthoMCL" refer="home" />
<imp:sidebar />

  <!-- display wdkModel introduction text -->
  <div id="site-title">${wdkModel.introduction}</div>
  <div id="site-intro" class="ui-widget ui-widget-content ui-corner-all">
    <p>Ortholog Groups of Protein Sequences from Multiple Genomes!</p>
    <p>Current Release: Version: ${wdkModel.version}</p>
    <c:url var="organismUrl" value="/showSummary.do?view=organism"/>
    <c:url var="proteinUrl" value="/processQuestion.do?questionFullName=SequenceQuestions.AllSequences&questionSubmit=Get%20Answer"/>
    <c:url var="groupUrl" value="/processQuestion.do?questionFullName=GroupQuestions.AllGroups&questionSubmit=Get%20Answer"/>
    <p>Number of Genomes: <a href="${organismUrl}"><b>${organism_count}</b></a>, 
       Number of Protein Sequences: <a href="${proteinUrl}"><b>${protein_count}</b></a>, 
       <br>Number of Ortholog Groups: <a href="${groupUrl}"><b>${group_count}</b></a>
    </p>
  </div>

  <div id="search-bubbles">
    <ul>
      <imp:searchCategories />
      
      <li><a title="Tools">Tools</a>
        <ul>
          <li><a href="<c:url value='/showQuestion.do?questionFullName=SequenceQuestions.ByBlast'/>">BLAST</a></li>
          <li><a href="<c:url value='/proteomeUpload.do'/>">Assign proteins to groups</a></li>
        </ul>
      </li>
    </ul>
  </div>

<imp:footer/>
