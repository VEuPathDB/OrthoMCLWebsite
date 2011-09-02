<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>
<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>

<!-- get wdkModel saved in application scope -->
<c:set var="wdkModel" value="${applicationScope.wdkModel}"/>

<!-- get wdkModel name to display as page header -->
<c:set value="${wdkModel.displayName}" var="wdkModelDispName"/>
<site:header title="OrthoMCL" refer="home" />

<div id="main-content">
  <site:sidebar />

  <!-- display wdkModel introduction text -->
  <div id="site-intro">${wdkModel.introduction}</div>
  <hr>

  <div id="search-bubbles">
    <wdk:searchCategories />
  </div>
</div> <!-- end of DIV main-content -->

<site:footer/>
