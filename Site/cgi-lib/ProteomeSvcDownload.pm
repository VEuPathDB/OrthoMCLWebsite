package ProteomeSvcDownload;

# given a job id as the path_info portion of the uri, return
# the associated zip file for download.
#
# http://orthomcl.org/cgi-bin/orthomclresult/a090934jf0
#
# Configuration file needs
#   resultsDir = /var/www/Common/tmp/orthomclProteomeJob/results
#   resultfilePrefix = orthomclResult-
#   purgeWindow = 7



use strict;
use base 'CGI::Application';
use CGI qw(-oldstyle_urls); # see Note 1

my $svc_cfg_file = ($ENV{DOCUMENT_ROOT} . "/../cgi-lib/svc.config");

my $q;
my %para;
my %svc_cfg;
my $job_id;
my $self_url;
my $resultfile_basename;
my $full_resultfile_path;
my $tmpl;

sub cgiapp_init {
    my ($self) = @_;
    
    load_svc_configuration();
    $q = $self->query();
    
    $job_id = $q->path_info();
    $job_id =~ s;[^A-Za-z0-9];;g;
    $resultfile_basename =  $svc_cfg{'resultfilePrefix'} . $job_id . '.zip';
    $full_resultfile_path = $svc_cfg{'resultsDir'} . '/' . $resultfile_basename ;
    $self_url = $q->self_url;

}

sub setup {
    my $self = shift;
    $self->start_mode('message');
    $self->run_modes(
        'message' => 'message',
        'direct'  => 'direct',
        'AUTOLOAD'=> \&unknown,
    );
    $self->tmpl_path($ENV{DOCUMENT_ROOT} . '/../cgi-bin/tmpl');

    $tmpl = $self->load_tmpl("proteome_svc_download.tmpl");

    $tmpl->param(JOB_ID => $job_id);
    $tmpl->param(BASEHREF => 'http://' . $ENV{SERVER_NAME});
    $tmpl->param(PAGETITLE => "OrthoMCL Database") unless $tmpl->param("PAGETITLE");
}

sub message {
    my ($self) = @_;

    if (! -f $full_resultfile_path) {
        $tmpl->param(PURGE_WINDOW => $svc_cfg{'purgeWindow'});
        $tmpl->param(NOTFOUND => 1);
    } else {
        $q->append(-name=>'rm',-values=>'direct');
        my $ddl_url = $q->self_url;
        $tmpl->param(DIRECT_DL_LINK => $ddl_url);
    }

    return $tmpl->output;
}


sub direct {
    my ($self) = @_;
    my $buffer;
    my $output;
    my $download_size;

    if (! -f $full_resultfile_path) {
        return $self->message();    
    }

    $download_size = (stat($full_resultfile_path))[7]
         || die
            "Error: Failed to get file size for <b>$resultfile_basename<b>:<br>$!<br>";

    open(FILE, "<$full_resultfile_path") || 
        die "Error reading result file. Please contact us and reference job number ";
    binmode FILE;

    while (read(FILE, $buffer, 1024)) {
       $output .= $buffer;
    }

    close FILE;
    
    $self->header_props(
        -type=>'application/zip',
        '-Content-Disposition' => 'attachment; filename="' . $resultfile_basename . '"',
        '-content_length'      => $download_size,
    );
    
    
    return $output;
}

sub unknown {
    my ($self) = @_;
    $tmpl->param(UNKNOWN_REQUEST => 1);
    $tmpl->param(RM => 'rm=' . $q->param('rm'));
    return $tmpl->output;    
}



sub load_svc_configuration {
    open(C, $svc_cfg_file) or die "Can not find configuration file\n";
    while(<C>) {
        chomp;
        s/#.*//;
        s/^\s+//;
        s/\s+$//;
        next unless length;
        my ($k, $v) = split(/\s*=\s*/, $_, 2);
        $svc_cfg{$k} = $v;
    }
}
1;



__END__

Note 1. When we append a 'rm=direct' parameter for the direct download link
and for the META refresh tag, the default CGI behavior is to use a semicolon 
separator. Some browsers (can you guess from which sack o' shit vendor?) don't 
understand semicolon separators in a META refresh context. 

So we use the -oldstyle_urls pragma to force ampersand separators. Generally 
none of this should be an issue since there will normally be only the one 
rm=direct parameter, but on password protected development sites which may 
include an authorization token  in the url, there can be be > 1 parameter.

/svcdl/a090934jf0?auth_tkt=ZTljZDdY3Y2FwaWRiIWFwaWRiITEyNTMxNjg&rm=direct