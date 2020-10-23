<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions">

  <jsp:useBean id="constants" class="org.eupathdb.common.model.JspConstants"/>
  
  <c:set var="base" value="${pageContext.request.contextPath}"/>
  <c:set var="project" value="${applicationScope.wdkModel.displayName}"/>

  <li><a href="${base}/about.do#release">Current Release</a></li>
  <li><a href="${base}/about.do#forming_groups">Method for Forming and Expanding Ortholog Groups</a></li>
  <li><a href="${base}/about.do#orthomcl_algorithm">The OrthoMCL Algorithm</a></li>
  <li><a href="${base}/about.do#background">Background on Orthology and Prediction</a></li>
  <li><a href="${base}/about.do#faq">Frequently Asked Questions</a></li>
  <li><a href="${base}/about.do#software">Software</a></li>
  <li><a href="${base}/about.do#pubs">Publications</a></li>
  <li><a href="${constants.publicationUrl}">Publications mentioning OrthoMCL</a></li>
  <li><a href="${base}/about.do#acknowledge">Acknowledgements</a></li>
  <li><a href="http://eupathdb.org/tutorials/eupathdbFlyer.pdf">VEuPathDB Brochure</a></li>
  <li><a href="/proxystats/awstats.pl?config=${fn:toLowerCase(project)}.org">Website Usage Statistics</a></li>
  <li><a href="${base}/about.do#contact">Contact</a></li>

</jsp:root>
