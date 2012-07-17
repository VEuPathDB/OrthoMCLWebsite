<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="siteName" value="${applicationScope.wdkModel.name}" />

<div class="contact-us">
  <p>We are available to help with <b>Questions</b>, <b>Error reports</b>,
    <b>Feature requests</b>, <b>Dataset proposals</b>, etc. &nbsp;&nbsp;
    Please include (but all are optional):</p>
  
  <div class="cirbulletlist">
    <ul>
      <li>Your email, so we can respond.</li>
      <li>If you are describing a problem, <i>details</i> of how the problem occured, including:</li>
      <ul>
        <li>The URL of the offending page</li>
        <li><i>Exact</i> steps to recreate the problem. If possible, please
          try to recreate the problem yourself so you can give us an exact recipe.</li>
        <li>The full error message, if any.</li>
      </ul>
    </ul>
  </div>
  <table>
  <form id="contact-us" method="post" action="contactUs.do">
  
    <tr><td><div class="bold">Subject:</div></td>
        <td><input type="text" name="subject" size="81"></td></tr>
  
    <tr><td><div class="bold">Your email address:</div></td>
        <td><input type="text" name="reply" size="81"></td></tr>
  
    <tr><td><div class="bold">Cc addresses:</div></td>
        <td><input type="text" name="addCc" value="" size="81"></td></tr>
    <tr><td></td><td><i>(maximum 10 Cc addresses, comma separated.)</i></td</tr>
  
    <tr><td valign="top"><div class="bold">Message:</div></td>
        <td><textarea name="content" cols="75" rows="8"></textarea>
            <input type="hidden" name="reporterEmail" value="websitesupportform@apidb.org"/></td></tr>
    <tr><td>&nbsp;</td>
        <td align="left"><input type="submit" value="Submit"></td></tr>
  </form>
  </table>
  <div><b>If you would like to attach a screenshot, please email directly to <a href="mailto:help@${siteName}.org">help@${siteName}.org</a>.</b></div>
</div>
