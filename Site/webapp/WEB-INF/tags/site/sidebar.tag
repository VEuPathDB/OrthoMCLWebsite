<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
    xmlns:wir="http://crashingdaily.com/taglib/wheninrome"
    xmlns:api="http://apidb.org/taglib"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <c:set var="props" value="${applicationScope.wdkModel.properties}" />
  <c:set var="base" value="${pageContext.request.contextPath}"/>

<!-- JSP constants -->
<jsp:useBean id="constants" class="org.eupathdb.common.model.JspConstants"/>

  <c:set var="wdkModel" value="${applicationScope.wdkModel}"/>
  <c:set var="project" value="${wdkModel.displayName}"/>
  <c:set var="wdkUser" value="${sessionScope.wdkUser}"/>

  <fmt:setLocale value="en-US"/>
  <c:set var="newsCount" value="50"/>
  <c:set var="sidebarWidth" value="211"/>  

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

	<!-- ORTHO data summary -->
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
  <span class="onload-function" data-function="eupath.setup.configureSidebar"><jsp:text/></span>


  <div id="sidebar">

    <!-- ~~~~~~~~~~~~~~~~~~~~~~~ DATA STATISTICS ~~~~~~~~~~~~~~~~~~~~~~~  -->

<h3>
	    <a class="heading" id="stats" href="#">Data Summary</a>
</h3>

	  <div>
	    <ul>
	      <li><a href="${pageContext.request.contextPath}/getDataSummary.do?summary=release">Genomes: <b><fmt:formatNumber value="${organism_count}"/></b></a></li>
	      <li>Protein Sequences: <b><fmt:formatNumber value="${protein_count}"/></b></li>
	      <li>Ortholog Groups: <b><fmt:formatNumber value="${group_count}"/></b></li>
	    </ul>
	  </div>
	
   


	 <!-- ~~~~~~~~~~~~~~~~~~~~~~~ NEWS ~~~~~~~~~~~~~~~~~~~~~~~  -->
	  <h3>
	    <a class="heading" href="#">News and Tweets</a>
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

<br/>

<!-- TWITTER WIDGET, code generated in twitter.com, EuPathDB account settings -->
 		 <a class="twitter-timeline" data-chrome="nofooter" height="50"  href="https://twitter.com/eupathdb" data-widget-id="344817818073714691">Tweets by @eupathdb</a>
		 <script>
		 !function(d,s,id){
				var js,fjs=d.getElementsByTagName(s)[0],
								p=/^http:/.test(d.location)?'http':'https';
				if(!d.getElementById(id)){
								js=d.createElement(s);
								js.id=id;
								js.src=p+"://platform.twitter.com/widgets.js";
								fjs.parentNode.insertBefore(js,fjs);
								}
				}(document,"script","twitter-wjs");
		 </script>

</div>

    <!-- ~~~~~~~~~~~~~~~~~~~~~~~ COMMUNITY, LINKS ~~~~~~~~~~~~~~~~~~~~~~~  -->
	  <h3>
      <a  class="heading" id='community' href="#">Community Resources</a>
    </h3>

	  <div>
        <!--
	    <a style="line-height:24px" href="javascript:gotoTwitter()">
            <span class="twitter"><jsp:text/></span>
		    <span>Follow us on Twitter!</span>
	    </a>
	    <br/>
	    <a href="javascript:gotoFacebook()">
            <span class="facebook"><jsp:text/></span>
		    <span>Follow us on Facebook!</span>
	    </a>
        -->
        <ul><imp:socialMedia label="true"/></ul>
	    <br/>
		  
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
      <a class="heading" id='tutorials' href="#">Education and Tutorials</a>
    </h3>

	  <div>
		  <ul id="education">
				<li id='edu-05'>
                                                                                                                          <a target="_blank" href="https://youtube.com/user/${props.youtube}/videos?sort=dd&amp;flow=list&amp;view=1">
						YouTube Tutorials Channel
						<imp:image style="width:20px;display:inline;vertical-align:middle;" src="images/youtube_32x32.png"/>
					</a>
				</li>
		    <li>
		      <a href="${base}/showXmlDataContent.do?name=XmlQuestions.Tutorials">Web Tutorials</a> (video and pdf)
		    </li> 
				<li id='edu-2'><a target="_blank" href="http://workshop.eupathdb.org/current/">EuPathDB Workshop</a></li>
				<li id='edu-3-1'><a target="_blank" href="http://workshop.eupathdb.org/most_recent/index.php?page=schedule">Exercises from our most recent Workshop</a> (English)</li>
		    <li>
		      <a href="http://www.genome.gov/Glossary/">NCBI's Glossary of Terms</a>
		    </li>
		    <li>
		      <a href="${pageContext.request.contextPath}/contact.do" class="open-window-contact-us">Contact Us</a>
		    </li>
		  </ul>
	  </div>
	
    <!-- ~~~~~~~~~~~~~~~~~~~~~~~ ABOUT ~~~~~~~~~~~~~~~~~~~~~~~  -->
	  <h3>
      <a class="heading" id='informationAndHelp' href="#">About OrthoMCL</a>
    </h3>
	  <div>
      <ul id="information">
        <imp:aboutMenu/>
      </ul>
	  </div>

	</div>
</jsp:root>
