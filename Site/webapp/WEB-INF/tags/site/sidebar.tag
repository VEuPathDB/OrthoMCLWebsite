<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
    xmlns:wir="http://crashingdaily.com/taglib/wheninrome"
    xmlns:api="http://apidb.org/taglib"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions">


  <c:set var="base" value="${pageContext.request.contextPath}"/>


  <c:set var="wdkModel" value="${applicationScope.wdkModel}"/>
  <c:set var="project" value="${wdkModel.displayName}"/>
  <c:set var="wdkUser" value="${sessionScope.wdkUser}"/>

  <fmt:setLocale value="en-US"/>
  <c:set var="newsCount" value="50"/>
  <c:set var="sidebarWidth" value="208"/>


<c:set var="xqSetMap" value="${wdkModel.xmlQuestionSetsMap}"/>
<c:set var="xqSet" value="${xqSetMap['XmlQuestions']}"/>
<c:set var="xqMap" value="${xqSet.questionsMap}"/>
<c:set var="newsQuestion" value="${xqMap['News']}"/>
<c:set var="tutQuestion" value="${xqMap['Tutorials']}"/>
<c:set var="extlQuestion" value="${xqMap['ExternalLinks']}"/>
<c:set var="newsAnswer" value="${newsQuestion.fullAnswer}"/>
<c:set var="tutAnswer" value="${tutQuestion.fullAnswer}"/>
<c:catch var="extlAnswer_exception">
  <c:set var="extlAnswer" value="${extlQuestion.fullAnswer}"/>
</c:catch>
<c:set var="dateStringPattern" value="dd MMMM yyyy HH:mm"/>


	<!-- load help record and taxon info -->
	<c:set var="helperQuestion" value="${wdkModel.questionSetsMap['HelperQuestions'].questionsMap['ByDefault']}"/>
  <!-- must set user on question before retrieving answer value -->	
	<jsp:setProperty name="helperQuestion" property="user" value="${wdkUser}"/>
	<!-- compile records and obtain statistics -->
	<c:forEach items="${helperQuestion.answerValue.records}" var="item">
	  <c:set var="helperRecord" value="${item}"/>
	</c:forEach>
	<c:set var="organism_count" value="${helperRecord.attributes['organism_count'].value}"/>
	<c:set var="protein_count" value="${helperRecord.attributes['protein_count'].value}"/>
	<c:set var="group_count" value="${helperRecord.attributes['group_count'].value}"/>

  <!-- jquery accordion configuration -->
  <span class="onload-function" data-function="Setup.configureSidebar"><jsp:text/></span>


  <div id="sidebar">
  <!-- ~~~~~~~~~~~~~~~~~~~~~~~ DATA STATISTICS ~~~~~~~~~~~~~~~~~~~~~~~  -->
	  <h3>
		  <img src="/assets/images/${project}/menu_lft1.png" alt="" width="${sidebarWidth}" height="12"/>
	    <a class="heading" id="stats" href="#">Data Summary</a>
	  </h3>
	  <div>
	    <ul>
	      <li><a href="${pageContext.request.contextPath}/getDataSummary.do?summary=data">Genomes: <b><fmt:formatNumber value="${organism_count}"/></b></a></li>
	      <li>Protein Sequences: <b><fmt:formatNumber value="${protein_count}"/></b></li>
	      <li>Ortholog Groups: <b><fmt:formatNumber value="${group_count}"/></b></li>
	    </ul>
	  </div>
	
  <!-- ~~~~~~~~~~~~~~~~~~~~~~~ NEWS ~~~~~~~~~~~~~~~~~~~~~~~  -->
	  <h3>
	    <img src="/assets/images/${project}/menu_lft1.png" alt=""  width="${sidebarWidth}" height="12"/>
	    <a class="heading" href="#">News</a>
	  </h3>
	  <div>

  <c:choose>
  <c:when test="${newsAnswer.resultSize lt 1}">
    No news now, please check back later.<br/>
  </c:when>
  <c:otherwise>
	  <c:catch var="newsErr">
    <c:set var="i" value="1"/>
    <ul id="news">

