<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <jsp:directive.attribute name="title" required="true"
              description="Value to appear in page's title"/>
  <jsp:directive.attribute name="refer" required="false" 
              description="Page calling this tag"/>
  <jsp:directive.attribute name="headElement" required="false"
              description="additional head elements"/>
  <jsp:directive.attribute name="bufferContent" required="false"
              description="whether to create margin, border, padding around main div"/>

  <c:set var="project" value="${applicationScope.wdkModel.displayName}"/>
  <c:set var="mainContentClass" value="${bufferContent eq 'true' ? 'buffered-content' : '' }"/>

  <!-- jsp:output tag for doctype no longer supports simple HTML5 declaration -->
  <jsp:text>&lt;!DOCTYPE html&gt;</jsp:text>
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      ${headElement}
      
      <title>
        <c:out value="${title}" default="WDK ${project}"/>
      </title>
  
      <!-- for IE and other browsers -->
      <link rel="icon" type="image/png" href="/assets/images/${project}/favicon.ico"/>
      <link rel="shortcut icon" href="/assets/images/${project}/favicon.ico"/>
      
      <imp:stylesheets refer="${refer}"/>
      <imp:javascripts refer="${refer}"/>
    </head>
  
    <body>
      <!-- helper divs with generic information used by javascript -->
      <imp:siteInfo/>

      <imp:header refer="${refer}"/>
      <imp:menubar refer="${refer}"/>

			<c:if test="${refer == 'home' or refer == 'home2' }">
				<imp:sidebar/>
			</c:if>
		
      <div id="main-content" class="${mainContentClass}">
        <jsp:doBody/>
      </div>

      <imp:dialogs/>
      <imp:footer refer="${refer}"/>

    </body>
  </html>
</jsp:root>
