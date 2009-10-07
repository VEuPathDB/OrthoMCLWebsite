package OrthoMclWeb;

use strict;

BEGIN {
  $ENV{PATH} = "";
}

use lib "@targetDir@/lib/perl";
$ENV{GUS_HOME} = '@targetDir@';
my $oracleHome = $ENV{ORACLE_HOME};
if (!$oracleHome) {
  $ENV{ORACLE_HOME} = '@oracleHome@';
}

use base 'CGI::Application';
use DBI;		     # Needed for OrthoMCL database connection
use CGI;
use CGI::Application::Plugin::DBH qw(dbh_config dbh dbh_default_name);
use CGI::Application::Plugin::Session;
use File::Spec ();
use YAML qw(LoadFile);
use OrthoMCLShared::Ppe::MatrixColumnManager;
use OrthoMCLWebsite::Model::Ppe::Processor;
use ApiCommonWebsite::Model::SqlXmlParser;
use FunKeyword;
use GD;
use Data::Dumper;
use Time::HiRes qw( clock_gettime CLOCK_REALTIME );
use File::Basename;

my $startTime = clock_gettime(CLOCK_REALTIME);
my $currentTime;

my $debug=0;
our $config;
our $VERSION = '3';

sub cgiapp_init {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin cgiapp_init(): " . ($currentTime - $startTime) . ".\n";    

  my $q = $self->query();
  my $mode = $q->param("rm");

  if (!$mode || index($mode,"draw") < 0) {
    $config = LoadFile("@cgilibTargetDir@/config.yaml");
    $self->param(config => $config);
    
    $self->dbh_config('orthomcl', 
		      [ $config->{database}, 
			$config->{user}, 
			$config->{password},
			{ RaiseError => 1, PrintWarn => 0, PrintError => 0 }
		      ]);
    $self->dbh_default_name("orthomcl");
    $self->dbh()->{LongTruncOk} = 0;
    $self->dbh()->{LongReadLen} = 100000000;
    
    # Configure the session
    #$self->session_config(
    #   CGI_SESSION_OPTIONS => [ "driver:Oracle", $self->query, {Handle=>$self->dbh()} ],
    #   SEND_COOKIE         => 1,
    #);
    $self->session_config(
			  CGI_SESSION_OPTIONS => [ "driver:File",
						   $self->query,
						   { Directory=>File::Spec->tmpdir } ],
			  SEND_COOKIE         => 1,
			 );
  }

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End cgiapp_init(): " . ($currentTime - $startTime) . ".\n";    
}    

sub setup {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin setup(): " . ($currentTime - $startTime) . ".\n";    

  $self->tmpl_path('@cgibinTargetDir@/tmpl');
  $self->start_mode('indx');
  $self->run_modes([qw(indx
                 groupQueryForm sequenceQueryForm
                 groupList sequenceList
                 domarchList
                 sequence blast genome
                 groupQueryHistory sequenceQueryHistory
                 orthomcl drawScale drawDomain drawProtein
                 MSA BLGraph getSeq
                 querySave queryTransform
                 proteomeUploadForm proteomeQuery
                 edgeList)
		   ]);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End setup(): " . ($currentTime - $startTime) . ".\n";    
}

sub error {
  my $self = shift;
  my $tmpl = $self->load_tmpl("error.tmpl");
  $self->defaults($tmpl);
  return $self->done($tmpl);
}

sub indx {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin indx(): " . ($currentTime - $startTime) . ".\n";    

  my $dbh = $self->dbh();
  my $config = $self->param("config");
  my $tmpl = $self->load_tmpl("index.tmpl");
  $self->defaults($tmpl);

  my %para;
  $para{VERSION}=$VERSION;
  my @tmp;

  my $query_num_taxa = $dbh->prepare($self->getSql('all_taxa_count'));
  $query_num_taxa->execute();
  @tmp = $query_num_taxa->fetchrow_array();
  $para{NUM_TAXA}=$tmp[0];

  my $query_num_sequences = $dbh->prepare($self->getSql('all_sequences_count'));
  $query_num_sequences->execute();
  @tmp = $query_num_sequences->fetchrow_array();
  $para{NUM_SEQUENCES}=$tmp[0];

  my $query_num_groups = $dbh->prepare($self->getSql('all_groups_count'));
  $query_num_groups->execute();
  @tmp = $query_num_groups->fetchrow_array();
  $para{NUM_GROUPS}=$tmp[0];
  $para{PAGETITLE}="OrthoMCL Database Home";

  my $file=$config->{NEWS_file};
  if (-e $file) {
    open(F,$file);
    while (<F>) {
      $_=~s/\r|\n//g;
      my @parts = split(' : ', $_);
      push(@{$para{LOOP_NEWS}},{DATE=>$parts[0], NEWS=>$parts[1]});
    }
    close(F);
  }

  #$para{LEFTNAV}=1;
  $tmpl->param(\%para);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End indx(): " . ($currentTime - $startTime) . ".\n";    

  return $self->done($tmpl);
}

sub groupQueryForm {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin groupQueryForm(): " . ($currentTime - $startTime) . ".\n";    

  my $dbh = $self->dbh();
  my $q = $self->query();
  my $type=$q->param("type"); # query type: ppexpression, ppform, property

  my $tmpl = $self->load_tmpl("groupqueryform.tmpl");
  $self->defaults($tmpl);

  #    $tmpl->param(LEFTNAV => 1);

  if ($type eq 'ackeyword') {
    $tmpl->param(PAGETITLE => "Query OrthoMCL Groups By IDs / Keyword / PFam domain");
    $tmpl->param(ACKEYWORD => 1);
  } elsif ($type eq 'ppform') {
    $tmpl->param(PAGETITLE => "Query OrthoMCL Groups By Phyletic Pattern Form");
    $tmpl->param(PPFORM => 1);
        
    my $query_taxon = $dbh->prepare($self->getSql('all_taxa_info'));
    $query_taxon->execute();
    my %para;
    while (my @data = $query_taxon->fetchrow_array()) {
      push(@{$para{TAXONS}}, { TAXON_ID=>$data[0],
			       PARENT_ID=>$data[1],
			       ABBREV=>$data[2],
			       NAME=>$data[3], 
			       IS_SPECIES => $data[4],
			       INDEX => $data[5],
                               COMMON_NAME => $data[6] });
    }
    $tmpl->param(\%para);
  } elsif ($type eq 'property') {
    $tmpl->param(PAGETITLE => "Query OrthoMCL Groups By Group Properties");
    $tmpl->param(PROPERTY => 1);
  } else {
    $tmpl->param(PAGETITLE => "Query OrthoMCL Groups By PPE (Phyletic Pattern Expression)");
    $tmpl->param(PPEXPRESSION => 1);

    my %para;
    my $query_taxon = $dbh->prepare($self->getSql('all_taxa_info'));
    $query_taxon->execute();
    my $count_species=0;
    my $count_groups=0;
    my @prev_specie_data;
    my @prev_group_data;
    while (my @data = $query_taxon->fetchrow_array()) {
      if ($data[4]) {
        $count_species++;
      } else {
        $count_groups++;
      }
      if ($count_species==2) {	# which means every tr has two td
        push(@{$para{LOOP_TR}},{LOOP_TD=>[
					  {
					   ABBREV=>$prev_specie_data[2],NAME=>$prev_specie_data[3], COMMON_NAME => $prev_specie_data[6] },
					  {
					   ABBREV=>$data[2],NAME=>$data[3], COMMON_NAME => $data[6] }
					 ]});
        $count_species=0;
      } elsif ($count_groups==2) { # which means every tr has two td
        push(@{$para{LOOP_GROUPTR}},{LOOP_GROUPTD=>[
						    {
						     ABBREV=>$prev_group_data[2],NAME=>$prev_group_data[3], COMMON_NAME => $prev_group_data[6] },
						    {
						     ABBREV=>$data[2],NAME=>$data[3], COMMON_NAME => $data[6] }
						   ]});
        $count_groups=0;
      }
      if ($data[4]) {
        @prev_specie_data=@data;
      } else {
        @prev_group_data=@data;
      }
    }
    if ($count_species%2) {
      push(@{$para{LOOP_TR}},{LOOP_TD=>[
					{
					 ABBREV=>$prev_specie_data[2],NAME=>$prev_specie_data[3], COMMON_NAME => $prev_specie_data[6] }
				       ]});
    }
    if ($count_groups%2) {
      push(@{$para{LOOP_GROUPTR}},{LOOP_GROUPTD=>[
						  {
						   ABBREV=>$prev_group_data[2],NAME=>$prev_group_data[3], COMMON_NAME => $prev_group_data[6] }
						 ]});
    }
    my $query_num_taxa = $dbh->prepare($self->getSql('all_taxa_count'));
    $query_num_taxa->execute();
    my ($numgenomes) = $query_num_taxa->fetchrow_array();

    $tmpl->param(NUMGENOMES => $numgenomes);
    $tmpl->param(\%para);
  }

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End groupQueryForm(): " . ($currentTime - $startTime) . ".\n";    

  return $self->done($tmpl);
}

sub sequenceQueryForm {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin sequenceQueryForm(): " . ($currentTime - $startTime) . ".\n";    

  my $q = $self->query();
  my $type=$q->param("type");	# query type: keyword or blast

  my $tmpl = $self->load_tmpl("sequencequeryform.tmpl");
  $self->defaults($tmpl);

  #    $tmpl->param(LEFTNAV => 1);

  if ($type eq 'blast') {
    $tmpl->param(PAGETITLE => "Query Protein Sequences By BLAST Search");
    $tmpl->param(BLAST => 1);
  } else {
    $tmpl->param(PAGETITLE => "Query Protein Sequences By IDs / Keyword / Taxon / PFam domain");
    $tmpl->param(ACKEYWORD => 1);
  }

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End sequenceQueryForm(): " . ($currentTime - $startTime) . ".\n";    

  return $self->done($tmpl);
}

sub querySave {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin querySave(): " . ($currentTime - $startTime) . ".\n";    

  my $dbh = $self->dbh();
  my $q = $self->query();
  my $file_content;
  if ((my $type=$q->param("type")) && (my $querynumber=$q->param("querynumber"))) {
    my $file_name = 'OrthoMCL-DB_'.$type.'_query_'.$querynumber.'.txt';
    $self->header_props(
			-type=>'text/plain',
			'-Content-Disposition'=>'attachment; filename="'.$file_name.'"');
    my $query_accession_string;
    my $query_ids_history;
    if ($type eq 'sequence') {
      $query_ids_history = $self->session->param("SEQUENCE_QUERY_IDS_HISTORY");
      $query_accession_string = $self->getSql('sequence_info_per_history_seq');
    } elsif ($type eq 'group') {
      $query_ids_history = $self->session->param("GROUP_QUERY_IDS_HISTORY");
      $query_accession_string = $self->getSql('group_name_per_group_id');
    }
    my $query_accession = $dbh->prepare($query_accession_string);
    foreach my $id (@{$query_ids_history->[$querynumber-1]}) {
      $query_accession->execute($id);
      my @tmp = $query_accession->fetchrow_array();
      if ($type eq 'sequence') {
	$file_content.="$tmp[0]\t$tmp[1]\t$tmp[2]\r\n"; 
      } elsif ($type eq 'group') {
	$file_content.="$tmp[0]\r\n"; 
      }
    }
  } else {
    $file_content = "Please specify both type (group/sequence) and querynumber\n";
  }

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End querySave(): " . ($currentTime - $startTime) . ".\n";    

  return $file_content;
}

