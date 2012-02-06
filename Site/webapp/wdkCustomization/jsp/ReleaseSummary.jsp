<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.servletsuite.com/servlets/wraptag" %>


<!-- display page header with recordClass type in banner -->
<imp:header refer="data-source" title="Release Summary" />


<imp:wdkTable tblName="ReleaseSummary" isOpen="true" />


<imp:footer/>