<li><b>Mar 31, 2011</b>: OrthoMCL-DB Version 5 is released. We have included 150 genomes in this release.
</li>
<li><b>May 31, 2010</b> : OrthoMCL-DB Version 4 is released. There are 138 genomes included in version 4.
</li>
<li><b>Oct 9, 2009</b> : OrthoMCL-DB Version 3 is released. The new dataset includes 128 genomes.  New web site features include: (1) a tool to assign your proteins to OrthoMCL groups (see the new tools menu);  (2) a mapping from Version 3 groups to Version 2 and 1 is available for searching, allowing you to track changes across versions;  (3) the phyletic pattern in the groups result page is configurable, so you can tailor it to the clades you are interested in.
</li>

      <c:forEach items="${newsAnswer.recordInstances}" var="record">
			  <c:if test="${i le newsCount }">  
          <c:set var="attrs" value="${record.attributesMap}"/>
          <c:set var='tmp' value="${attrs['tag']}"/>
          <c:set var='shorttag' value=''/>
          <c:forEach var="k" begin="0" end="${fn:length(tmp)}" step='3'>
            <c:set var='shorttag'>${shorttag}${fn:substring(tmp, k, k+1)}</c:set>
          </c:forEach>
            
          <fmt:parseDate pattern="${dateStringPattern}" var="pdate" value="${attrs['date']}"/> 
          <fmt:formatDate var="fdate" value="${pdate}" pattern="d MMMM yyyy"/>
      
           <li id="n-${shorttag}"><b>${fdate}</b>
             <a href="${base}/showXmlDataContent.do?name=XmlQuestions.News#${attrs['tag']}">
               ${attrs['headline']}
             </a>
           </li>
         </c:if>
         <c:set var="i" value="${i+1}"/>
       </c:forEach>
     </ul>
     </c:catch>

     <c:if test="${newsErr ne null}">
		    <i>News temporarily unavailable<br/></i>
	   </c:if>
	   <br/>
	   <a class="small" href="${base}/showXmlDataContent.do?name=XmlQuestions.News">All ${project} News >>></a>
   </c:otherwise>
   </c:choose>

	 </div>
	

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~ COMMUNITY, LINKS ~~~~~~~~~~~~~~~~~~~~~~~  -->
	  <h3>
      <img src="/assets/images/${project}/menu_lft1.png" alt="" width="${sidebarWidth}" height="12" />
      <a  class="heading" id='community' href="#">Community Resources</a>
    </h3>
	  <div>


    <a style="line-height:24px" href="javascript:gotoTwitter()">
	    <img style="margin-left:17px;float:left;vertical-align:middle" title="Follow us on Twitter!" src="/assets/images/twitter.gif" width="25"/>
	    <span style="vertical-align:sub">Follow us on Twitter!</span>
    </a>
    <br/>
    <a href="javascript:gotoFacebook()">
	    <img style="margin-left:19px;float:left;vertical-align:middle" title="Follow us on Facebook!" src="/assets/images/facebook-icon.png" width="22"/>
	    <span style="vertical-align:sub">Follow us on Facebook!</span>
    </a>
    <br/><br/>
    <hr style="color:lightgrey"/>


 <b>Related Sites</b>
  <c:choose>
  <c:when test="${extlAnswer_exception ne null}">
    <br/><font size="-1" color="#CC0033"><i>Error. related sites temporarily unavailable</i></font><br/>
  </c:when>
  <c:when test="${extlAnswer.resultSize lt 1}">
    No links.
  </c:when>
  <c:otherwise>
    <ul class="related-sites">
		  <c:set var="count" value="0" />
      <c:forEach items="${extlAnswer.recordInstances}" var="record">
        <c:forEach items="${record.tables}" var="table">
          <c:forEach items="${table.rows}" var="row"> 
            <c:set var='url' value='${row[1].value}'/>
            <c:set var='tmp' value='${fn:replace(url, "http://", "")}'/>
            <c:set var='tmp' value='${fn:replace(tmp, ".", "")}'/>
            <c:set var='uid' value=''/>
            <c:forEach var="i" begin="0" end="${fn:length(tmp)}" step='3'>
              <c:set var='uid'>${uid}${fn:substring(tmp, i, i+1)}</c:set>
            </c:forEach>
            <li id='rs-${uid}'><a href="${url}">${row[0].value}</a></li>
			   		<c:set var="count" value="${count + 1}" />
          </c:forEach>
        </c:forEach>
      </c:forEach> 
    </ul>
  </c:otherwise>
  </c:choose>

	  </div>
	
  <!-- ~~~~~~~~~~~~~~~~~~~~~~~ TUTORIALS ~~~~~~~~~~~~~~~~~~~~~~~  -->
	  <h3>
      <img src="/assets/images/${project}/menu_lft1.png" alt="" width="${sidebarWidth}" height="12" />
      <a class="heading" id='tutorials' href="#">Education and Tutorials</a>
    </h3>
	  <div> 

 <ul id="education">