sub queryTransform {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin queryTransform(): " . ($currentTime - $startTime) . ".\n";    

  my $dbh = $self->dbh();
  my $q = $self->query();
  my $config = $self->param("config");
  my @select=$q->param("select");
  my $sequence_query_ids_history = $self->session->param("SEQUENCE_QUERY_IDS_HISTORY");
  my $group_query_ids_history = $self->session->param("GROUP_QUERY_IDS_HISTORY");

  if (($q->param("from") eq 'sequence') && ($q->param("to") eq 'group')) {
    my $new_url = $config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=groupQueryHistory";
    $self->header_type('redirect');
    $self->header_props(-url=>$new_url);

    my %sequence_ids;
    foreach my $querynumber (@select) {
      foreach my $id (@{$sequence_query_ids_history->[$querynumber-1]}) {
	$sequence_ids{$id}=1;
      }
    }
    my %group_ids;
    my $query_group = $dbh->prepare($self->getSql('group_per_seq'));
    foreach (keys %sequence_ids) {
      $query_group->execute($_);
      my @data = $query_group->fetchrow_array();
      next if ($data[0]==0); # ignore those sequences not clustered (groupid is zero)
      $group_ids{$data[0]}=1;
    }
    my (@result_ids)=sort {$a<=>$b} keys %group_ids;
        
    # insert into group history as a new query
    my $query_time = $dbh->prepare('SELECT SYSDATE FROM dual');
    $query_time->execute();
    my @data = $query_time->fetchrow_array(); 
    my $time=$data[0];

    my $group_query_history = $self->session->param("GROUP_QUERY_HISTORY");
    my $action_description = 'from sequence query #'.join(",#",@select);
    push(@{$group_query_history},{    CODE   =>$action_description,
				      TYPE   =>'Query Transform',
				      TIME   =>$time,
				      NUMHITS=>scalar(@result_ids),
				      SHOW   =>1,
				 });
    $self->session->param("GROUP_QUERY_HISTORY",$group_query_history);
    push(@{$group_query_ids_history},\@result_ids);
    $self->session->param("GROUP_QUERY_IDS_HISTORY",$group_query_ids_history);

    # Timing info
    $currentTime = clock_gettime(CLOCK_REALTIME);
    print STDERR "End queryTransform(): " . ($currentTime - $startTime) . ".\n";    

    return "Redirecting to Group Query History";
  } elsif (($q->param("from") eq 'group') && ($q->param("to") eq 'sequence')) {
    my $new_url = $config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=sequenceQueryHistory";
    $self->header_type('redirect');
    $self->header_props(-url=>$new_url);

    my %group_ids;
    foreach my $querynumber (@select) {
      foreach my $id (@{$group_query_ids_history->[$querynumber-1]}) {
	$group_ids{$id}=1;
      }
    }
    my %sequence_ids;
    my $query_sequence = $dbh->prepare($self->getSql('sequences_per_grp'));
    foreach (keys %group_ids) {
      next if ($_==0);	       # (groupid is zero) means not clustered
      $query_sequence->execute($_);
      while (my @data = $query_sequence->fetchrow_array()) {
	$sequence_ids{$data[0]}=1;;
      }
    }
    my (@result_ids)=sort {$a<=>$b} keys %sequence_ids;
    # insert into group history as a new query
    my $query_time = $dbh->prepare('SELECT SYSDATE FROM dual');
    $query_time->execute();
    my @data = $query_time->fetchrow_array(); 
    my $time=$data[0];

    my $sequence_query_history = $self->session->param("SEQUENCE_QUERY_HISTORY");
    my $action_description = 'from group query #'.join(",#",@select);
    push(@{$sequence_query_history},{CODE   =>$action_description,
				     TYPE   =>'Query Transform',
				     TIME   =>$time,
				     NUMHITS=>scalar(@result_ids),
				     SHOW   =>1,
				    });
    $self->session->param("SEQUENCE_QUERY_HISTORY",$sequence_query_history);
    push(@{$sequence_query_ids_history},\@result_ids);
    $self->session->param("SEQUENCE_QUERY_IDS_HISTORY",$sequence_query_ids_history);

    # Timing info
    $currentTime = clock_gettime(CLOCK_REALTIME);
    print STDERR "End queryTransform(): " . ($currentTime - $startTime) . ".\n";    

    return "Redirecting to Sequence Query History";
  }
}

