<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--  if we want to have footer spanning only under buckets --%>
<%@ attribute name="refer" 
 			  type="java.lang.String"
			  required="false" 
			  description="Page calling this tag"
%>

<c:set var="siteName" value="${applicationScope.wdkModel.name}" />
<c:set var="version" value="${applicationScope.wdkModel.version}" />

<c:set var="releaseDate" value="${applicationScope.wdkModel.releaseDate}" />
<c:set var="inputDateFormat" value="dd MMMM yyyy HH:mm"/>
<fmt:setLocale value="en-US"/><%-- req. for date parsing when client browser (e.g. curl) does not send locale --%>
<fmt:parseDate pattern="${inputDateFormat}" var="rlsDate" value="${releaseDate}"/> 
<fmt:formatDate var="releaseDate_formatted" value="${rlsDate}" pattern="MMMM d, yyyy"/>
<%-- http://java.sun.com/j2se/1.5.0/docs/api/java/text/SimpleDateFormat.html --%>
<fmt:formatDate var="copyrightYear" value="${rlsDate}" pattern="yyyy"/>

</div> <!-- END of div#main-content, which is defined in the header -->

<div id="footer">
  <div id="copyright">
    <a href="http://${fn:toLowerCase(siteName)}.org">${siteName}</a> ${version}&nbsp;&nbsp;&nbsp;&nbsp;${releaseDate_formatted}
    <br>&copy;${copyrightYear} The EuPathDB Project Team
  </div>

  <div id="contact">
    Please <a href="<c:url value="/help.jsp"/>" target="_blank" onClick="poptastic(this.href); return false;">Contact Us</a> 
    with any questions or comments.
    <br>
    <a href="http://code.google.com/p/strategies-wdk/" target="_blank"
    ><img width="120" border="0" src="<c:url value='/wdk/images/stratWDKlogo.png'/>"></a>
  </div>

  <div id="member-sites">
	<a href="http://www.eupathdb.org"><br><img src="<c:url value='wdkCustomization/images/eupathdblink.png'/>" alt="Link to EuPathDB homepage"/></a>&nbsp;&nbsp;
	<a href="http://amoebadb.org"><img border=0 src="<c:url value='wdkCustomization/images/amoebadb_w30.png'/>"              ></a>&nbsp;
	<a href="http://cryptodb.org"><img border=0 src="<c:url value='wdkCustomization/images/cryptodb_w50.png'/>"     	width=30></a>&nbsp;
	<a href="http://giardiadb.org"><img border=0 src="<c:url value='wdkCustomization/images/giardiadb_w50.png'/>"  	width=30></a>&nbsp;&nbsp;
       	<a href="http://microsporidiadb.org"><img border=0 src="<c:url value='wdkCustomization/images/microdb_w30.png'/>"  ></a>&nbsp;&nbsp;
       	<a href="http://plasmodb.org"><img border=0 src="<c:url value='wdkCustomization/images/plasmodb_w50.png'/>"     width=30></a>&nbsp;&nbsp;
       	<a href="http://toxodb.org"><img border=0 src="<c:url value='wdkCustomization/images/toxodb_w50.png'/>"         width=30></a>&nbsp;&nbsp;
       	<a href="http://trichdb.org"><img border=0 src="<c:url value='wdkCustomization/images/trichdb_w65.png'/>"       height=30></a>&nbsp;&nbsp;
       	<a href="http://tritrypdb.org"><img border=0 src="<c:url value='wdkCustomization/images/tritrypdb_w40.png'/>"	width=25></a>
  </div>
</div>

</body>
</html>
