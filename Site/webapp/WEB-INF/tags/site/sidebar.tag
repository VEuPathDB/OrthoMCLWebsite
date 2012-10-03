<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="project" value="${applicationScope.wdkModel.displayName}" />

<script>
$(function() {
  $( "#sidebar" ).accordion({
    navigation: true,
    icons:false
  });
});
</script>


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

<c:url var="organismUrl" value="/getDataSummary.do?summary=data"/>

<%------------------------------------------%>
<div id="sidebar">
  <h3>
	   <img src="/assets/images/${project}/menu_lft1.png" alt="" width="208" height="12" />
     <a class="heading" id='stats'  href="#">Data Summary</a>
  </h3>
  <div>
    <ul>
    <li><a href="${organismUrl}">Genomes: <b>${organism_count}</b></a></li>
    <li>Protein Sequences: <b>${protein_count}<br></b></li>
    <li>Ortholog Groups: <b>${group_count}</b></li>
    </ul>
  </div>


  <h3>
     <img src="/assets/images/${project}/menu_lft1.png" alt="" width="208" height="12" />
      <a class="heading"  href="#">News</a>
  </h3>
  <div>
    <ul>
      <li><a href="/showDataSummary.do?data=orgamism">Show Organism Summary</a></li>
      <li><a href="/showDataSummary.do?data=protein">Show Protein Summary</a></li>
    </ul>
  </div>

  <h3><a href="#community">Community Resources</a></h3>
  <div>
    <ul>
      <li><a href="/showDataSummary.do?data=orgamism">Show Organism Summary</a></li>
      <li><a href="/showDataSummary.do?data=protein">Show Protein Summary</a></li>
    </ul>
  </div>

  <h3><a href="#tutorials">Web Tutorials</a></h3>
  <div> 
    <ul>
      <li><a href="/showDataSummary.do?data=orgamism">Show Organism Summary</a></li>
      <li><a href="/showDataSummary.do?data=protein">Show Protein Summary</a></li>
    </ul>
  </div>

  <h3><a href="#help">Information and Help</a></h3>
  <div> 
    <ul>
      <li><a href="/showDataSummary.do?data=orgamism">Show Organism Summary</a></li>
      <li><a href="/showDataSummary.do?data=protein">Show Protein Summary</a></li>
    </ul>
  </div>
</div>
