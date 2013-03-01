<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:fmt="http://java.sun.com/jsp/jstl/fmt">

  <jsp:directive.attribute name="refer" required="false" 
              description="Page calling this tag"/>

  <c:set var="siteName" value="${applicationScope.wdkModel.name}"/>
  <c:set var="version" value="${applicationScope.wdkModel.version}"/>
  <fmt:setLocale value="en-US"/> <!-- req. for date parsing when client browser (e.g. curl) does not send locale -->
  <fmt:parseDate  var="releaseDate" value="${applicationScope.wdkModel.releaseDate}" pattern="dd MMMM yyyy HH:mm"/> 
  <fmt:formatDate var="releaseDate_formatted" value="${releaseDate}" pattern="d MMM yy"/>
  <fmt:formatDate var="copyrightYear" value="${releaseDate}" pattern="yyyy"/>

  <div id="footer">
    <div id="copyright">
      <a href="http://${fn:toLowerCase(siteName)}.org">${siteName}</a>
      ${version}<span style="margin-left: 20px">${releaseDate_formatted}</span><br/>
      <span style="margin-left:4px;">&amp;copy;${copyrightYear} The EuPathDB Project Team</span>
    </div>
  
    <div id="contact">
      Please <a href="${pageContext.request.contextPath}/contact.do" class="open-window-contact-us">Contact Us</a> 
      with any questions or comments.
      <br/>
      <a href="http://code.google.com/p/strategies-wdk/" target="_blank">
        <img width="120" border="0" src="${pageContext.request.contextPath}/wdk/images/stratWDKlogo.png"/>
      </a>
    </div>
  
    <div id="member-sites">
      <a href="http://www.eupathdb.org"><br/><img src="${pageContext.request.contextPath}/wdkCustomization/images/eupathdblink.png" alt="Link to EuPathDB homepage"/></a>&#160;&#160;
      <a href="http://amoebadb.org"><img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/amoebadb_w30.png" width="30"/></a>&#160;
      <a href="http://cryptodb.org"><img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/cryptodb_w50.png" width="30"/></a>&#160;
      <a href="http://giardiadb.org"><img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/giardiadb_w50.png" width="30"/></a>&#160;&#160;
      <a href="http://microsporidiadb.org"><img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/microdb_w30.png" width="30"/></a>&#160;&#160;
      <a href="http://plasmodb.org"><img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/plasmodb_w50.png" width="30"/></a>&#160;&#160;
      <a href="http://toxodb.org"><img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/toxodb_w50.png" width="30"/></a>&#160;&#160;
      <a href="http://trichdb.org"><img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/trichdb_w65.png" height="30"/></a>&#160;&#160;
      <a href="http://tritrypdb.org"><img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/tritrypdb_w40.png" width="25"/></a>&#160;&#160;&#160;
      <a href="http://orthomcl.org"><img border="0" src="/assets/images/OrthoMCL/Ortho-3D-lighter-50.png" width="35"/></a>
    </div>
  </div>

</jsp:root>
