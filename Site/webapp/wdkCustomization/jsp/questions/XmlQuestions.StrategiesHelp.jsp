<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:html="http://jakarta.apache.org/struts/tags-html"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <!-- get wdkXmlAnswer saved in request scope -->
  <c:set var="xmlAnswer" value="${requestScope.wdkXmlAnswer}"/>
  <c:set var="banner" value="${xmlAnswer.question.displayName}"/>
  <c:set var="wdkModel" value="${applicationScope.wdkModel}"/>
  <c:set var="base" value="${pageContext.request.contextPath}"/>

  <imp:pageFrame title="${wdkModel.displayName} : Did You Know">
    <div>
      <div id="strategyTips">
        <table border="0" width="100%" cellpadding="3" cellspacing="0" bgcolor="white" class="thinTopBottomBorders">
          <tr>
            <td bgcolor="white" valign="top">
              <!-- handle empty result set situation -->
              <c:choose>
                <c:when test="${xmlAnswer.resultSize eq 0}">
                  Not available.
                </c:when>
                <c:otherwise>

                  <!-- main body start -->
                  <table border="0" cellpadding="2" cellspacing="0" width="100%">
										<c:set var="i" value="0"/>
										<c:set var="alreadyPrintedSomething" value="false"/>
										<c:forEach items="${xmlAnswer.recordInstances}" var="record">
										  <c:choose>
										    <c:when test="${param['idx'] ne null and param['idx'] ne i}">
										    </c:when>
										    <c:otherwise>
													<tr class="rowLight">
													  <td>
													    <c:if test="${alreadyPrintedSomething}"><hr/></c:if>
													    <c:set var="alreadyPrintedSomething" value="true"/>
													    <c:set var="title" value="${record.attributesMap['title']}"/>
													    <c:set var="text" value="${record.attributesMap['body']}"/>
													    <c:set var="image" value="${record.attributesMap['image']}"/>
													    <c:set var="showTip" value="${record.attributesMap['showTipAsDidYouKnow']}"/>
													    <c:set var="tip" value="${record.attributesMap['tip']}"/>
													    <b id="strat_help_${i}" class="strat_help_title">${title}</b>
													    <c:if test="${showTip}">
													      <span id="tip_${i}">
													        <div style="margin: 10px 15px 15px;">
													          <p>
													            <b>...${tip}</b>&#160;
													            <a href="#strat_help_${i}">Learn more...</a>
													          </p>
													        </div>
													      </span>
													    </c:if>
													    <br/><br/>${text}<br/>
													    <c:if test="${image ne null and image ne ''}">
													      <img src="${base}/wdk/${image}" alt=""/>
													    </c:if>
													  </td>
													</tr>
										    </c:otherwise>
										  </c:choose>
										  <c:set var="i" value="${i+1}"/>
										</c:forEach>
								  </table>
								  <!-- main body end -->

                </c:otherwise>
              </c:choose>
            </td>
            <td valign="top" class="dottedLeftBorder"></td> 
          </tr>
        </table> 
      </div>
    </div>
  </imp:pageFrame>
</jsp:root>
