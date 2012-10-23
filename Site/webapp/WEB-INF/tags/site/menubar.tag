<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%@ attribute name="refer" 
 			  type="java.lang.String"
			  required="false" 
			  description="Page calling this tag"
%>

<c:set var="project" value="${applicationScope.wdkModel.name}" />
<c:set var="modelName" value="${applicationScope.wdkModel.name}" />
<c:set var="wdkModel" value="${applicationScope.wdkModel}"/>
<c:set var="wdkUser" value="${sessionScope.wdkUser}"/>


<!-- for external links -->
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


<span class="onload-function" data-function="Setup.configureMenuBar"><jsp:text/></span>

<div id="menu" class="ui-helper-clearfix">

<!-- default style for this ul establishes 9em -->
  <ul class="sf-menu">
    <li><a href="/"><span>Home</span></a></li>

    <imp:wdkMenu />

    <li><a><span>Tools</span></a>
	    <ul>
	      <li><a href="<c:url value="/showQuestion.do?questionFullName=SequenceQuestions.ByBlast"/>"><span>BLAST</span></a></li>
  	     <li><a href="<c:url value="/proteomeUpload.do"/>"><span>Assign your proteins to groups</span></a></li>
         <!--   <li><a href="/pubcrawler/${project}"><span>PubMed and Entrez</span></a></li> -->
	      <!--  <li><a href="<c:url value="/serviceList.jsp"/>"><span>Searches via Web Services</span></a></li> -->
    	</ul>
    </li>

    <li><a><span>Data Summary</span></a>
  	  <ul>
   	    <li><a href="<c:url value='/getDataSummary.do?summary=data'/>"><span>Data Sources</span></a></li>
 	      <li><a href="<c:url value='/getDataSummary.do?summary=release'/>"><span>Summary Statistics</span></a></li>
	    </ul>
    </li>

    <li><a href="/common/downloads"><span>Downloads</span></a></li>
    
    <li><a><span>Community</span></a>
	    <ul>
		    <li><a href="http://twitter.com/eupathdb">
          <span><img style="margin:0px;vertical-align:top" title="Follow us on twitter!" 
                      src="${pageContext.request.contextPath}/wdkCustomization/images/twitter.gif" width="20">
			      &nbsp;Follow us on twitter!
          </span></a>
        </li>
        <li><a href="https://www.facebook.com/pages/EuPathDB/133123003429972">
          <span><img style="margin:0px;margin-left:1px;vertical-align:top" title="Follow us on facebook!" 
                     src="${pageContext.request.contextPath}//wdkCustomization/images/facebook.png" width="18">
            &nbsp;Follow us on facebook!
          </span></a>
		    </li>
<!--
  	    <c:choose>
    	    <c:when test="${extlAnswer_exception != null}">
	    	<li><a href="#"><span><font color="#CC0033"><i>Error. related sites temporarily unavailable</i></font></span></a></li>
    	    </c:when>
    	    <c:otherwise>
    		<li><a href="<c:url value="/showXmlDataContent.do?name=XmlQuestions.ExternalLinks"/>"><span>Related Sites</span></a></li>
    	    </c:otherwise>
    	    </c:choose>
-->
  	  </ul>
    </li>

  </ul>

</div>

