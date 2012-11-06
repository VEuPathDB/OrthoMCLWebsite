package ProteomeSvcUpload;


use strict;
use base 'CGI::Application';
use CGI;
use CGI::Application::Plugin::Session;
use HTML::Template;
use File::Spec ();
use YAML qw(LoadFile);
use Time::HiRes qw( clock_gettime CLOCK_REALTIME );

my $startTime = clock_gettime(CLOCK_REALTIME);

my $SERVER_CONFIG_FILE = "$ENV{GUS_HOME}/config/orthomclProteomeSvcServer.prop";
my $CLUSTER_CONFIG_FILE = "$ENV{GUS_HOME}/config/orthomclProteomeSvcCluster.prop";

sub cgiapp_init {
  my $self = shift;

  # Timing info
  my $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin cgiapp_init(): " . ($currentTime - $startTime) . ".\n";
}


sub setup {
  my $self = shift;

  # Timing info
  my $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin setup(): " . ($currentTime - $startTime) . ".\n";

  $self->start_mode('proteomeUploadForm');
  $self->run_modes([qw(proteomeUploadForm)]);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End setup(): " . ($currentTime - $startTime) . ".\n";
}


sub proteomeUploadForm {
  my $self = shift;

  # Timing info
  my $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin cgiapp_init(): " . ($currentTime - $startTime) . ".\n";

  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin proteomeQuery(): " . ($currentTime - $startTime) . ".\n";

  my $q = $self->query();
  my $file_name = $q->param("seq_file");
  my $email = $q->param("email");
  my $job_name = $q->param("job_name");
  my $result_base_url = $q->param("result_url_base");

  if ( !$file_name ) {
    print $q->header ( );
    print "There was a problem uploading your sequence file (try a smaller file).";
    exit;
  }

  my $job_dir = $self->getConfig('serverControlDir');
  my $job_id = getNewJobId($job_dir);

  my $result_url = $result_base_url . $job_id;
  my $upload_dir = $job_dir . "/newJobs/" . $job_id;

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
  print INFOFILE "resultUrl=$result_url\n";
  close INFOFILE;

  my $templateText = getTmplText();
  my $tmpl =  HTML::Template->new(scalarref => \$templateText);

  $tmpl->param(EMAIL => $email);
  $tmpl->param(FILE_NAME => $file_name);
  $tmpl->param(JOB_NAME => $job_name);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End proteomeQuery(): " . ($currentTime - $startTime) . ".\n";

  umask $old_umask;
  return $tmpl->output;
}

sub getNewJobId {
  my ($job_dir) = @_;
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
  <div class="prot-upload">
    <h3>Proteins Submitted</h3>
    <p>You will receive an email soon indicating that the job has been submitted to the queue.</p>
    <p>You will receive another email in many hours when the job is complete.</p>
    <ul>
      <TMPL_IF JOB_NAME><li>Job name: <strong><code><TMPL_VAR JOB_NAME></code></strong></li></TMPL_IF>
      <li>Sequence file uploaded: <strong><code><TMPL_VAR FILE_NAME></code></strong></li>
      <li>Email: <strong><code><TMPL_VAR EMAIL></code></strong></li>
    </ul>
    <p>Thanks for submitting your proteins!</p>
  </div>
<!-- END CONTENT -->

EOF
  return $text;
}

sub getConfig {
  my ($self, $tag) = @_;

  if (!$self->{config}) {
    $self->readConfigFile($SERVER_CONFIG_FILE);
    $self->readConfigFile($CLUSTER_CONFIG_FILE);
  }
  die ("Config files do not have a property '$tag'\n") unless defined($self->{config}->{$tag});
  return $self->{config}->{$tag};
}

sub readConfigFile {
  my ($self, $file) = @_;

  open(F, $file) || die("Can't open config file '$file'\n");

  while (<F>) {
    chomp;
    s/\s+$//;
    next if /^\#/ or /^$/;
    /^(\w+)\=(.+)/ || die "illegal line '$_' in config file '$file'\n";
    my $key=$1;
    my $val=$2;
    $self->{config}->{$key} = $val;
  }

}


1;
