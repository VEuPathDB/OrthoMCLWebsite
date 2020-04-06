<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <imp:pageFrame refer="proteome" title="Upload your own Proteome" bufferContent="true">


<!--

    <div class="prot-upload">
      <c:choose>
        <c:when test="${requestScope.isServiceAvailable}">
  
          <script type="text/javascript" src="${pageContext.request.contextPath}/wdk/js/lib/jquery.form.js"><jsp:text /></script>
          <script type="text/javascript" src="${pageContext.request.contextPath}/wdkCustomization/js/proteome.js"><jsp:text /></script>
      

      
          <div id="proteome-result" style="display:none;"><jsp:text/></div>
      
          <h2 align="center">Assign your proteins to OrthoMCL Groups</h2>
          <p>
            Use this tool to provisionally assign the proteins in a genome to
            OrthoMCL Groups.  Upload your genome's proteins as a FASTA file.
          </p>
          <p>
            <i>Once a job starts</i>, it typically takes between 6 to 24 hours to complete, depending on system load and the size of your proteome.
          </p>
          <p>
           However, there is usually a queue, so <i>your job might not start for a few days</i>.  
          </p>
	  <p>Also, this service has occasional delays and/or down time that are beyond our control. <b>Currently these delays are extreme and jobs are taking weeks to complete.</b>  We are working to replace the current system with a more robust, user controllable system which will likely come online in October.  Until then, please wait at least a week before contacting us.  We apologize for this inconvenience.
          </p>
          <p>
          If you have not gotten results after a week, please feel free to contact us.  <b>We cannot answer any questions without your job ID.</b>
	  </p>
          <p>Please <b>do not resubmit your job</b> without first contacting us.  Doing so will slow everything down.</p>

          <div id="upload-form">
            <form id="proteome" action="/cgi-bin/orthomclProteomeSvcUpload.cgi" method="post" enctype="multipart/form-data">
              <input type="hidden" name="result_url_base" value="${requestScope.resultBaseUrl}"/>
              <table>
                <tr>
                  <td>Sequence file to Upload: </td>
                  <td><input id="seq_file" type="file" name="seq_file" required="true"/></td>
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
                  <td colspan="2" align="center"><input type="submit" name="Submit" value="Upload"/></td>
                </tr>
              </table>
            </form>
          </div>
          <br/>
          <h3>Details</h3>
          <p>
            <strong>Input:</strong> Your proteins in FASTA format.
          </p>
          <p>
            <strong>Output:</strong> A .zip file containing the following text files:
          </p>

<div class="indent3"><pre>
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
</pre></div>
          <p><strong>Documentation:</strong></p>
          <p>
            Instructions on how to use this service are freely available in
            <a href="http://onlinelibrary.wiley.com/doi/10.1002/0471250953.bi0612s35/full">
            Unit 6.12 of the Current Protocols of Bioinformatics.</a>
          </p>
          <p><strong>Algorithm</strong></p>
          <p>
            Please refer to the <a href="https://docs.google.com/document/d/1RB-SqCjBmcpNq-YbOYdFxotHGuU7RK_wqxqDAMjyP_w/pub">
            OrthoMCL Algorithm Document</a> for details about how OrthoMCL-DB is created.
            <ul>
              <li>BLASTP of your proteins against self and against OrthoMCL proteins.  Cutoff of e-5, and 50% match.</li>
              <li>For proteins that have an above-threshold match: assign the group from the best matching OrthoMCL protein.  If the best OrthoMCL protein does not have a group, assign NO_GROUP.</li>
              <li>For remaining proteins: use the InParalog algorithm described in the <a href="https://docs.google.com/document/d/1RB-SqCjBmcpNq-YbOYdFxotHGuU7RK_wqxqDAMjyP_w/pub">OrthoMCL Algorithm Document</a> to find potential paralog pairs.</li>
              <li>Submit those pairs to the <a href="http://www.micans.org/mcl/">MCL</a> program (see the <a href="https://docs.google.com/document/d/1RB-SqCjBmcpNq-YbOYdFxotHGuU7RK_wqxqDAMjyP_w/pub">OrthoMCL Algorithm Document</a>).</li>
            </ul>
          </p>
      

        
        </c:when>
        <c:otherwise>
          <h2>Service Not Available</h2>
          <p>
            The proteome upload service is not currently available.  A new and improved service will be released in the coming weeks.  Any jobs already submitted will be processed as normal, and you will recieve email when they complete.  Currently submitted jobs are delayed, and taking weeks to complete.  We apologize for this inconvenience.
          </p>
          <p>
          If you have not gotten results after a week, please feel free to contact us.  <b>We cannot answer any questions without your job ID.</b>
	  </p>
        </c:otherwise>
      </c:choose>
    </div>

-->
<style>

div.prot-upload {
  width:80%;
  line-height: 2;
 
}
div.prot-upload h2 {
 font-size: 300%;
}

div.prot-upload p, div.prot-upload ol li {
  font-size: 140%
}

div.prot-upload ol {
  width: 80%;
  margin-left: auto;
  margin-right: auto;
}

</style>
 
<div class="prot-upload">
<h2>Map your proteins to OrthoMCL groups</h2>

<p>
If you have a .fasta file with a set of proteins, you can map the proteins to OG5 or OG6r1 Groups.
</p>

<p>
If your .fasta file contains the proteins from a single proteome, you can additionally find paralog groups for proteins that do not map to OrthoMCL Core or Residual Groups.
</p>

<p>
<i>First please log in as a VEuPathDB user.</i>
</p>

<p>
Once logged in, go to the <a href="http://veupathdb.globusgenomics.org">VEuPathDB Galaxy server</a>:
</p>
<ol style="width:85%">
<li>Use the <b>Get Data</b> tool (in the left panel at the top) to upload your .fasta file</li>
<li>On the Galaxy home page, click <b>Workflow to map your proteins to OrthoMCL groups</b>.</li>
<li>In the workflow settings, indicate (1) your .fasta file, (2) the OG5 or OG6r1 Blast database, and (3) OG5 or OG6r1 groups.</li>
<li>Run the workflow!</li>
</ol>

<p>
<b>Note:</b> The Galaxy workflow run may take 24 hours or more to complete, depending on the size of the job queue
</p>

</div>


  </imp:pageFrame>
</jsp:root>
