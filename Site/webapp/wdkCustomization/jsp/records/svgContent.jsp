<%@ page contentType="image/svg+xml" %><?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xmlns="http://www.w3.org/2000/svg" version="1.1"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     height="700" width="1000"
     onload="initSvg()">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>

<c:set var="svgContent" value="${requestScope.svgContent}" />

  <defs>
    <style type="text/css"><![CDATA[
#info1, #info2, #info3, #info4 {fill: blue;}
#info1, #info2 {font-weight: bold;}
line {stroke-width: 2;}
circle {stroke-width: 1; stroke: black;}
text {font-size: 11px;}
#Ortholog line, #control .Ortholog {stroke: red;}
#Coortholog line, #control .Coortholog {stroke: yellow;}
#Inparalog line, #control .Inparalog {stroke: #33FF33;}
#Normal line, #control .Normal {stroke: #555555;}
#control rect {fill: #EEEEEE;}
    ]]></style>
  </defs>

    <script xlink:href="<c:url value='/wdk/js/lib/jquery-1.6.4.min.js'/>" type="application/ecmascript"></script>
    <script xlink:href="<c:url value='/wdkCustomization/js/svg.js'/>" type="application/ecmascript"></script>


    <rect x="0" y="0" width="800" height="90" fill="rgb(220,220,220)"/>
    <text id="text_info" x="10" y="20"> EDGE/NODE INFORMATION </text>
    <text id="info1" x="20" y="40"> </text>
    <text id="info2" x="410" y="40"> </text>
    <text id="info3" x="20" y="60"> </text>
    <text id="info4" x="410" y="60"> </text>

    <g id="control">
        <rect class="Ortholog"   x="70"  y="69" width="110" height="15"/>
        <rect class="Coortholog" x="190" y="69" width="120" height="15"/>
        <rect class="Inparalog"  x="320" y="69" width="110" height="15"/>
        <rect class="Normal"     x="440" y="69" width="130" height="15"/>
        <rect class="All"        x="580" y="69" width="80" height="15"/>

        <text x="10" y="80">
            CLICK TO:
            <tspan x="75"  y="80" id="Ortholog_switch">Hide Ortholog Edges</tspan>
            <tspan x="195" y="80" id="Coortholog_switch">Hide Coortholog Edges</tspan>
            <tspan x="325" y="80" id="Inparalog_switch">Hide Inparalog Edges</tspan>
            <tspan x="445" y="80" id="Normal_switch">Hide Other Similar Edges</tspan>
            <tspan x="585" y="80" id="All_switch">Hide All Edges</tspan>
        </text>
    </g>

    <rect x="800" y="0" width="200" height="700" fill="rgb(200,200,150)"/>
    <text x="855" y="20" style="font-size: 12px"> TAXON LEGEND </text>
    <g id="legend"></g>

    <rect x="0" y="90" width="800" height="690" fill="rgb(240,240,240)"/>
    <g id="All">
        ${svgContent}
    </g>

</svg>
