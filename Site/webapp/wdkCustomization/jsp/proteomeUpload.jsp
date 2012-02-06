<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.servletsuite.com/servlets/wraptag" %>


<imp:header refer="proteome" title="Upload your own Proteome" />

<script type="text/javascript" src="<c:url value='wdk/js/lib/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/wdkCustomization/js/proteome.js'/>"></script>

<!-- BEGIN CONTENT -->

<div id="proteome-result" style="display:none;"></div>

<h3 align="center">Assign your proteins to OrthoMCL Groups</h3>

Use this tool to provisionally assign the proteins in a genome to OrthoMCL Groups.  Upload your genome's proteins as a FASTA file.  

<br><br>The process takes between 6 to 24 hours depending upon server load.  
<br><br>
<form id="proteome" action="/cgi-bin/OrthoMclWeb.cgi" method="post"  
      enctype="multipart/form-data">
  <input type="hidden" name="rm" value="proteomeQuery">
  <table align="center">
    <tr>
      <td>Sequence file to Upload: </td>
      <td><input id="seq_file" type="file" name="seq_file" required="true" /></td>
    </tr>
    <tr>
      <td>Your Email Address: </td>
      <td><input id="email" type="text" name="email" required="true" size="33" maxlength="255"/></td>
    </tr>
    <tr>
      <td>Job Name(optional): </td>
      <td><input id="job_name" type="text" name="job_name" size="33" maxlength="100"/></td>
    </tr>

    <tr>
      <td colspan="2" align="center"><input type="submit" name="Submit" value="Upload" /></td>
    </tr>
  </table>
</form> 
<br><br>
<h3>Details</h3>
<b>Input:</b> Your proteins in FASTA format.
<p>
<b>Output:</b> A .zip file containing the following text files:
<p>
<pre>
orthomclResults/
  orthologGroups    # a map between your proteins and OrthoMCL groups. Tab 
                      delimited.  Columns: your_protein, orthomcl_group, 
                      seq_id_of_best_hit, evalue_mantissa, evalue_exponent,
                      percent_identity, percent_match
  paralogPairs      # reciprocal best hits among those proteins in your genome
                    # that were not mapped to OrthoMCL groups, as described
                    # below in the Algorithms section
  paralogGroups     # the proteins in paralogPairs clustered into groups by
                    # the mcl program, as described below in the Algorithms
                    # section
</pre>
<br><br>
<b>Algorithm</b>
<p>
Please refer to the <a href="http://docs.google.com/View?id=dd996jxg_1gsqsp6">OrthoMCL Algorithm Document</a> for details about how OrthoMCL-DB is created.
<ul>
<li>BLASTP of your proteins against self and against OrthoMCL proteins.  Cutoff of e-5, and 50% match. 
<li>For proteins that have an above-threshold match: assign the group from the best matching OrthoMCL protein.  If the best OrthoMCL protein does not have a group, assign NO_GROUP.
<li>For remaining proteins: use the InParalog algorithm described in the <a href="http://docs.google.com/View?id=dd996jxg_1gsqsp6">OrthoMCL Algorithm Document</a> to find potential paralog pairs.  
<li>Submit those pairs to the <a href="http://www.micans.org/mcl/">MCL</a> program (see the <a href="http://docs.google.com/View?id=dd996jxg_1gsqsp6">OrthoMCL Algorithm Document</a>).

<!-- END CONTENT -->

<imp:footer />
