<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>

<script language="javascript" tpye="text/javascript">

var url = "getCityState.jsp?zip="; // The server-side script

function handleHttpResponse() {
    if (http.readyState == 4) {
        if (http.responseText.indexOf('invalid') == -1) {
            // Use the XML DOM to unpack the city and state data
            var xmlDoc = http.responseXML;
            var city = xmlDoc.getElementsByTagName('city').item(0).firstChild.data;
            var state = xmlDoc.getElementsByTagName('state').item(0).firstChild.data;
            document.getElementById('city').value = city;
            document.getElementById('state').value = state;
            document.getElementById('errMsg').lastChild.nodeValue = '';
        } else {
            var zipValue = document.getElementById("zip").value;
            document.getElementById('city').value = ""; 
            document.getElementById('state').value = "";
            document.getElementById('errMsg').lastChild.nodeValue =
                'zip code ' + zipValue + ' not found';
        }
        isWorking = false;
    }
}

var isWorking = false;

function updateCityState() {
    if (!isWorking && http) {
        var zipValue = document.getElementById("zip").value;
        http.open("GET", url + escape(zipValue), true);
        http.onreadystatechange = handleHttpResponse;
        isWorking = true;
        http.send(null);
    }
    isWorking = false;
}

function getHTTPObject() {
    var xmlhttp;
    /*@cc_on
    @if (@_jscript_version >= 5)
        try {
            xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (E) {
                xmlhttp = false;
            }
        }
    @else
        xmlhttp = false;
    @end @*/

    if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
        try {
            xmlhttp = new XMLHttpRequest();
        } catch (e) {
            xmlhttp = false;
        }
    }
    return xmlhttp;
}

var http = getHTTPObject(); // We create the HTTP Object

</script>

</head>

<form action="post">
  <p>
     ZIP code: <input type="text" name="zip" id="zip" size="5" onblur="updateCityState();">
  </p>

  City: <input type="text" name="city" id="city" size="24">

  State: <input type="text" name="state" id="state" size="2">

</form>

  <br>
  <font color="red"><div id="errMsg">&nbsp;</div></font>