sub groupQueryHistory {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin groupQueryHistory(): " . ($currentTime - $startTime) . ".\n";    

  my $dbh = $self->dbh();
  my $q = $self->query();
  my @select=$q->param("select");
  my $config = $self->param("config");

  if (my $transform=$q->param("transform")) {
    my $new_url = $config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=queryTransform&from=group&to=sequence";
    foreach (@select) {
      $new_url.="&select=$_";
    }
    $self->header_type('redirect');
    $self->header_props(-url=>$new_url);
    return "Redirecting to Query Transform";
  }

  my $action=$q->param("action");
  my %para;

  $para{PAGETITLE}="OrthoMCL Group Query History";

  if ($debug) {
    push(@{$para{LOOP_DEBUG}},{DEBUG=>"action: $action"});
    foreach (@select) {
      push(@{$para{LOOP_DEBUG}},{DEBUG=>"select: $_"});
    }
  }

  my $group_query_history = $self->session->param("GROUP_QUERY_HISTORY") || [];

  if (my $action=$q->param("action")) {
    if ($action eq 'REMOVE') {
      foreach my $querynumber (@select) {
	$group_query_history->[$querynumber-1]->{SHOW}=0;
      }
    } else {
      my $action_description;
      if (scalar(@select)<2) {
	push(@{$para{LOOP_ERROR}},{ERROR=>"Please select at least 2 queries for $action!"});
      }
      my $group_query_ids_history = $self->session->param("GROUP_QUERY_IDS_HISTORY");
      my @result_ids;
      if ($action eq 'UNION') {
	$action_description = $action.' (#'.join("+#",@select).')';
	my %present_ids;
	foreach my $querynumber (@select) {
	  foreach my $id (@{$group_query_ids_history->[$querynumber-1]}) {
	    $present_ids{$id}=1;
	  }
	}
	@result_ids=sort {$a<=>$b} keys %present_ids;
      } elsif ($action eq 'INTERSECT') {
	$action_description = $action.' (#'.join("+#",@select).')';
	my %present_ids;
	foreach my $querynumber (@select) {
	  foreach my $id (@{$group_query_ids_history->[$querynumber-1]}) {
	    $present_ids{$id}++;
	  }
	}
	foreach (sort {$a<=>$b} keys %present_ids) {
	  if ($present_ids{$_}==scalar(@select)) {
	    push(@result_ids,$_);
	  }
	}
      } elsif (($action eq 'TOP MINUS BOTTOM') || ($action eq 'BOTTOM MINUS TOP')) {
	@select = sort {$a<=>$b} @select;
	my ($a,$b);
	if ($action eq 'TOP MINUS BOTTOM') {
	  $a = $select[0];
	  $b = $select[$#select];
	} elsif ($action eq 'BOTTOM MINUS TOP') {
	  $a = $select[$#select];
	  $b = $select[0];
	}
	$action_description = "$action (#$a-#$b)";
	my %b_ids;
	foreach (@{$group_query_ids_history->[$b-1]}) {
	  $b_ids{$_}=1;
	}
	foreach my $a_id (@{$group_query_ids_history->[$a-1]}) {
	  next if (defined $b_ids{$a_id});
	  push(@result_ids,$a_id);
	}
      } else {
	push(@{$para{LOOP_ERROR}},{ERROR=>"$action is not defined as an action!"});
      }

      # insert into history as a new query
      my $query_time = $dbh->prepare('SELECT SYSDATE FROM dual');
      $query_time->execute();
      my @data = $query_time->fetchrow_array();
      push(@{$group_query_history},{    CODE   =>$action_description,
					TYPE   =>'Query Action',
					TIME   =>$data[0],
					NUMHITS=>scalar(@result_ids),
					SHOW   =>1,
				   });
      $self->session->param("GROUP_QUERY_HISTORY",$group_query_history);
      push(@{$group_query_ids_history},\@result_ids);
      $self->session->param("GROUP_QUERY_IDS_HISTORY",$group_query_ids_history);

    }
  } elsif (my $filehandle = $q->upload("file")) {
    my $filename=$q->param("file");
    #        $q->param(-file=>'');
    #        $q->clear("file");#otherwise, there will be errors generated like "Do not know how to reconstitute blessed object of base type GLOB"
    $filename=~s/.*[\/\\](.*)/$1/g;
    my $group_query_ids_history = $self->session->param("GROUP_QUERY_IDS_HISTORY");
    my $query_orthogroupid = $dbh->prepare($self->getSql('group_id_per_group_name'));
    my @result_ids;
    while (<$filehandle>) {
      $_=~s/\r|\n//g;
      next if (/^\#/);
      if (/^(OG1_\d+)/) {
	$query_orthogroupid->execute($1);
	my @data = $query_orthogroupid->fetchrow_array();
	if ($data[0]) {
	  push(@result_ids,$data[0]);
	} else {
	  push(@{$para{LOOP_ERROR}},{ERROR=>"<STRONG>$1</STRONG> is not a OrthoMCL Group accession OR can't be found in OrthoMCL-DB"});
	}
      }
    }
    # insert into history as a new query
    my $query_time = $dbh->prepare('SELECT SYSDATE FROM dual');
    $query_time->execute();
    my @data = $query_time->fetchrow_array();
    push(@{$group_query_history},{    CODE   =>$filename,
				      TYPE   =>'Retrieve Groups From File',
				      TIME   =>$data[0],
				      NUMHITS=>scalar(@result_ids),
				      SHOW   =>1,
				 });
    $self->session->param("GROUP_QUERY_HISTORY",$group_query_history);
    push(@{$group_query_ids_history},\@result_ids);
    $self->session->param("GROUP_QUERY_IDS_HISTORY",$group_query_ids_history);
  }

  my $number_history=0;
  for (my $i=0;$i<=$#{$group_query_history};$i++) {
    next unless ($group_query_history->[$i]->{SHOW});
    my %query;
    $query{QUERYNUMBER}=$i+1;
    $query{QUERYTYPE}=$group_query_history->[$i]->{TYPE};
    $query{QUERYCODE}=$group_query_history->[$i]->{CODE};
    $query{QUERYNUMHIT}=$group_query_history->[$i]->{NUMHITS};
    $query{QUERYTIME}=$group_query_history->[$i]->{TIME};
    push(@{$para{LOOP_QUERYHISTORY}},\%query);
    $number_history++;
  }

  if ($number_history==0) {
    $para{NO_HISTORY}=1;
  }

  my $tmpl = $self->load_tmpl('group_queryhistory.tmpl'); # loading template
  $self->defaults($tmpl);
  $tmpl->param(\%para);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End groupQueryHistory(): " . ($currentTime - $startTime) . ".\n";    

  return $self->done($tmpl);
}

sub groupList {
  my $self = shift;
  
  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin groupList(): " . ($currentTime - $startTime) . ".\n";
  
  my $q = $self->query();
  my $dbh = $self->dbh();
  my $config = $self->param("config");

  my $tmpl = $self->load_tmpl('group_listing.tmpl'); # loading template
  $self->defaults($tmpl);

  my %para;		 # the parameters to fill in the html template
  $para{PAGETITLE}="OrthoMCL Group List";

  my $group_query_history = $self->session->param("GROUP_QUERY_HISTORY") || [];
  my $group_query_ids_history = $self->session->param("GROUP_QUERY_IDS_HISTORY") || [];

  my $querynumber;
  my $querycode;
  my $orthogroup_ids_ref=[];
  my $debug_info;
  #    my ($orthogroup_ids_ref,$debug_info);  # store all the orthogroup ids for current query

  if (my $querytype = $q->param('type')) { # initiate a new query
    #dealing with query time
    my $query_time = $dbh->prepare('SELECT SYSDATE FROM dual');
    $query_time->execute();
    my @tmp = $query_time->fetchrow_array();
    my $time=$tmp[0];
    if ($querytype eq 'ppexpression') {
      if ($querycode = $q->param("q")) {
	#print STDERR "exp: $querycode.\n";
	$orthogroup_ids_ref=OrthoMCLWebsite::Model::Ppe::Processor->processPpe($dbh, $querycode);
	push(@{$group_query_history},{
				      CODE   => $querycode,
				      TYPE   => 'Phyletic Pattern Expression',
				      TIME   => $time,
				      NUMHITS=> scalar(@{$orthogroup_ids_ref}),
				      SHOW   => 1,
				     });
      }
    } elsif ($querytype eq 'ackeyword') {
      if ((my $querycode = $q->param("q")) && (my $in = $q->param("in"))) {
	if ($in eq 'Group or Seq Accessions') {
	  my @qc=split(" ",$querycode);
	  foreach my $userAc (@qc) {
	    my $sqlName;
	    my @args;
	    if ($userAc =~ /^OG\d\d?_\d+$/) {
	      $sqlName = 'group_per_group_name';
	      @args = ($userAc, $userAc);
	    } elsif ($userAc =~ /^([a-z]{3,4})\|(\S+)$/) {
	      $sqlName = 'group_per_seq_source_id_and_taxon';
	      @args = ($2, $1, $userAc);
	    } else {
	      $sqlName = 'group_per_seq_source_id';
	      @args = ($userAc, $userAc);
	    }
	    my $query_orthogroup = $dbh->prepare($self->getSql($sqlName));
	    $query_orthogroup->execute(@args);
	    while (my @data = $query_orthogroup->fetchrow_array()) {
	      push(@{$orthogroup_ids_ref},$data[0]);
	    }
	  }
	} else {
	  my $query_string;
	  if ($in eq 'Keyword') {
	    $query_string = $self->getSql('groups_like_seq_descrip_keyword', {querycode=>$querycode});
	  } elsif ($in eq 'Pfam Accession') {
	    $query_string = $self->getSql('groups_by_pfam_accession', {querycode=>$querycode});
	  } elsif ($in eq 'Pfam Name') {
	    $query_string = $self->getSql('groups_like_pfam_name', {querycode=>$querycode});
	  } elsif ($in eq 'Pfam Keyword') {
	    $query_string = $self->getSql('groups_like_pfam_description', {querycode=>$querycode});
	  }
	  my $query_orthogroup = $dbh->prepare($query_string);
	  $query_orthogroup->execute();
	  while (my @data = $query_orthogroup->fetchrow_array()) {
	    push(@{$orthogroup_ids_ref},$data[0]);
	  }
	}
	push(@{$group_query_history},{
				      CODE   => "$querycode in $in",
				      TYPE   => "Group Accession/Keyword Search",
				      TIME   => $time,
				      NUMHITS=> scalar(@{$orthogroup_ids_ref}),
				      SHOW   => 1,
				     });
      }
    } elsif ($querytype eq 'property') {
      if ((my $sizeof = $q->param("sizeof")) && (my $number = $q->param("number"))) {
	my $query_orthogroup;
	if ($sizeof eq 'Sequences') {
	  my $query_string = $self->getSql('groups_by_num_seqs', {number=>$number});
	  $query_orthogroup=$dbh->prepare($query_string);
	} elsif ($sizeof eq 'Genomes') {
	  my $query_string = $self->getSql('groups_by_num_species', {number=>$number});
	  $query_orthogroup=$dbh->prepare($query_string);
	}
	$query_orthogroup->execute();
	while (my @data = $query_orthogroup->fetchrow_array()) {
	  push(@{$orthogroup_ids_ref},$data[0]);
	}
	push(@{$group_query_history},{
				      CODE   => "SIZE($sizeof)$number",
				      TYPE   => 'Group Size Search',
				      TIME   => $time,
				      NUMHITS=> scalar(@{$orthogroup_ids_ref}),
				      SHOW   => 1,
				     });

      } elsif ((my $prop = $q->param("prop")) && ($number = $q->param("number"))) {
	my $querystring;
	if ($prop=~/Pairs/) {
	  $querystring= $self->getSql('groups_by_num_match_pairs', {number=>$number});
	  # } elsif ($prop=~/DCS/) {
	  #     $querystring="SELECT orthogroup_id FROM orthogroup WHERE ave_dcs $number";
	} elsif ($prop=~/Identity/) {
	  $querystring= $self->getSql('groups_by_percent_identity', {number=>$number});
	} elsif ($prop=~/Match/) {
	  $querystring= $self->getSql('groups_by_percent_match', {number=>$number});
	} elsif ($prop=~/BLAST/) {
	  $querystring= $self->getSql('groups_by_blast_evalue', {number=>$number});
	}
    
	my $query_orthogroup=$dbh->prepare($querystring);

	if ($debug) {
	  push(@{$para{LOOP_DEBUG}},{DEBUG=>$querystring});
	}

	$query_orthogroup->execute();
	while (my @data = $query_orthogroup->fetchrow_array()) {
	  push(@{$orthogroup_ids_ref},$data[0]);
	}
	if (not defined $orthogroup_ids_ref) {
	  $orthogroup_ids_ref=[];
	}
	push(@{$group_query_history},{
				      CODE   => "$prop$number",
				      TYPE   => 'Property Search',
				      TIME   => $time,
				      NUMHITS=> scalar(@{$orthogroup_ids_ref}),
				      SHOW   => 1,
				     });
      }
    } elsif ($querytype eq 'ppform') {
      # should we be doing something in here, similar to the ppexpression query type?
    }
    $self->session->param("GROUP_QUERY_HISTORY",$group_query_history);
    @$orthogroup_ids_ref=sort {$a<=>$b} @$orthogroup_ids_ref;
    push(@{$group_query_ids_history},$orthogroup_ids_ref);
    $self->session->param("GROUP_QUERY_IDS_HISTORY",$group_query_ids_history);

    $querynumber=scalar(@{$group_query_history});
    $para{QUERY_TYPE}=$group_query_history->[$querynumber-1]->{TYPE}; # for group_listing page to display
    $para{QUERY_CODE}=$group_query_history->[$querynumber-1]->{CODE}; # for group_listing page to display
    $self->session->param('GROUP_QUERY_NUMBER',$querynumber); # store the current querynumber for later paging
  } else {			# refer to an old query
    if ($querynumber = $q->param('querynumber')) {
      $self->session->param('GROUP_QUERY_NUMBER',$querynumber);
      $orthogroup_ids_ref=$group_query_ids_history->[$querynumber-1];
      $para{QUERY_TYPE}=$group_query_history->[$querynumber-1]->{TYPE};
      $para{QUERY_CODE}=$group_query_history->[$querynumber-1]->{CODE};
    } elsif ($querynumber=$self->session->param('GROUP_QUERY_NUMBER')) {
      $orthogroup_ids_ref=$group_query_ids_history->[$querynumber-1];
      $para{QUERY_TYPE}=$group_query_history->[$querynumber-1]->{TYPE};
      $para{QUERY_CODE}=$group_query_history->[$querynumber-1]->{CODE};
    } else {
      $orthogroup_ids_ref=[];
      $para{QUERY_TYPE}='N/A';
      $para{QUERY_CODE}='N/A';
      push(@{$para{LOOP_ERROR}},{ERROR=>"You have no query in history! Or start a new query!"});
    }
  }

  if ($debug) {
    foreach (@$debug_info) {
      push(@{$para{LOOP_DEBUG}},{DEBUG=>$_});
    }
  }
    
  # get the taxon tree for phyletic pattern in the group list page
  my $columnMgr = OrthoMCLShared::Ppe::MatrixColumnManager->new($dbh);

  my %species;
  my $query_taxonname = $dbh->prepare($self->getSql('all_taxa_info'));
  $query_taxonname->execute();
  while (my @data = $query_taxonname->fetchrow_array()) {
    my $taxon_id = $data[0];
    my $taxon_abbrev = $data[2];
    my $is_species = $data[4];
    push(@{$para{TAXONS}},  { TAXON_ID => $taxon_id,
			      PARENT_ID => $data[1],
			      ABBREV => $taxon_abbrev,
			      NAME => $data[3],
			      IS_SPECIES => $is_species,
			      INDEX => $data[5],
                              COMMON_NAME => $data[6] });
    if ($is_species != 0) {
      my $column = $columnMgr->getColumnName($taxon_abbrev, "");
      $column =~ s/\D//g;
      $species{$taxon_id} = $column + 1;
    }
  }

  $para{NUM_GROUPS}=scalar(@{$orthogroup_ids_ref});
  $para{NUM_PAGES}=int(($para{NUM_GROUPS}-1)/10)+1;
  if ($para{NUM_PAGES}==1) {
    $para{ONEPAGE}=1;
  }
    
  $tmpl->param(\%para);

  require HTML::Pager;
  my $pager = HTML::Pager->new( query => $self->query,
				template => $tmpl,
				get_data_callback => [ \&getGroupRows,
						       $orthogroup_ids_ref, $dbh, $tmpl, $config, \%species, $self
						     ],
				rows => scalar(@{$orthogroup_ids_ref}),
				page_size => 10,
			      );
  
  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End groupList(): " . ($currentTime - $startTime) . ".\n";

  return $pager->output;
}

sub getGroupRows {
  my ($offset, $rows, $orthogroup_ids_ref, $dbh, $tmpl, $config, $species_ref, $self) = @_;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin getGroupRows(): " . ($currentTime - $startTime) . ".\n";    
    
  $tmpl->param(ROWSPERPAGE => $rows);
  $tmpl->param(GROUP_NUM_S => $offset+1);
  if (scalar(@{$orthogroup_ids_ref})<$offset+$rows) {
    $tmpl->param(GROUP_NUM_E => scalar(@{$orthogroup_ids_ref}));
  } else {
    $tmpl->param(GROUP_NUM_E => $offset+$rows);
  }
  #    $tmpl->param(CURRENTPAGE => int($offset / $rows) + 1);
    
  my @rows;
    
  #   this is for phyletic pattern display
  my $query_orthogroup = $dbh->prepare($self->getSql('group_attributes_per_group'));
    
  my $query_taxa_by_o = $dbh->prepare($self->getSql('taxa_num_genes_per_group'));
    
  my $query_keywords_by_o = $dbh->prepare($self->getSql('keywords_per_group'));	# used for summarizing keyword
    
  my $query_domain_by_o = $dbh->prepare($self->getSql('sequence_domains_per_group'));

  my $count=0;
    
  for (my $x = 0; $x < $rows; $x++) {
    last if ($offset+$x>$#{$orthogroup_ids_ref});
    
    # Timing info
    #$currentTime = clock_gettime(CLOCK_REALTIME);
    #print STDERR "Begin group #$x: " . ($currentTime - $startTime) . ".\n";    

    my $orthogroup_id=$orthogroup_ids_ref->[$offset+$x];
    #    foreach my $orthogroup_id (sort {$a<=>$b} @{$orthogroup_ids_ref}) {
            
    $query_orthogroup->execute($orthogroup_id);
    my @data = $query_orthogroup->fetchrow_array();
    
    my %group;
    $count++;
    if ($count % 2 == 0) {
      $group{__EVEN__}=1;
    }
    
    $group{GROUP_NUMBER}=$offset+$x+1;
    $group{GROUP_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupac=$data[1]";
    $group{DOMARCH_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=domarchList&groupac=$data[1]";
    $group{SEQUENCE_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=getSeq&groupac=$data[1]";
            
    $group{NO_SEQUENCES}=$data[7];
    
    my $has_bl = $data[8];
    if ($has_bl == 1) {
      $group{BIOLAYOUT_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=BLGraph&groupac=$data[1]";
    }
        
    my $has_msa = $data[9];
    if ($has_msa == 1) {
      $group{MSA_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=MSA&groupac=$data[1]";
    }
    
    $group{GROUP_ACCESSION}=$data[1];
    $group{NO_MATCH_PAIRS}=$data[6];
    $group{PERC_MATCH_PAIRS}=int(1000*$group{NO_MATCH_PAIRS}/($group{NO_SEQUENCES}*($group{NO_SEQUENCES}-1)/2))/10;
    
    if ($group{NO_MATCH_PAIRS}==0) {
      $group{AVE_EVAL}='N/A';
      $group{AVE_PM}='N/A';
      $group{AVE_PI}='N/A';
    } else {
      $group{AVE_EVAL}=sprintf("%8.2e",$data[5]);
      $group{AVE_PM}=sprintf("%.1f", $data[4]);
      $group{AVE_PI}=sprintf("%.1f", $data[3]);
    }
    #        $group{AVE_DCS}=$data[2];
    
    # Timing info
    #$currentTime = clock_gettime(CLOCK_REALTIME);
    #print STDERR "End group #$x Attrs: " . ($currentTime - $startTime) . ".\n";    
    
    # get taxon and gene counts
    $query_taxa_by_o->execute($orthogroup_id);
    my $taxon_count = 0;
    if (my @data = $query_taxa_by_o->fetchrow_array()) {
      while ( my ($taxon_id, $column_id) = each(%$species_ref) ) {
	my $gene_count = $data[$column_id];
	if ($gene_count > 0) {
	  push(@{$group{TAXON_GENES}}, { TAXON_ID => $taxon_id,
					 GENE_COUNT => $gene_count });
	  $taxon_count++;
	}
      }
    }
    $group{NO_TAXA} = $taxon_count;
    
    # Timing info
    #$currentTime = clock_gettime(CLOCK_REALTIME);
    #print STDERR "End group #$x taxons: " . ($currentTime - $startTime) . ".\n";    

    # about Keywords summary
    $group{KEYWORDS} = "";
    if (1) {
      $query_keywords_by_o->execute($orthogroup_id);
      my %keywords;
      while (my @data = $query_keywords_by_o->fetchrow_array()) {
	$keywords{$data[0]} = $data[1];
      }

      foreach my $k (keys %keywords) {
	my $c=sprintf("%X",int((1-$keywords{$k})*255));
	$group{KEYWORDS}.="<font color=\"#$c$c$c\">$k</font>; ";
      }
    }
    
    # Timing info
    #$currentTime = clock_gettime(CLOCK_REALTIME);
    #print STDERR "End group #$x Keyowrds: " . ($currentTime - $startTime) . ".\n";    

    # about Pfam domain summary
    $group{DOMAIN} = "";
    $query_domain_by_o->execute($orthogroup_id);
    while (my ($domain_desc, $freq) = $query_domain_by_o->fetchrow_array()) {
      my $c=sprintf("%X",int((1-$freq)*255));
      $group{DOMAIN}.="<font color=\"#$c$c$c\">$domain_desc</font>; ";
    }
    
    # Timing info
    #$currentTime = clock_gettime(CLOCK_REALTIME);
    #print STDERR "End group #$x pfam: " . ($currentTime - $startTime) . ".\n";    

    push(@rows,\%group);
  }

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End getGroupRows(): " . ($currentTime - $startTime) . ".\n";    
    
  return \@rows;
}

sub sequenceQueryHistory {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin sequenceQueryHistory(): " . ($currentTime - $startTime) . ".\n";    

  my $dbh = $self->dbh();
  my $q = $self->query();
  my @select=$q->param("select");
  my $config = $self->param("config");

  if (my $transform=$q->param("transform")) {
    my $new_url = $config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=queryTransform&from=sequence&to=group";
    foreach (@select) {
      $new_url.="&select=$_";
    }
    $self->header_type('redirect');
    $self->header_props(-url=>$new_url);
    return "Redirecting to Query Transform";
  }

  my $action=$q->param("action");

  my %para;

  $para{PAGETITLE}="Sequence Query History";

  if ($debug) {
    push(@{$para{LOOP_DEBUG}},{DEBUG=>"action: $action"});
    foreach (@select) {
      push(@{$para{LOOP_DEBUG}},{DEBUG=>"select: $_"});
    }
  }

  my $sequence_query_history = $self->session->param("SEQUENCE_QUERY_HISTORY") || [];

  if (my $action=$q->param("action")) {
    if ($action eq 'REMOVE') {
      foreach my $querynumber (@select) {
        $sequence_query_history->[$querynumber-1]->{SHOW}=0;
      }
    } else {
      if (scalar(@select)<2) {
        push(@{$para{LOOP_ERROR}},{ERROR=>"Please select at least 2 queries for $action!"});
      }
      my $sequence_query_ids_history = $self->session->param("SEQUENCE_QUERY_IDS_HISTORY");
      my @result_ids;
      my $action_description;

      if ($action eq 'UNION') {
        $action_description = $action.' (#'.join("+#",@select).')';
        my %present_ids;
        foreach my $querynumber (@select) {
          foreach my $sequence_id (@{$sequence_query_ids_history->[$querynumber-1]}) {
            $present_ids{$sequence_id}=1;
          }
        }
        @result_ids=sort {$a<=>$b} keys %present_ids;
      } elsif ($action eq 'INTERSECT') {
        $action_description = $action.' (#'.join("+#",@select).')';
        my %present_ids;
        foreach my $querynumber (@select) {
          foreach my $sequence_id (@{$sequence_query_ids_history->[$querynumber-1]}) {
            $present_ids{$sequence_id}++;
          }
        }
        foreach (sort {$a<=>$b} keys %present_ids) {
          if ($present_ids{$_}==scalar(@select)) {
            push(@result_ids,$_);
          }
        }
      } elsif (($action eq 'TOP MINUS BOTTOM') || ($action eq 'BOTTOM MINUS TOP')) {
        @select = sort {$a<=>$b} @select;
        my ($a,$b);
        if ($action eq 'TOP MINUS BOTTOM') {
          $a = $select[0];
          $b = $select[$#select];
        } elsif ($action eq 'BOTTOM MINUS TOP') {
          $a = $select[$#select];
          $b = $select[0];
        }
        $action_description = "$action (#$a-#$b)";
        my %b_seqids;
        foreach (@{$sequence_query_ids_history->[$b-1]}) {
          $b_seqids{$_}=1;
        }
        foreach my $a_seqid (@{$sequence_query_ids_history->[$a-1]}) {
          next if (defined $b_seqids{$a_seqid});
          push(@result_ids,$a_seqid);
        }
      } else {
        push(@{$para{LOOP_ERROR}},{ERROR=>"$action is not defined as an action!"});
      }

      # insert into history as a new query
      my $query_time = $dbh->prepare('SELECT SYSDATE FROM dual');
      $query_time->execute();
      my @data = $query_time->fetchrow_array(); 
      my $time=$data[0];
      push(@{$sequence_query_history},{    CODE   =>$action_description,
					   TYPE   =>'Query Action',
					   TIME   =>$time,
					   NUMHITS=>scalar(@result_ids),
					   SHOW   =>1,
				      });
      $self->session->param("SEQUENCE_QUERY_HISTORY",$sequence_query_history);
      push(@{$sequence_query_ids_history},\@result_ids);
      $self->session->param("SEQUENCE_QUERY_IDS_HISTORY",$sequence_query_ids_history);
    }
  } elsif (my $filehandle = $q->upload("file")) {
    my $filename=$q->param("file");
    $filename=~s/.*[\/\\](.*)/$1/g;
    my $sequence_query_ids_history = $self->session->param("SEQUENCE_QUERY_IDS_HISTORY");
    my $query_sequenceid = $dbh->prepare($self->getSql('sequence_per_source_id'));
    my @result_ids;
    while (<$filehandle>) {
      $_=~s/\r|\n//g;
      next if (/^\#/);
      if (/^(\S+)/) {
	$query_sequenceid->execute($1);
	my @data = $query_sequenceid->fetchrow_array();
	if ($data[0]) {
	  push(@result_ids,$data[0]);
	} else {
	  push(@{$para{LOOP_ERROR}},{ERROR=>"<STRONG>$1</STRONG> is not a sequence accession OR can't be found in OrthoMCL-DB"});
	}
      }
    }
    
    # this is necessary in order to convert GLOB into string
    $filename = "$filename";
    
    # insert into history as a new query
    my $query_time = $dbh->prepare('SELECT SYSDATE FROM dual');
    $query_time->execute();
    my @data = $query_time->fetchrow_array();
    push(@{$sequence_query_history},{    CODE   =>$filename,
					 TYPE   =>'Retrieve Sequences From File',
					 TIME   =>$data[0],
					 NUMHITS=>scalar(@result_ids),
					 SHOW   =>1,
                                    });
    $self->session->param("SEQUENCE_QUERY_HISTORY",$sequence_query_history);
    push(@{$sequence_query_ids_history},\@result_ids);
    $self->session->param("SEQUENCE_QUERY_IDS_HISTORY",$sequence_query_ids_history);
  }

  my $number_history=0;
  for (my $i=0;$i<=$#{$sequence_query_history};$i++) {
    next unless ($sequence_query_history->[$i]->{SHOW});
    my %query;
    $query{QUERYNUMBER}=$i+1;
    $query{QUERYTYPE}=$sequence_query_history->[$i]->{TYPE};
    $query{QUERYCODE}=$sequence_query_history->[$i]->{CODE};
    $query{QUERYNUMHIT}=$sequence_query_history->[$i]->{NUMHITS};
    $query{QUERYTIME}=$sequence_query_history->[$i]->{TIME};
    push(@{$para{LOOP_QUERYHISTORY}},\%query);
    $number_history++;
  }

  if ($number_history==0) {
    $para{NO_HISTORY}=1;
  }

  my $tmpl = $self->load_tmpl('sequence_queryhistory.tmpl'); # loading template
  $self->defaults($tmpl);
  $tmpl->param(\%para);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End sequenceQueryHistory(): " . ($currentTime - $startTime) . ".\n";    

  return $self->done($tmpl);
}


sub sequenceList {
  my $self   = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin sequenceList(): " . ($currentTime - $startTime) . ".\n";    

  my $config = $self->param("config");
  my $q      = $self->query();
  my $dbh    = $self->dbh();

  my $tmpl   = $self->load_tmpl('sequence_listing.tmpl');
  $self->defaults($tmpl);

  my %para;

  $para{PAGETITLE}="Sequence List";

  my $sequence_ids_ref;	# store all the sequence ids for current query
  # this variable is used for paging,  thus not suitable for sequence list of certain groupid

  if ($q->param("groupid") || $q->param("groupac")) {

    my ($orthogroup_id,$orthogroup_ac);
    if ($orthogroup_ac = $q->param("groupac")) {
      # support a wrong group name
      my $query_orthogroupid = $dbh->prepare($self->getSql('group_id_per_group_name'));
      $query_orthogroupid->execute($orthogroup_ac);
      my @tmp = $query_orthogroupid->fetchrow_array();
      $orthogroup_id = $tmp[0];
    } else {
      $orthogroup_id = $q->param("groupid");
    }

    $para{GROUP}=1;

    # Prepare Group Summary Part #
    my $query_orthogroup = $dbh->prepare($self->getSql('group_attributes_per_group'));

    # get the taxon tree for phyletic pattern in the group list page
    my $columnMgr = OrthoMCLShared::Ppe::MatrixColumnManager->new($dbh);

    my %species;
    my $query_taxonname = $dbh->prepare($self->getSql('all_taxa_info'));
    $query_taxonname->execute();
    while (my @data = $query_taxonname->fetchrow_array()) {
      my $taxon_id = $data[0];
      my $taxon_abbrev = $data[2];
      my $is_species = $data[4];
      push(@{$para{TAXONS}},  { TAXON_ID => $taxon_id,
				PARENT_ID => $data[1],
				ABBREV => $taxon_abbrev,
				NAME => $data[3],
				IS_SPECIES => $is_species,
				INDEX => $data[5],
                                COMMON_NAME => $data[6] });
      if ($is_species != 0) {
	my $column = $columnMgr->getColumnName($taxon_abbrev, "");
	$column =~ s/\D//g;
	$species{$taxon_id} = $column + 1;
      }
    }

    $query_orthogroup->execute($orthogroup_id);
    my @data = $query_orthogroup->fetchrow_array();

    $para{NO_SEQUENCES}=$data[7];
    $para{GROUP_ACCESSION}=$data[1];
    $para{NO_MATCH_PAIRS}=$data[6];
    $para{PERC_MATCH_PAIRS}=int(1000*$para{NO_MATCH_PAIRS}/($para{NO_SEQUENCES}*($para{NO_SEQUENCES}-1)/2))/10;
    $para{AVE_EVAL}=sprintf("%8.2e",$data[5]);
    $para{AVE_PM}=$data[4];
    $para{AVE_PI}=$data[3];
    #        $para{AVE_DCS}=$data[2];

    $para{DOMARCH_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=domarchList&groupac=".$para{GROUP_ACCESSION};
    $para{SEQUENCE_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=getSeq&groupac=".$para{GROUP_ACCESSION};

    
    my $has_bl = $data[8];
    if ($has_bl == 1) {
      $para{BIOLAYOUT_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=BLGraph&groupac=".$para{GROUP_ACCESSION};
    }
    
    my $has_msa = $data[9];
    if ($has_msa == 1) {
      $para{MSA_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=MSA&groupac=".$para{GROUP_ACCESSION};
    }

    my $query_taxa_by_o = $dbh->prepare($self->getSql('taxa_num_genes_per_group'));
        
    # get taxon and gene counts
    $query_taxa_by_o->execute($orthogroup_id);
    my $taxon_count = 0;
    if (my @data = $query_taxa_by_o->fetchrow_array()) {
      while ( my ($taxon_id, $column_id) = each(%species) ) {
	my $gene_count = $data[$column_id];
	if ($gene_count > 0) {
	  push(@{$para{TAXON_GENES}}, { TAXON_ID => $taxon_id,
					GENE_COUNT => $gene_count });
	  $taxon_count++;
	}
      }
    }
    $para{NO_TAXA} = $taxon_count;

    # Prepare Sequence List Part #
    my $query_sequence_by_groupid = $dbh->prepare($self->getSql('sequence_attributes_per_group'));
    $query_sequence_by_groupid->execute($orthogroup_id);

    my $count=0;
    while (my @data = $query_sequence_by_groupid->fetchrow_array()) {
      my %sequence;
      $count++;
      if ($count%2) {
        $sequence{__ODD__}=1;
      } else {
        $sequence{__EVEN__}=1;
      }
      my $taxon_abbrev = $data[6];
      $sequence{SEQUENCE_NUMBER}=$count;
      $sequence{SEQUENCE_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=$data[0]&taxon=$taxon_abbrev";
      $sequence{SEQUENCE_ACCESSION}=$data[0];
      $sequence{SEQUENCE_DESCRIPTION}=$data[2];
      $sequence{SEQUENCE_LENGTH}=$data[3];
      $sequence{SEQUENCE_TAXON}=$data[4];
      $sequence{PREVIOUS_GROUPS}=$data[7];
      $sequence{SEQUENCE_TAXON_ABBREV}=$taxon_abbrev;
      push(@{$para{PAGER_DATA_LIST}},\%sequence);
    }
    $para{NO_GROUPAC}=1;
    $tmpl->param(\%para);

    # Timing info
    $currentTime = clock_gettime(CLOCK_REALTIME);
    print STDERR "End sequenceList(): " . ($currentTime - $startTime) . ".\n";    

    return $self->done($tmpl);

  } elsif ((my $querycode = $q->param("q")) && (my $in = $q->param("in"))) {

    my $sequence_query_history = $self->session->param("SEQUENCE_QUERY_HISTORY") || [];
    my $sequence_query_ids_history = $self->session->param("SEQUENCE_QUERY_IDS_HISTORY") || [];

    my $querynumber;

    # Prepare Sequence List Part #
    my $query_time = $dbh->prepare('SELECT SYSDATE FROM dual');
    $query_time->execute();
    my @tmp = $query_time->fetchrow_array();
    my $time=$tmp[0];

    if ($in eq "blast") {
      use File::Temp qw(tempfile);
      my ($fh, $tempfile) = tempfile(DIR => "/tmp");
      print $fh $querycode;
      close($fh);
      $ENV{BLASTMAT} = $config->{BLASTMAT};
      my $cmd = "$config->{BLAST} -p blastp -i $tempfile -d $config->{FA_file} -e 1e-5 -b 0 |";

      #print STDERR "BLAST: " . $cmd . '\n';

      open(BLAST, $cmd) or die $!;
      my $query_sequence = $dbh->prepare($self->getSql('sequence_per_source_id_and_taxon'));
      while (<BLAST>) {
        if (m/Sequences producing significant alignments/) {
          <BLAST>;		# empty line
          while (<BLAST>) {
            last if m/^\s*$/;
            if (m/^([a-z]{3,4})\|(\S+)/) {
              my $abbrev = $1;
              my $seqAc = $2;
	      $query_sequence->execute($seqAc, $abbrev, "$abbrev|$seqAc");
	      while (my @data = $query_sequence->fetchrow_array()) {
                push(@{$sequence_ids_ref},$data[0]);
	      }
            }
          }
        }
      }
      close(BLAST);
      unlink($tempfile);
    } elsif ($in eq 'Sequence Accessions') {
      my @qc = split(" ",$querycode);
      my $sqlName;
      foreach my $userAcc (@qc) {
	my @args;
	if ($userAcc =~ /^([a-z]{3,4})\|(\S+)$/) {
          my $abbrev = $1;
          my $seqAc = $2;
	  $sqlName = 'sequence_per_source_id_and_taxon';
	  @args = ($seqAc, $abbrev, "$abbrev|$seqAc");
	} else {
	  @args = ($userAcc, $userAcc);
	  $sqlName = 'sequence_per_source_id';
	}
	my $query_sequence = $dbh->prepare($self->getSql($sqlName));
        $query_sequence->execute(@args);
        while (my @data = $query_sequence->fetchrow_array()) {
          push(@{$sequence_ids_ref},$data[0]);
        }
      }
    } elsif ($in eq 'Old Group Accession') {
      my @qc = split(" ",$querycode);
      my $sqlName;
      foreach my $userAcc (@qc) {
        my @args;
        @args = ($userAcc, $userAcc);
        $sqlName = 'sequence_per_group_ac';
        my $query_sequence = $dbh->prepare($self->getSql($sqlName));
        $query_sequence->execute(@args);
        while (my @data = $query_sequence->fetchrow_array()) {
          push(@{$sequence_ids_ref},$data[0]);
        }
      }
    } else {
      my $query_string;
      if ($in eq 'All') {
        $query_string = $self->getSql('sequence_id_like_id_and_descrip_keyword', {querycode=>$querycode});
      } elsif ($in eq 'Keyword') {
        $query_string = $self->getSql('sequence_id_like_descrip_keyword', {querycode=>$querycode});
      } elsif ($in eq 'Taxon Abbreviation') {
        $query_string = $self->getSql('sequence_id_by_three_letter_abbrev', {querycode=>$querycode});
      } elsif ($in eq 'Pfam Accession') {
        $query_string = $self->getSql('sequence_id_by_pfam_accession', {querycode=>$querycode});
      } elsif ($in eq 'Pfam Name') {
        $query_string = $self->getSql('sequence_id_like_pfam_name', {querycode=>$querycode});
      } elsif ($in eq 'Pfam Keyword') {
        $query_string = $self->getSql('sequence_id_like_pfam_keyword', {querycode=>$querycode});
      }

      if ($debug) {
        push(@{$para{LOOP_DEBUG}},{DEBUG=>"SQL: $query_string"});
      }

      my $query_sequence = $dbh->prepare($query_string);
      $query_sequence->execute();

      while (my @data = $query_sequence->fetchrow_array()) {
        push(@{$sequence_ids_ref},$data[0]);
      }
    }

    if (not defined $sequence_ids_ref) {
      $sequence_ids_ref=[];
    } elsif (scalar(@$sequence_ids_ref)==1) {
      if (my $groupredirect=$q->param("groupredirect")) {
        if ($groupredirect==1) {
          my $seq_id = $sequence_ids_ref->[0];
          my $group_qs= $self->getSql('group_name_by_sequence_id', {seq_id=>$seq_id});
          my $group_q1=$dbh->prepare($group_qs);
          $group_q1->execute();
          my @group_ac;
          while (my @data=$group_q1->fetchrow_array()) {
            push(@group_ac,$data[0]);
          }
          if (scalar(@group_ac)==1) {
            #                        $para{JS_CODE}="$group_ac[0]";
            $para{JS_CODE}="<script type=\"text/javascript\" language=\"JavaScript\">
                                                setTimeout('Redirect()',0);
                                                function Redirect() {
                                                    location.href='/cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupac=".$group_ac[0]."';
                                                }</script>\n";
          }
        }    
      }
    }

    push(@{$sequence_query_history},{CODE   => $querycode,
				     TYPE   => $in,
				     TIME   => $time,
				     NUMHITS=> scalar(@{$sequence_ids_ref}),
				     SHOW   => 1,
                                    });

    $self->session->param("SEQUENCE_QUERY_HISTORY",$sequence_query_history);
    
    push(@{$sequence_query_ids_history},$sequence_ids_ref);
    $self->session->param("SEQUENCE_QUERY_IDS_HISTORY",$sequence_query_ids_history);

    $para{QUERY_TYPE}=$in;	# for sequence_listing page to display
    $para{QUERY_CODE}=$querycode; # for sequence_listing page to display
    $querynumber=scalar(@{$sequence_query_history});
    $self->session->param('SEQUENCE_QUERY_NUMBER',$querynumber); # store the current querynumber for later paging
  } else {			# refer to an old query
    my $querynumber;
    my $sequence_query_history = $self->session->param("SEQUENCE_QUERY_HISTORY") || [];
    my $sequence_query_ids_history = $self->session->param("SEQUENCE_QUERY_IDS_HISTORY") || [];

    if ($querynumber = $q->param('querynumber')) {
      $self->session->param('SEQUENCE_QUERY_NUMBER',$querynumber);
      $sequence_ids_ref=$sequence_query_ids_history->[$querynumber-1];
      $para{QUERY_TYPE}=$sequence_query_history->[$querynumber-1]->{TYPE};
      $para{QUERY_CODE}=$sequence_query_history->[$querynumber-1]->{CODE};
    } elsif ($querynumber=$self->session->param('SEQUENCE_QUERY_NUMBER')) {
      $sequence_ids_ref=$sequence_query_ids_history->[$querynumber-1];
      $para{QUERY_TYPE}=$sequence_query_history->[$querynumber-1]->{TYPE};
      $para{QUERY_CODE}=$sequence_query_history->[$querynumber-1]->{CODE};
    } else {
      $sequence_ids_ref=[];
      $para{QUERY_TYPE}='N/A';
      $para{QUERY_CODE}='N/A';
      push(@{$para{LOOP_ERROR}},{ERROR=>"You have no query in history! Or start a new query!"});
    }
  }
  $para{NUM_SEQUENCES}=scalar(@{$sequence_ids_ref});
  $para{NUM_PAGES}=int(($para{NUM_SEQUENCES}-1)/50)+1;
  if ($para{NUM_PAGES}==1) {
    $para{ONEPAGE}=1;
  }
    
  $tmpl->param(\%para);

  require HTML::Pager;
  my $pager = HTML::Pager->new( query => $self->query,
				template => $tmpl,
				get_data_callback => [ \&getSequenceRows,
						       $sequence_ids_ref, $dbh, $tmpl, $config, $self
						     ],
				rows => scalar(@{$sequence_ids_ref}),
				page_size => 50,
			      );

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End sequenceList(): " . ($currentTime - $startTime) . ".\n";    

  return $pager->output;
}

sub getSequenceRows {
  my ($offset, $rows, $sequence_ids_ref, $dbh, $tmpl, $config, $self) = @_;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin getSequenceRows(): " . ($currentTime - $startTime) . ".\n";    

  $tmpl->param(ROWSPERPAGE => $rows);
  $tmpl->param(SEQUENCE_NUM_S => $offset+1);
  if (scalar(@{$sequence_ids_ref})<$offset+$rows) {
    $tmpl->param(SEQUENCE_NUM_E => scalar(@{$sequence_ids_ref}));
  } else {
    $tmpl->param(SEQUENCE_NUM_E => $offset+$rows);
  }

  my @rows;

  my $query_sequence = $dbh->prepare($self->getSql('sequence_info_per_sequence_id'));

  my $count=0;

  for (my $x = 0; $x < $rows; $x++) {
    last if ($offset+$x>$#{$sequence_ids_ref});
    my $sequence_id=$sequence_ids_ref->[$offset+$x];
        
    $query_sequence->execute($sequence_id);
    my @data = $query_sequence->fetchrow_array();

    my %sequence;
    $count++;
    if ($count%2) {
      $sequence{__ODD__}=1;
    } else {
      $sequence{__EVEN__}=1;
    }
    my $taxon_abbrev = $data[8];
    $sequence{SEQUENCE_TAXON_ABBREV}=$taxon_abbrev;
    $sequence{SEQUENCE_NUMBER}=$offset+$x+1;;
    $sequence{SEQUENCE_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=$data[0]&taxon=$taxon_abbrev";
    $sequence{SEQUENCE_ACCESSION}=$data[0];
    $sequence{SEQUENCE_DESCRIPTION}=$data[2];
    $sequence{SEQUENCE_LENGTH}=$data[3];
    $sequence{SEQUENCE_TAXON}=$data[4];
    $sequence{PREVIOUS_GROUPS}=$data[9];
    if (defined $data[6]) {
      $sequence{GROUP_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupid=$data[7]";
      $sequence{GROUP_ACCESSION}=$data[6];
    } else {
      $sequence{GROUP_ACCESSION}='not clustered';
    }
    push(@rows,\%sequence);
  }

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End getSequenceRows(): " . ($currentTime - $startTime) . ".\n";    

  return \@rows;
}



sub domarchList {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin domarchList(): " . ($currentTime - $startTime) . ".\n";    

  my $config = $self->param("config");
  my $dbh = $self->dbh();
  my $q = $self->query();

  $dbh->{LongTruncOk} = 0;
  $dbh->{LongReadLen} = 100000000;

  my %para;

  my ($orthogroup_id,$orthogroup_ac);
  if ($orthogroup_id = $q->param("groupid")) {
    my $query_orthogroup_by_groupid = $dbh->prepare($self->getSql('group_name_per_group_id'));
    $query_orthogroup_by_groupid->execute($orthogroup_id);
    my @tmp = $query_orthogroup_by_groupid->fetchrow_array();
    $orthogroup_ac = $tmp[0];
  } elsif ($orthogroup_ac = $q->param("groupac")) {
    my $query_orthogroup_by_groupac = $dbh->prepare($self->getSql('group_id_per_group_name'));
    $query_orthogroup_by_groupac->execute($orthogroup_ac);
    my @tmp = $query_orthogroup_by_groupac->fetchrow_array();
    $orthogroup_id = $tmp[0];
  }

  $para{GROUP_ACCESSION}=$orthogroup_ac;

  $para{PAGETITLE}="Protein Domain Architecture for $orthogroup_ac";
  my $query_sequence_by_groupid = $dbh->prepare($self->getSql('domain_sequence_info_per_group_id'));

  my $query_max_length_by_groupid = $dbh->prepare($self->getSql('max_length_per_group_id'));

  my $query_domains_by_sequenceid = $dbh->prepare($self->getSql('domains_info_per_sequence_id'));

  # Fetch max length, set params needed in order to generate images
  $query_max_length_by_groupid->execute($orthogroup_id);
  my @length_data=$query_max_length_by_groupid->fetchrow_array();
  my $length_max=$length_data[0];
  my $dom_height=14;
  my $spacer_height=15;
  my $margin_x = 10;
  my $margin_y = 40;
    my $scale_factor=0.7;
    my $tick_step=50; # generally 50 is used, but when $length_max is too big, ...
      if ($length_max>=2000) {
        $tick_step = int($length_max/2000)*100;
      }
  if ($length_max>1000) {
    $scale_factor = $scale_factor*(1000/$length_max);
  }
  my $size_x = $length_max*$scale_factor+2*$margin_x;
  my $size_y = $margin_y + $dom_height + $spacer_height;
    my $pos_y = $margin_y + $spacer_height + $dom_height/2;

    # Fetch sequences
    $query_sequence_by_groupid->execute($orthogroup_id);

    my @sequence_ids;
    my %domains_seen;
    while (my @sequence_data = $query_sequence_by_groupid->fetchrow_array()) {
  push(@sequence_ids,$sequence_data[0]);
  my %sequence;
  #my @sequence_ids;
  #my %domains_seen;
  $sequence{SEQUENCE_ACCESSION}=$sequence_data[1];
  $sequence{SEQUENCE_TAXON}=$sequence_data[4];
  $sequence{SEQUENCE_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=".$sequence{SEQUENCE_ACCESSION}."&taxon=".$sequence{SEQUENCE_TAXON};
  $sequence{SEQUENCE_LENGTH}=$sequence_data[3];
            
  my $sequence_image=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=drawProtein&margin_x=$margin_x&scale_factor=$scale_factor&pos_y=$pos_y&size_x=$size_x&size_y=$size_y&dom_height=$dom_height&length=$sequence_data[3]&length_max=$length_max&tick_step=$tick_step&margin_y=$margin_y&spacer_height=$spacer_height";

  #Fetch domains for sequence
  $query_domains_by_sequenceid->execute($sequence_data[0]);

  my $num_dom_in_sequence=0;
  while (my @domain_data = $query_domains_by_sequenceid->fetchrow_array()) {
    if (!exists $domains_seen{$domain_data[1]}) {
      $domains_seen{$domain_data[1]}='y';
      my %domain;
      $domain{DOMAIN_ACCESSION}=$domain_data[1];
      $domain{DOMAIN_LINK}=$config->{PFAM_link}.$domain{DOMAIN_ACCESSION};
      $domain{DOMAIN_NAME}=$domain_data[2];
      $domain{DOMAIN_DESCRIPTION}=$domain_data[3];
      push(@{$para{LOOP_DOMAIN}},\%domain);

      my $from = $domain_data[4];
      my $to = $domain_data[5];
      my $length=$to-$from;
      my $source_id = $domain_data[1];
      $domain{DOMAIN_IMAGE}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=drawDomain&length=200&scale_factor=$scale_factor&dom_height=$dom_height&source_id=$source_id";
    }

    $sequence_image = $sequence_image."&domain_from".$num_dom_in_sequence."=".$domain_data[4]."&domain_to".$num_dom_in_sequence."=".$domain_data[5]."&domain_source".$num_dom_in_sequence."=".$domain_data[1];
    $num_dom_in_sequence++;
  }
      
  #print STDERR "domain count: " . $num_dom_in_sequence ."\n";
            
  $sequence{SEQUENCE_IMAGE}=$sequence_image."&num_domains=".$num_dom_in_sequence;
           
  push(@{$para{LOOP_DOMARCH}},\%sequence);
}
    
# includes scale image in page  (the heading for the column w/sequence images
$para{SCALE_IMAGE}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=drawScale&size_x=$size_x&margin_x=$margin_x&scale_factor=$scale_factor&length_max=$length_max&tick_step=$tick_step&scale_color=white";

unless (keys(%domains_seen)) {
  $para{NOPFAM}=1;
}
        
my $tmpl = $self->load_tmpl('domarch_listing.tmpl');
$self->defaults($tmpl);
$tmpl->param(\%para);


# Timing info
$currentTime = clock_gettime(CLOCK_REALTIME);
print STDERR "End domarchList(): " . ($currentTime - $startTime) . ".\n";    

return $self->done($tmpl);
}

  sub sequence {
    my $self = shift;

    # Timing info
    $currentTime = clock_gettime(CLOCK_REALTIME);
    print STDERR "Begin sequence(): " . ($currentTime - $startTime) . ".\n";    

    my $config = $self->param("config");
    my $dbh = $self->dbh();
    my $q = $self->query();

    $dbh->{LongTruncOk} = 0;
    $dbh->{LongReadLen} = 100000000;

    my $taxon_abbrev = $q->param("taxon");
    my $sequence_accession = $q->param("accession");

    my %para;
    $para{PAGETITLE}="Sequence $sequence_accession";
    $para{TAXON_ABBREV}=$taxon_abbrev;
    
    # prepare data to fill out sequence page
    my $query_sequence = $dbh->prepare($self->getSql('sequence_info_per_source_id'));

    $query_sequence->execute($taxon_abbrev, $sequence_accession);
    my @data = $query_sequence->fetchrow_array();
    $para{ACCESSION}=$data[0];

    if (defined $data[1]) {
      my $source_id = $data[0];
      # only do this for pkn
      if ($taxon_abbrev eq "pkn") {
	$source_id =~ s/-\d+$//;
      }
      $para{XREF_LINK}=$data[1].$source_id;
    }

    $para{TAXON}=$data[2];
    my $orthogroup_old_ac;
    if ($data[3]) {
      $para{GROUP_ACCESSION}=$data[3];
      $para{GROUP_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupac=$data[3]";
      $orthogroup_old_ac = transformOGAC($para{GROUP_ACCESSION});
    } else {
      $para{GROUP_ACCESSION}='not clustered';
    }
    
    if ($data[4]) {
      chomp($para{DESCRIPTION}=$data[4]);
    }

    my $len = $data[5];
    $para{LENGTH}=$len;
    
    $para{SECONDARY_ACCESSION}=$data[6];
    
    my $seq = $data[7];
    my $previous_groups = $data[8];

    # display sequence
    $para{SEQUENCE} = "&gt;$taxon_abbrev|" . $para{ACCESSION} . " ";

    if ($para{DESCRIPTION}) {
      $para{SEQUENCE} .= $para{DESCRIPTION}." ";
    }
    $para{SEQUENCE} .= "[<i>".$para{TAXON}."</i>]\n";
    for (my $i=1;$i<=$len;$i+=60) {
      if ($i+60-1>$len) {
	$para{SEQUENCE} .= substr($seq, $i) ."\n";
      } else {
	$para{SEQUENCE} .= substr($seq, $i,60) . "\n";
      }
    }

    # prepare data to fill out domain architecture block
    #if (defined $orthogroup_old_ac) {
    #    my ($dd)=$orthogroup_old_ac=~/(\d{2})$/;
    #    unless ($dd) {
    #        ($dd)=$orthogroup_old_ac=~/(\d)$/;
    #        $dd="0$dd";
    #    }
    #    my ($a,$b)=split("",$dd);
    #}
    my $query_domarch_by_ac = $dbh->prepare($self->getSql('domain_arch_per_sequence_source_id'));
    $query_domarch_by_ac->execute($taxon_abbrev, $sequence_accession);

    my $length_max=$data[5];
    my $length=$data[5];
    my $dom_height=12;
    my $spacer_height=15;
    my $margin_x = 10;
    my $margin_y = 40;
    my $scale_factor=0.7;
    my $tick_step=50; # generally 50 is used, but when $length_max is too big, ...
      if ($length_max>=2000) {
        $tick_step = int($length_max/2000)*100;
      }
    if ($length_max>1000) {
      $scale_factor = $scale_factor*(1000/$length_max);
    }
    my $size_x = $length_max*$scale_factor+2*$margin_x;
    my $size_y = $margin_y + $dom_height + $spacer_height;
    my $pos_y = $margin_y + $spacer_height + $dom_height/2;
    
    my $sequence_image="/cgi-bin/OrthoMclWeb.cgi?rm=drawProtein&margin_x=$margin_x&scale_factor=$scale_factor&pos_y=$pos_y&size_x=$size_x&size_y=$size_y&dom_height=$dom_height&length=$length&length_max=$length_max&tick_step=$tick_step&margin_y=$margin_y&spacer_height=$spacer_height";

    my $num_dom_in_sequence=0;
    while (@data = $query_domarch_by_ac->fetchrow_array()) {
      my %domain;
      $domain{DOMAIN_START}=$data[0];
      $domain{DOMAIN_END}=$data[1];
      $domain{DOMAIN_ACCESSION}=$data[2];
      $domain{DOMAIN_LINK}=$config->{PFAM_link}.$domain{DOMAIN_ACCESSION};
      $domain{DOMAIN_NAME}=$data[3];
      $domain{DOMAIN_DESCRIPTION}=$data[4];
      push(@{$para{LOOP_DOMAIN}},\%domain);

      $sequence_image = $sequence_image."&domain_from".$num_dom_in_sequence."=".$data[0]."&domain_to".$num_dom_in_sequence."=".$data[1]."&domain_source".$num_dom_in_sequence."=".$data[2];
      $num_dom_in_sequence++;
    }

    $para{SCALE_IMAGE}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=drawScale&size_x=$size_x&margin_x=$margin_x&scale_factor=$scale_factor&length_max=$length_max&tick_step=$tick_step&scale_color=black";
    $para{SEQUENCE_IMAGE}=$config->{basehref} . $sequence_image . "&num_domains=" . $num_dom_in_sequence;

    $para{PREVIOUS_GROUPS}=$previous_groups;

    my $tmpl = $self->load_tmpl('sequencepage.tmpl');
    $self->defaults($tmpl);
    $tmpl->param(\%para);

    # Timing info
    $currentTime = clock_gettime(CLOCK_REALTIME);
    print STDERR "End sequence(): " . ($currentTime - $startTime) . ".\n";    

    return $self->done($tmpl);
  }

sub genome {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin genome(): " . ($currentTime - $startTime) . ".\n";    

  my $dbh = $self->dbh();
  my $q = $self->query();

  my %para;
  $para{PAGETITLE}="Release Summary";
  $para{VERSION} = $VERSION;

  my $query_num_taxa = $dbh->prepare($self->getSql('all_taxa_count'));
  $query_num_taxa->execute();
  my @tmp = $query_num_taxa->fetchrow_array();
  $para{NUM_TAXA}=$tmp[0];

  my $query_num_sequences = $dbh->prepare($self->getSql('all_sequences_count'));
  $query_num_sequences->execute();
  @tmp = $query_num_sequences->fetchrow_array();
  $para{NUM_SEQUENCES}=$tmp[0];

  my $type;
  if ($type = $q->param("type")) {
    if ($type eq 'data') {
      $para{FLAG_DATASOURCE}=1;
      $para{FLAG_URL}=1;
    } elsif ($type eq 'summary') {
      $para{FLAG_NUMSEQ}=1;
      $para{FLAG_NUMSEQ_CLUSTERED}=1;
      $para{FLAG_NUMGROUPS}=1;
    }
  } else {
    $para{FLAG_DESCRIPTION}=1;
  }
    
  my $query_taxon = $dbh->prepare($self->getSql('species_details'));

  my $query_numseq = $dbh->prepare($self->getSql('num_sequences_per_species'));

  my $query_numseqclustered = $dbh->prepare($self->getSql('num_clustered_sequences_per_species'));
    
  my $query_numgroup = $dbh->prepare($self->getSql('num_groups_per_species'));
  $query_taxon->execute();
  my $count=0;
  while (my @data = $query_taxon->fetchrow_array()) {
    $count++;
    my %taxon;
    $taxon{NUMBER}=$count;
    $taxon{NAME}=$data[1];
    $taxon{ABBREV}=$data[2];
    if (defined $type) {
      if ($type eq 'data') {
	$taxon{DATASOURCE}=$data[3];
	$taxon{URL}=$data[4];
      } elsif ($type eq 'summary') {
	my $taxonId = $data[0];
	$query_numseq->execute($taxonId);
	my @tmp = $query_numseq->fetchrow_array();
	$taxon{NUMSEQ}=$tmp[0];

print STDERR '++++++++++++++++ num_seq: ' . $taxon{NUMSEQ} . '\n';

	$query_numseqclustered->execute($taxonId);
	@tmp = $query_numseqclustered->fetchrow_array();
	$taxon{NUMSEQ_CLUSTERED}=$tmp[0];

print STDERR '++++++++++++++++ num_seq clustered: ' . $taxon{NUMSEQ_CLUSTERED} . '\n';

	$query_numgroup->execute($taxonId);
	@tmp = $query_numgroup->fetchrow_array();
	$taxon{NUMGROUPS}=$tmp[0];

print STDERR '++++++++++++++++ num_groups: ' . $taxon{NUMGROUPS} . '\n';
      }
    } else {
      $taxon{DESCRIPTION}=$data[5];
    }
    push(@{$para{LOOP_TAXON}},\%taxon);
  }

  my $tmpl = $self->load_tmpl('genomepage.tmpl');
  $self->defaults($tmpl);
  $tmpl->param(\%para);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End genome(): " . ($currentTime - $startTime) . ".\n";    

  return $self->done($tmpl);
}

sub MSA {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin MSA(): " . ($currentTime - $startTime) . ".\n";    

  my $config = $self->param("config");
  my $dbh = $self->dbh();
  my $q = $self->query();

  my %para;
  $para{CONTENT}="<pre>";
  if (my $ac = $q->param("groupac")) {
    $para{PAGETITLE}="MSA $ac";
        
    # in order to read clobs correctly
    $dbh->{LongTruncOk} = 0;
    $dbh->{LongReadLen} = 100000000;

    my $group_url = $config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupac=$ac";
        
    my $query_msa = $dbh->prepare($self->getSql('msa_per_group_name'));
    $query_msa->execute($ac);
    if (my @data = $query_msa->fetchrow_array()) {
      $para{T}="Multiple Sequence Alignment for Group <a href='$group_url'><font color=\"red\">$ac</font></a>";
      $para{CONTENT}.=$data[0];
    } else {
      # $para{ERROR}="The file '$file' doesn't exist. Please check it later because we are updating data currently."
      $para{ERROR}="The MSA result doesn't exist. Please check it later because we are updating data currently."
    }
  }

  my $tmpl = $self->load_tmpl('empty.tmpl');
  $self->defaults($tmpl);
  $tmpl->param(\%para);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End MSA(): " . ($currentTime - $startTime) . ".\n";    

  return $self->done($tmpl);
}

sub BLGraph {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin BLGraph(): " . ($currentTime - $startTime) . ".\n";    

  my $config = $self->param("config");
  my $dbh = $self->dbh();
  my $q = $self->query();

  $dbh->{LongTruncOk} = 0;
  $dbh->{LongReadLen} = 100000000;

  my $tmpl = $self->load_tmpl('empty.tmpl');

  my $ac = $q->param("groupac");
  my $group_url = $config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupac=$ac";
  my $bl_src = $config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=BLGraph&groupac=$ac";
  my %para;
  if ($q->param("svg")) {
    $para{PAGETITLE}="BioLayout Graph (SVG) for $ac";
    $para{T} = "BioLayout Graph (SVG) for Group <a href='$group_url'><font color=\"red\">$ac</font></a>";
    $para{CONTENT}="<div align=\"center\">
                        <embed src=\"$bl_src&svgdata=1\" width=\"800\" 
                               height=\"700\" type=\"image/svg+xml\"></embed>
                    </div>
                        <p>Notes: In this graph, nodes represent proteins (species are 
                           color-coded); edges stand for four edge relationships: 
                           <font color=\"red\">Ortholog edges</font>, <font color=\"yellow\">Coortholog edges</font>, 
                           <font color=\"green\">Inparalog edges</font>, 
                           and <font color=\"#555555\">Other edges</font>. You can 
                           switch these edges on and off by clicking the text in 
                           \"EDGES CONTROL\" box. Due to the large number of general 
                           edges, by default they are not shown until you switch them 
                           on. When you move your mouse over a certain node (or edge), 
                           associated information will be displayed in the \"INFORMATION\" 
                           box, the nodes from the same species will also be highlighted.</p>
                        <p>Click on a gene will show all edges from the gene, and hide the
                           rest of the edges.</p>";
    $self->defaults($tmpl);
  } elsif ($q->param("svgdata")) {
    $self->header_props(-type=>'image/svg+xml');

    # read the content of the svg
    my $query_content = $dbh->prepare($self->getSql('svg_content_per_group_name'));
    $query_content->execute($ac);
    my ($svg_content) = $query_content->fetchrow();
    $para{SVG_CONTENT}=$svg_content;

    $tmpl = $self->load_tmpl('svg.tmpl');
  } elsif ($q->param("image")) {
    # read the image of biolayout
    my $query_image = $dbh->prepare($self->getSql('biolayout_image_per_group_name'));
    $query_image->execute($ac);
    my ($bl_image) = $query_image->fetchrow();
            
    binmode STDOUT;
    print CGI::header("image/png");
    print $bl_image;

    # Timing info
    $currentTime = clock_gettime(CLOCK_REALTIME);
    print STDERR "End BLGraph(): " . ($currentTime - $startTime) . ".\n";    

    return;
  } else {
    $para{PAGETITLE}="BioLayout Graph for $ac";
    $para{T}="BioLayout Graph for Group <a href='$group_url'><font color=\"red\">$ac</font></a>";
    $para{CONTENT}="<p>Link to <a href=\"cgi-bin/OrthoMclWeb.cgi?rm=BLGraph&groupac=$ac&svg=1\">
                        <b>Interactive Graph (SVG)</b></a></font> <font size=\"1\">.    
                        You may need a <a href=\"http://www.adobe.com/svg/viewer/install/main.html\">
                        Scalable Vector Graphics Viewer</a></font>.</p>
                    <p><b>Notes</b>: In this image, nodes represent proteins, and proteins from the same 
                        species have identical color code; <br>
                        If two proteins form an edge (e-value better than 1e-5), the color
                        of the edge reflects how good the match is: scales from red to blue,
                        where pure red is the best match in the group, and pure blue is the
                        worst match.</p>
                    <p><img src=\"$bl_src&image=1\"><p>";
    $self->defaults($tmpl);
  }
  $tmpl->param(\%para);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End BLGraph(): " . ($currentTime - $startTime) . ".\n";    

  return $self->done($tmpl);
}

sub getSeq {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin getSeq(): " . ($currentTime - $startTime) . ".\n";    

  my $config = $self->param("config");
  my $dbh = $self->dbh();
  my $q = $self->query();

  $dbh->{LongTruncOk} = 0;
  $dbh->{LongReadLen} = 100000000;

  if ($q->param("groupid") || $q->param("groupac")) {
    my %para;
    my $groupac = $q->param("groupac");
    $para{PAGETITLE}="FASTA Sequences for $groupac";
    my $query_sequence = $dbh->prepare($self->getSql('sequence_info_per_group_name'));

    my $group_url = $config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupac=$groupac";

    $para{T}="FASTA Sequences for Group <a href='$group_url'><font color='red'>$groupac</font></a>";
    $query_sequence->execute($groupac);

    $para{CONTENT} = "<div class='sequence'><pre>";
    while (my @data = $query_sequence->fetchrow_array()) {
      my $ac = $data[0];
      chomp(my $desc = $data[1]);
      my $taxon = $data[2];
      my $len = $data[3];
      my $seq = $data[4];
      my $taxon_abbrev = $data[5];
      $para{CONTENT} .= "\n&gt;";
      $para{CONTENT} .= "$taxon_abbrev|$ac";
      if ($desc) {
	$para{CONTENT} .= " $desc";
      }
      $para{CONTENT} .= " [<i>$taxon</i>]\n";
      for (my $i=1;$i<=$len;$i+=60) {
	if ($i+60-1>$len) {
	  $para{CONTENT}.= substr($seq, $i)."\n";
	} else {
	  $para{CONTENT}.= substr($seq, $i, 60)."\n";
	}
      }
    }
    $para{CONTENT} .= "</pre></div>";

    my $tmpl = $self->load_tmpl('empty.tmpl');
    $self->defaults($tmpl);
    $tmpl->param(\%para);

    # Timing info
    $currentTime = clock_gettime(CLOCK_REALTIME);
    print STDERR "End getSeq(): " . ($currentTime - $startTime) . ".\n";    

    return $self->done($tmpl);
  } elsif (my $querynumber = $q->param("querynumber")) {
    my $sequence_query_history = $self->session->param("SEQUENCE_QUERY_HISTORY");
    my $sequence_query_ids_history = $self->session->param("SEQUENCE_QUERY_IDS_HISTORY");
    my $query_sequence = $dbh->prepare($self->getSql('history_sequence_info_per_sequence_id'));

    my $file_content;
    foreach my $sequence_id (@{$sequence_query_ids_history->[$querynumber-1]}) {
      $query_sequence->execute($sequence_id);
      my @data = $query_sequence->fetchrow_array();
      my $ac = $data[0];
      chomp(my $desc = $data[1]);
      my $taxon = $data[2];
      my $len = $data[3];
      my $seq = $data[4];
      my $taxon_abbrev = $data[5];
      $file_content.=">$taxon_abbrev|$ac $desc [$taxon]\r\n";
      for (my $i=1;$i<=$len;$i+=60) {
        if ($i+60-1>$len) {
          $file_content.= substr($seq, $i)."\r\n";
        } else {
          $file_content.= substr($seq, $i, 60)."\r\n";
        }
      }
    }

    my $file_name = 'OrthoMCL-DB_sequence_query_'.$querynumber.'.fasta';
    $self->header_props(
			-type=>'text/plain',
			'-Content-Disposition'=>'attachment; filename="'.$file_name.'"');

    # Timing info
    $currentTime = clock_gettime(CLOCK_REALTIME);
    print STDERR "End getSeq(): " . ($currentTime - $startTime) . ".\n";    

    return $file_content;
  }
}

sub blast {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin blast(): " . ($currentTime - $startTime) . ".\n";    

  my $config = $self->param("config");
  my $q = $self->query();
  my $dbh = $self->dbh();

  my $tmpl = $self->load_tmpl('empty.tmpl');
  $self->defaults($tmpl);

  my $querynumber;
  my $sequence_ids_ref;	# store all the sequence ids for current query

  my %para;
  $para{CONTENT}="<pre>";
  $para{PAGETITLE}="BLASTP Result";

  if (my $fasta = $q->param("q")) {
    my $fasta_name;
    if ($fasta=~/^\>(\S+)/) {
      $fasta_name=$1;
    } else {
      $fasta_name='<unknown sequence>';
    }
    $para{PAGETITLE}="BLASTP Result for $fasta_name";

    $para{T}="BLASTP result for <font color=\"red\">$fasta_name</font>";
    my $query_time = $dbh->prepare('SELECT SYSDATE FROM dual');
    $query_time->execute();
    my @tmp = $query_time->fetchrow_array();
    my $time=$tmp[0];

    use File::Temp qw(tempfile);
    my ($fh, $tempfile) = tempfile(DIR => "/tmp");
    print $fh $fasta;
    close($fh);
    $ENV{BLASTMAT} = $config->{BLASTMAT};
    my $blastcmd = "$config->{BLAST} -p blastp -i $tempfile -d $config->{FA_file} -e 1e-5";

    #print STDERR "BLAST: " . $blastcmd . '\n';

    open(BLAST, "$blastcmd |") or die $!;

    my $query_group = $dbh->prepare($self->getSql('group_name_per_sequence_source_id'));

    my $query_sequence = $dbh->prepare($self->getSql('sequence_per_source_id_and_taxon'));
    
    my %seqsAlreadySeen;
    while (<BLAST>) {
      $_=~s/\r|\n//g;
      my $line = $_;

      my $taxon_abbrev;
      my $seq_source_id;
      my $full_seq_source_id;
      my $grp_source_id;

      # fix the invalid group name
      $line =~ s/OG${VERSION}0_/OG${VERSION}_/g;

      # grab seq source id
      if ($line =~ /([a-z]{3,4})\|(\S+)/) {
	$taxon_abbrev = $1;
	$seq_source_id = $2;
	$full_seq_source_id = "$taxon_abbrev|$seq_source_id";

        # grab group source id, and register seq as having a group
        if ($line =~ /(OG${VERSION}_\d+)/) {
          $grp_source_id = $1;
          # register sequence_id for history (unless already registered)
          if (!$seqsAlreadySeen{$full_seq_source_id}) {
            my $sequence_id;
            $query_sequence->execute($seq_source_id, $taxon_abbrev, $full_seq_source_id);
            ($sequence_id) = $query_sequence->fetchrow_array();
            push(@{$sequence_ids_ref}, $sequence_id);
            $seqsAlreadySeen{$full_seq_source_id} = 1;
          }
        } elsif  ($line =~ /(no_group)/ || $line =~ /(no group)/) {
          $grp_source_id = "$1 ";
        }

        # swap position of group and seq source ids
        $line =~ s/$taxon_abbrev\|$seq_source_id/GROUP_SRC_ID/;
        $line =~ s/$grp_source_id/SEQ_SRC_ID/;

        # replace abbrev|source_id with hyperlink
        my $full_seq_source_id_href =qq{<a href="$config->{basehref}/cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=$seq_source_id&taxon=$taxon_abbrev">$full_seq_source_id</a>};
        $line =~ s/SEQ_SRC_ID/$full_seq_source_id_href/;

        # replace group source_id w/ hyperlink and register sequence_id 
        my $grp_source_id_href =  qq{<a href="$config->{basehref}/cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupac=$grp_source_id">$grp_source_id</a>};
        $grp_source_id_href = $grp_source_id if $grp_source_id =~ 'no';
        $line =~ s/GROUP_SRC_ID/$grp_source_id_href/;
      }
      
      $para{CONTENT} .= "$line\n";
    }

    close(BLAST);
    unlink($tempfile);

    if (not defined $sequence_ids_ref) {
      $sequence_ids_ref=[];
    }

    my $sequence_query_history = $self->session->param("SEQUENCE_QUERY_HISTORY") || [];
    push(@{$sequence_query_history},{
				     CODE   => $fasta_name,
				     TYPE   => 'BLAST',
				     TIME   => $time,
				     NUMHITS=> scalar(@{$sequence_ids_ref}),
				     SHOW   => 1,
				    });
    $self->session->param("SEQUENCE_QUERY_HISTORY",$sequence_query_history);

    my $sequence_query_ids_history = $self->session->param("SEQUENCE_QUERY_IDS_HISTORY") || [];
    push(@{$sequence_query_ids_history},$sequence_ids_ref);
    $self->session->param("SEQUENCE_QUERY_IDS_HISTORY",$sequence_query_ids_history);

    $querynumber=scalar(@{$sequence_query_history});
    $self->session->param('SEQUENCE_QUERY_NUMBER',$querynumber); # store the current querynumber for later paging

  } else {
    $para{ERROR}="Please provide protein sequence for BLASTP!";
  }


  $tmpl->param(\%para);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End blast(): " . ($currentTime - $startTime) . ".\n";    

  return $self->done($tmpl);
}

sub sourceIdToColors {
  my ($self, $sourceId) = @_;

  if (index($sourceId,'IPR0') >= 0) {
    $sourceId = '2'.substr($sourceId,4);
  } elsif (index($sourceId,'PF') >= 0) {
    $sourceId = '1'.substr($sourceId,2);
  }
    
  srand($sourceId);
    
  return (getRGBColor(), getRGBColor(6));
}

sub getRGBColor {
  my $cut=$_[0];

  my @color_rgb;
  my $r;
  my $g;
  my $b;

  do {
    $r = sprintf('%x', (rand(256) % 6) * 3);
    $g = sprintf('%x', (rand(256) % 6) * 3);
    do {
      $b = sprintf('%x', (rand(256) % 6) * 3);
    } while ($r==$g && $g==$b);
  } while ($cut > 0 && (($r < $cut && $g < $cut) || ($r < $cut && $b < $cut) || ($g < $cut && $b < $cut)));
  #} while ($cut>0 && ($r < $cut || $g<$cut || $b < $cut));

  #if ($r==$g) {
  #while ($g==$b) {
  #    $b = sprintf('%x', (rand(256) % 6) * 3);
  #}
  #}
        
    
  $color_rgb[0] = hex($r.$r);
  $color_rgb[1] = hex($g.$g);
  $color_rgb[2] = hex($b.$b);
    
  return \@color_rgb;
}

#sub drawDomain {
#}

sub drawDomain {
  my $self = shift;
  my $q = $self->query();
    
  my $length = $q->param("length");
  my $source_id = $q->param("source_id");
  my $scale_factor = $q->param("scale_factor");
  my $dom_height = $q->param("dom_height");
  my $color1;
  my $color2;

  ($color1,$color2)=$self->sourceIdToColors($source_id);

  # domain image
  my $domain_image = new GD::Image($length*$scale_factor+1,$dom_height+1);
  my $domain_bg = $domain_image->colorAllocate(1,1,1);
  my $domain_black = $domain_image->colorAllocate(0,0,0);
  my $domain_inside = $domain_image->colorAllocate($color1->[0],$color1->[1],$color1->[2]);
  my $domain_outside = $domain_image->colorAllocate($color2->[0],$color2->[1],$color2->[2]);
    
  $domain_image->transparent($domain_bg);
  $domain_image->filledRectangle(0,0,$length*$scale_factor,$dom_height,$domain_outside);
  $domain_image->rectangle(0,0,$length*$scale_factor,$dom_height,$domain_black);
  $domain_image->filledRectangle(3,3,$length*$scale_factor-4,$dom_height-3,$domain_inside);
  $domain_image->rectangle(3,3,$length*$scale_factor-4,$dom_height-3,$domain_black);
    
  print CGI::header("image/png"), $domain_image->png(9);
}

#sub drawProtein {
#}

sub drawProtein {
  my $self = shift;
  my $q = $self->query();
    
  my $margin_x = $q->param("margin_x");
  my $scale_factor = $q->param("scale_factor");
  my $pos_y = $q->param("pos_y");
    my $size_x = $q->param("size_x");
    my $size_y = $q->param("size_y");
  my $dom_height = $q->param("dom_height");
  my $length = $q->param("length");
  my $length_max = $q->param("length_max");
  my $tick_step = $q->param("tick_step");
  my $num_domains = $q->param("num_domains");

  my @domain_info;

  my $image = new GD::Image($size_x,$dom_height+1);

  my $image_bg = $image->colorAllocate(1,1,1);
  my $image_black = $image->colorAllocate(0,0,0);
  my $image_gray = $image->colorAllocate(153,153,153);
  my $image_dkgray = $image->colorAllocate(102,102,102);

  $image->transparent($image_bg);

  my $tick_len=4;
  for (my $i=0;$i<=$length_max;$i+=$tick_step) {
    $image->line($margin_x+$i*$scale_factor,0,$margin_x+$i*$scale_factor,$dom_height,$image_gray);
  }

  $image->filledRectangle($margin_x+1,$dom_height/2-2,$margin_x+$length*$scale_factor,$dom_height/2+2,$image_dkgray);
     
  for (my $i=0;$i<$num_domains;$i++) {
    my $from = $q->param("domain_from$i");
    my $to = $q->param("domain_to$i");
    my $domain_source = $q->param("domain_source$i");
    my $color1;
    my $color2;

    ($color1,$color2)=$self->sourceIdToColors($domain_source);
    my $domain_inside = $image->colorAllocate($color1->[0],$color1->[1],$color1->[2]);
    my $domain_outside = $image->colorAllocate($color2->[0],$color2->[1],$color2->[2]);
    
    $image->filledRectangle($margin_x+$from*$scale_factor,0,$margin_x+$to*$scale_factor,$dom_height,$domain_outside);
    $image->rectangle($margin_x+$from*$scale_factor,0,$margin_x+$to*$scale_factor,$dom_height,$image_black);
    $image->filledRectangle($margin_x+$from*$scale_factor+3,3,$margin_x+$to*$scale_factor-4,$dom_height-3,$domain_inside);
    $image->rectangle($margin_x+$from*$scale_factor+3,3,$margin_x+$to*$scale_factor-4,$dom_height-3,$image_black);
  }
    
  print CGI::header("image/png"), $image->png(9);
}

#sub drawScale {
#}

sub drawScale {
  my $self = shift;
  my $q = $self->query();

  my $size_x = $q->param("size_x");
  my $margin_x = $q->param("margin_x");
  my $scale_factor = $q->param("scale_factor");
  my $length_max = $q->param("length_max");
  my $tick_step = $q->param("tick_step");
  my $scale_color = $q->param("scale_color");

    
  #cluster scale image  # with white/grey line and string # used in OrthoMCL DB
  my $image = new GD::Image($size_x,20);
  my $image_bg = $image->colorAllocate(1,1,1);
  my $image_color;
  if ($scale_color eq "white") {
    $image_color = $image->colorAllocate(255,255,255);
  } else {
    $image_color = $image->colorAllocate(0,0,0);
  }

  $image->transparent($image_bg);
  $image->line($margin_x,4,$margin_x+$length_max*$scale_factor,4,$image_color);
  my $tick_len=4;
  for (my $i=0;$i<=$length_max;$i+=$tick_step) {
    $image->line($margin_x+$i*$scale_factor,4,$margin_x+$i*$scale_factor,4+$tick_len,$image_color);
    if ($tick_len==4) {
      $image->string(gdTinyFont,$margin_x+$i*$scale_factor-1.5-(length($i)-1)*5/2,4+5,$i,$image_color);
      $tick_len=2;
    } else {
      $tick_len=4;
    }
  }
  print CGI::header('image/png'), $image->png(9);
}

sub transformOGAC {
  # OG1_100
  my $a = $_[0];
  return 'ORTHOMCL'.(split(/\_/,$a))[1];
}

sub orthomcl {
  my $self = shift;
  # Get our database connection
  my $dbh = $self->dbh();


  my $tmpl = $self->load_tmpl('orthomcl.tmpl');
  $self->defaults($tmpl);
  return $self->done($tmpl);
}

sub defaults {

  my ($self, $tmpl) = @_;

  my $config = $self->param("config");
  $tmpl->param(BASEHREF => $config->{basehref});
  $tmpl->param(PAGETITLE => "OrthoMCL Database") unless $tmpl->param("PAGETITLE");
}

sub done {

  my ($self, $tmpl) = @_;
  return $tmpl->output;
}

sub getSql {
  my ($self, $name, $argsHash) = @_;

  if (!$self->{queryNameHash}) {
    my $gbrowseConfig = ApiCommonWebsite::Model::SqlXmlParser::parseSqlXmlFile("$ENV{GUS_HOME}/lib/xml/orthomclSqlDict.xml");
    #my $gbrowseConfig = &ApiCommonWebsite::Model::SqlXmlParser::parseSqlXmlFile($gbrowseFile, $showParseG);
    ($self->{queryNameHash}, $self->{queryNameArray}) = &getQueryNameHash($gbrowseConfig);

  }

  my $sqlString = $self->{queryNameHash}->{$name}->{sql}->[0] || die "sql dictionary doesn't contain entry for '$name'";
  my @macros = ($sqlString =~ /\$(\w+)/g);
  scalar(@macros) == scalar(keys(%$argsHash)) || die "wrong number of values";
  foreach my $macro (@macros) { 
    $argsHash->{$macro} || die "sql $name has '\$$macro' but no value found for it";
    $sqlString =~ s/\$$macro/$argsHash->{$macro}/g;
  }

  return $sqlString;
}


sub getQueryNameHash {
  my ($gbrowseConfig) = @_;

  my $qnh = {};
  my @qna;
  foreach my $module (@{$gbrowseConfig->{module}}) {
    foreach my $sqlQuery (@{$module->{sqlQuery}}) {
      push(@qna, $sqlQuery->{name}->[0]);
      $qnh->{$sqlQuery->{name}->[0]} = $sqlQuery;
    }
  }
  return ($qnh,\@qna);
}


sub proteomeUploadForm {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin proteomeUploadForm(): " . ($currentTime - $startTime) . ".\n";

  my $q = $self->query();

  my $tmpl = $self->load_tmpl("proteomeUploadForm.tmpl");
  $self->defaults($tmpl);

  $tmpl->param(PAGETITLE => "Upload your own Proteome");
  $tmpl->param(UPLOAD => 1);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End proteomeUploadForm(): " . ($currentTime - $startTime) . ".\n";

  return $self->done($tmpl);

}


sub proteomeQuery {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin proteomeQuery(): " . ($currentTime - $startTime) . ".\n";

  my $q = $self->query();
  my $file_name = $q->param("seq_file");
  my $email = $q->param("email");
  my $job_name = $q->param("job_name");

  if ( !$file_name ) {
    print $q->header ( );
    print "There was a problem uploading your photo (try a smaller file).";
    exit;
  }

  # determine a new job directory
  my $config = $self->param("config");
  my $job_dir = $config->{proteome_job_dir};

  my $job_id;
  while(1) {
    $job_id = '';
    for (my $i = 0; $i < 12; $i++) {
      my $number = int(rand(36));
      my $digit = chr(($number < 10) ? $number + 48 : $number + 55); 
      $job_id = $job_id . $digit;
    }
    if (-d "$job_dir/$job_id") { ; } else { last; };
  }
  my $upload_dir = $job_dir . "/" . $job_id;

  #print STDERR "making job dir: " . $upload_dir . "\n";

  my $old_umask = umask 0;
  mkdir $upload_dir;
  umask $old_umask;

  # upload sequence file
  my $seq_file_handle = $q->upload("seq_file");
  open ( UPLOADFILE, ">$upload_dir/orig_proteome.fasta" ) or die "$!";
  binmode UPLOADFILE;

  while ( <$seq_file_handle> ) {
    print UPLOADFILE;
  }
  close UPLOADFILE;

  # create index file 
  open ( INDEXFILE, ">$upload_dir/info.txt" ) or die "$!";
  print INDEXFILE "email=$email\n";
  print INDEXFILE "fastaFileName=$file_name\n";
  print INDEXFILE "submitted=" . localtime() . "\n";
  print INDEXFILE "jobName=$job_name\n";
  print INDEXFILE "jobId=$job_id\n";
  close INDEXFILE;

  my $tmpl = $self->load_tmpl("proteomeUploadForm.tmpl");
  $self->defaults($tmpl);

  $tmpl->param(PAGETITLE => "Your Proteome sequence is uploaded");
  $tmpl->param(RESULT => 1);
  $tmpl->param(EMAIL => $email);
  $tmpl->param(FILE_NAME => $file_name);
  $tmpl->param(JOB_NAME => $job_name);

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End proteomeQuery(): " . ($currentTime - $startTime) . ".\n";

  return $self->done($tmpl);

}

sub edgeList {
  my $self = shift;

  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "Begin edgeList(): " . ($currentTime - $startTime) . ".\n";

  my $tmpl = $self->load_tmpl("edge_list.tmpl");
  $self->defaults($tmpl);
  my %para;

  my $config = $self->param("config");
  my $dbh = $self->dbh();
  my $q = $self->query();

  $dbh->{LongTruncOk} = 0;
  $dbh->{LongReadLen} = 100000000;

  my $ac = $q->param("groupac");
                                     
  # read all edges
  my $query_edges_by_group = $dbh->prepare($self->getSql('edges_per_group_name'));
  $query_edges_by_group->execute($ac);
  while (my @data = $query_edges_by_group->fetchrow_array()) {
    my %edge;
    $edge{QUERY_SEQ}=$data[0];
    $edge{SUBJECT_SEQ}=$data[1];
    $edge{QUERY_TAXON}=$data[2];
    $edge{SUBJECT_TAXON}=$data[3];
    $edge{SCORE}=$data[4];
    $edge{NORMALIZED_SCORE}=$data[5];
    $edge{EVALUE_MANT}=$data[6];
    $edge{EVALUE_EXP}=$data[7];
    $edge{TYPE}=$data[8];
    push(@{$para{LOOP_EDGE}},\%edge);
  }
  $tmpl->param(\%para);


  # Timing info
  $currentTime = clock_gettime(CLOCK_REALTIME);
  print STDERR "End edgeList(): " . ($currentTime - $startTime) . ".\n";

  return $self->done($tmpl);

}



1;			# Perl requires this at the end of all modules