<!-- 	  <li>
		  <a href="${base}/showXmlDataContent.do?name=XmlQuestions.Tutorials">Web Tutorials</a> (video and pdf)</a>
    </li> -->
    <li>
      <a href="http://workshop.eupathdb.org/current/">EuPathDB Workshop</a>
    </li>
    <li>
      <a href="http://workshop.eupathdb.org/current/index.php?page=schedule">Exercises from our most recent Workshop</a> (English)
    </li>
    <li>
      <a href="http://workshop.eupathdb.org/2011/index.php?page=schedule">Exercises from 2011 Workshop</a> (English and Spanish)
    </li>
	  <li>
      <a href="http://www.genome.gov/Glossary/">NCBI's Glossary of Terms</a>
    </li>
	  <li>
      <a href="${base}/showXmlDataContent.do?name=XmlQuestions.Glossary">Our Glossary</a>
    </li>
    <li>
      <a href="${base}/help.jsp" target="_blank" onClick="poptastic(this.href); return false;">Contact Us</a>
    </li>
  </ul>

	  </div>
	
  <!-- ~~~~~~~~~~~~~~~~~~~~~~~ OTHER INFO   ~~~~~~~~~~~~~~~~~~~~~~~  -->
	  <h3>
      <img src="/assets/images/${project}/menu_lft1.png" alt="" width="${sidebarWidth}" height="12" />
      <a class="heading" id='informationAndHelp' href="#">Other Information</a>
    </h3>
	  <div> 

 <ul id="information">
    <li>
      <a href="">How to Cite us</a>
    </li>
    <li>
      <a href="">Organisms in ${project}</a>
    </li>
		<li>
  <!--    <a href="http://scholar.google.com/scholar?as_q=&num=10&as_epq=&as_oq=OrthoMCL+PlasmoDB+ToxoDB+CryptoDB+TrichDB+GiardiaDB+TriTrypDB+AmoebaDB+MicrosporidiaDB+%22FungiDB%22+PiroplasmaDB+ApiDB+EuPathDB&as_eq=encrypt+cryptography+hymenoptera&as_occt=any&as_sauthors=&as_publication=&as_ylo=&as_yhi=&as_sdt=1.&as_sdtp=on&as_sdtf=&as_sdts=39&btnG=Search+Scholar&hl=en">Publications that Cite Us</a> 
   -->
    </li>
   	<li>
      <a href="http://eupathdb.org/tutorials/eupathdbFlyer.pdf">EuPathDB Brochure</a>
    </li>
   	<li>
      <a href="/proxystats/awstats.pl?config=${fn:toLowerCase(project)}.org">Website Usage Statistics</a>
    </li>
  </ul>

	  </div>


	</div>

</jsp:root>
