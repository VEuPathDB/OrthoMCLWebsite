#!/usr/bin/perl -w

use strict;
use base 'CGI::Application';
use CGI;
use CGI::Application::Plugin::Session;
use HTML::Template;
use File::Spec ();
use YAML qw(LoadFile);

sub cgiapp_init {
  my $self = shift;

  # Timing info
  my $startTime = clock_gettime(CLOCK_REALTIME);
  my $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin cgiapp_init(): " . ($currentTime - $startTime) . ".\n";

  my $q = $self->query();
  my $config = LoadFile("$ENV{GUS_HOME}/config/orthomclMappingSvc.yaml");
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin proteomeQuery(): " . ($currentTime - $startTime) . ".\n";

  my $q = $self->query();
  my $file_name = $q->param("seq_file");
  my $email = $q->param("email");
  my $job_name = $q->param("job_name");

  if ( !$file_name ) {
    print $q->header ( );
    print "There was a problem uploading your sequence file (try a smaller file).";
    exit;
  }

  my $job_dir = $config->{proteome_job_dir};
  my $job_id = getNewJobId();

  my $upload_dir = $job_dir . "/" . $job_id;

  #print STDERR "making job dir: " . $upload_dir . "\n";

  my $old_umask = umask 0;
  mkdir $upload_dir;
  die ("Could not make job dir '$upload_dir': $!\n") unless -d $upload_dir;

  # upload sequence file
  my $seq_file_handle = $q->upload("seq_file");
  open ( UPLOADFILE, ">$upload_dir/orig_proteome.fasta" ) or die "Can't open file '$upload_dir/orig_proteome.fasta' for writing\n$!";
  binmode UPLOADFILE;

  while ( <$seq_file_handle> ) {
    print UPLOADFILE;
  }
  close UPLOADFILE;

  # create info file
  open ( INFOFILE, ">$upload_dir/info.txt" ) or die "$!";
  print INFOFILE "email=$email\n";
  print INFOFILE "fastaFileName=$file_name\n";
  print INFOFILE "submitted=" . localtime() . "\n";
  print INFOFILE "jobName=$job_name\n";
  print INFOFILE "jobId=$job_id\n";
  close INFOFILE;

  my $tmpl =  HTML::Template->new(getTmplText());
  $self->defaults($tmpl);

  $tmpl->param(PAGETITLE => "Your Proteome sequence is uploaded");
  $tmpl->param(RESULT => 1);
  $tmpl->param(EMAIL => $email);
  $tmpl->param(FILE_NAME => $file_name);
  $tmpl->param(JOB_NAME => $job_name);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End proteomeQuery(): " . ($currentTime - $startTime) . ".\n";

  umask $old_umask;
  return $self->done($tmpl);
}

sub getNewJobId {
  # create a random job ID (that is not already in use)
  my $job_id;
  srand(); # re-seed because apache using mod_perl hands out stale seeds
  while (1) {
    $job_id = '';
    for (my $i = 0; $i < 12; $i++) {
      my $number = int(rand(36));
      my $digit = chr(($number < 10) ? $number + 48 : $number + 55); 
      $job_id = $job_id . $digit;
    }
    if (-d "$job_dir/$job_id") {
      ;
    } else {
      last;
    }
    ;
  }
  return $job_id;
}

sub getTmplText {
  my $text = <<EOF;
<!-- BEGIN CONTENT -->

<TMPL_IF UPLOAD>

<TMPL_INCLUDE header.tmpl>

<script type="text/javascript" src="/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="/js/proteome.js"></script>



<h3 align="center">Assign your proteins to OrthoMCL Groups</h3>

Use this tool to provisionally assign the proteins in a genome to OrthoMCL Groups.  Upload your genome's proteins as a FASTA file.  

<TMPL_IF UPLOAD_IS_OFFLINE>
<h2 class='notice'>This tool is temporarily unavailable.</h2>
<TMPL_ELSE>
<br><br>The process takes between 6 to 72 hours depending upon server load.  
<br><br>
<form id="upload_form" action="/cgi-bin/OrthoMclWeb.cgi" method="post"  
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
</TMPL_IF>
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


<TMPL_INCLUDE footer.tmpl>

</TMPL_IF> <!-- end of UPLOAD -->

<TMPL_IF RESULT>

  <h3 align="center">Proteins Submitted</h3>
  <TMPL_IF JOB_NAME><p>Job name: <b><TMPL_VAR JOB_NAME></b></p></TMPL_IF>
  <p>Your proteins sequence file <TMPL_VAR FILE_NAME> has been uploaded. You will receive an email soon at <TMPL_VAR EMAIL> indicating that the job has been submitted to the queue.  You will receive another email in many hours when the job is complete.  
<p>
Thanks for submitting your proteins.
 
</TMPL_IF> <!-- end of RESULT -->


<!-- END CONTENT -->

EOF
  return $text;
}
