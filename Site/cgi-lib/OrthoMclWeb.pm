package OrthoMclWeb;

use strict;

BEGIN {
  $ENV{PATH} = "";
}

use base 'CGI::Application';
use DBI;     # Needed for OrthoMCL database connection
use CGI;
use CGI::Application::Plugin::DBH qw(dbh_config dbh dbh_default_name);
use CGI::Application::Plugin::Session;
use File::Spec ();
use YAML qw(LoadFile);
use CommandQueryPhyPat;
use FunKeyword;
use GD;

my $debug=0;
our $config;

my %colors = (# "Web Colors" Set #1
	      'red', [255,0,0],
	      'green', [0,255,0],
	      'blue', [0,0,255],
	      # "Web Colors" Set #2
	      'yellow', [255,255,0],
	      'magenta', [255,0,255],
	      'cyan', [0,255,255],
	      # "Web Colors" Set #3
	      'maroon', [128,0,0],
	      'green', [0,128,0],
	      'navy', [0,0,128],
	      # "Web Colors" Set #4
	      'olive', [128,128,0],
	      'purple', [128,0,128],
	      'teal', [0,128,128],
	      # Non-Web Set #1
	      'brown', [153,51,51],
	      'green2', [51,153,51],
	      'blue2', [51,51,153],
	      # Non-Web Set #2
	      'pink', [255,20,147],
	      'blue3', [20,147,255],
	      'green3', [147,255,20],
	      # Non-Web Set #3
	      'goldenrod', [255,153,51],
	      'purple', [153,51,255],
	      'green4', [51,255,153],
	      # Non-Web Set #4
	      'blue4', [123,104,238],
	      'orange', [255,204,102],
	      'purple2', [204,102,255],
	      # Non-Web Set #5
	      'purple3', [204,174,255],
	      'green5', [204,255,165],
	      'gold', [255,228,165],
	      # Non-Web Set #6
	      'green6', [192,192,75],
	      'magenta2', [192,75,192],
	      'aquamarine', [75,192,192],
	      # Non-Web Set #7
	      'green7', [0,255,102],
	      'purple4', [102,0,255],
	      'orange2', [255,102,0],
	      # Non-Web Set #8
	      'orange3', [255,51,51],
	      'green8', [51,255,51],
	      'blue5', [51,51,255],
	      # Non-Web Set #9
	      'eggplant', [102,0,102],
	      'green9', [0,102,102],
	      'orange4', [102,102,0],
	      # Non-Web Set #10
	      'orange5', [153,0,51],
	      'purple5', [51,0,153],
	      'green10', [0,153,51],
	      # Non-Web Set #11
	      'purple6', [153,102,204],
	      'green11', [102,204,153],
	      'orange6', [204,153,102],
	      # Non-Web Set #12
	      'green12', [204,204,0],
	      'purple7', [204,0,204],
	      'aquamarine2', [0,204,204],
	      # Non-Web Set #13
	      'rust', [204,51,0],
	      'green13', [0,204,51],
	      'blue6', [51,0,204],
	      # Non-Web Set #14
	      'orange6', [255,51,51],
	      'green14', [51,255,51],
	      'blue7', [51,51,255],
	      # Non-Web Set #15
	      'orange7', [255,204,102],
	      'blue8', [102,204,255],
	      'purple8', [204,102,255],
	      # "Web Colors" Reserved
	      'white', [255,255,255],
	      'gray', [102,102,102],
	      'black', [0,0,0]);

sub cgiapp_init {
	my $self = shift;

	$config = LoadFile("../cgi-lib/config.yaml");
	$self->param(config => $config);

	$self->dbh_config('orthomcl', 
                          [ $config->{database}, 
                            $config->{user}, 
                            $config->{password},
                            {RaiseError => 1, PrintWarn => 1, PrintError => 1}
					  ]);
	$self->dbh_default_name("orthomcl");

	# Configure the session
	#$self->session_config(
	#   CGI_SESSION_OPTIONS => [ "driver:Oracle", $self->query, {Handle=>$self->dbh()} ],
	#   SEND_COOKIE         => 1,
	#);
	$self->session_config(
	   CGI_SESSION_OPTIONS => [ "driver:File", $self->query, {Directory=>File::Spec->tmpdir} ],
	   SEND_COOKIE         => 1,
	);
}


sub setup {
	my $self = shift;
	$self->tmpl_path('./tmpl');
	$self->start_mode('index');
	$self->run_modes([qw(index
	                     groupQueryForm sequenceQueryForm
			     groupList sequenceList
			     domarchList
			     sequence blast genome
			     groupQueryHistory sequenceQueryHistory
			     orthomcl drawScale drawDomain drawProtein
			     MSA BLGraph getSeq
			     querySave queryTransform)
			   ]);
}

sub index {
  my $self = shift;
  my $dbh = $self->dbh();
  my $config = $self->param("config");
  my $tmpl = $self->load_tmpl("index.tmpl");
  $self->defaults($tmpl);

  my %para;
  my @tmp;

  # my $query_num_taxa = $dbh->prepare('SELECT COUNT(*) FROM taxon');
  my $query_num_taxa = $dbh->prepare('SELECT count(*) FROM (SELECT DISTINCT external_database_release_id FROM DoTS.ExternalAaSequence) f');
  $query_num_taxa->execute();
  @tmp = $query_num_taxa->fetchrow_array();
  $para{NUM_TAXA}=$tmp[0];

  # my $query_num_sequences = $dbh->prepare('SELECT COUNT(*) FROM sequence');
  my $query_num_sequences = $dbh->prepare('SELECT count(*) FROM DoTS.ExternalAaSequence');
  $query_num_sequences->execute();
  @tmp = $query_num_sequences->fetchrow_array();
  $para{NUM_SEQUENCES}=$tmp[0];

  # my $query_num_groups = $dbh->prepare('SELECT COUNT(*) FROM orthogroup');
  my $query_num_groups = $dbh->prepare('SELECT count(*) FROM ApiDB.OrthologGroup');
  $query_num_groups->execute();
  @tmp = $query_num_groups->fetchrow_array();
  $para{NUM_GROUPS}=$tmp[0];
  $para{PAGETITLE}="OrthoMCL Database Home";

  my $file=$config->{NEWS_file};
  if (-e $file) {
    open(F,$file);
    while (<F>) {
      $_=~s/\r|\n//g;
      push(@{$para{LOOP_NEWS}},{NEWS=>$_});
    }
    close(F);
  }

  $para{LEFTNAV}=1;
  $tmpl->param(\%para);

  return $self->done($tmpl);
}

sub groupQueryForm {
	my $self = shift;
	my $dbh = $self->dbh();
	my $q = $self->query();
	my $type=$q->param("type");  # query type: ppexpression, ppform, property

	my $tmpl = $self->load_tmpl("groupqueryform.tmpl");
	$self->defaults($tmpl);

#	$tmpl->param(LEFTNAV => 1);

	if ($type eq 'ackeyword') {
		$tmpl->param(PAGETITLE => "Query OrthoMCL Groups By Accession / Keyword");
		$tmpl->param(ACKEYWORD => 1);
	} elsif ($type eq 'ppform') {
		$tmpl->param(PAGETITLE => "Query OrthoMCL Groups By Phyletic Pattern Form");
		$tmpl->param(PPFORM => 1);
	} elsif ($type eq 'property') {
		$tmpl->param(PAGETITLE => "Query OrthoMCL Groups By Group Properties");
		$tmpl->param(PROPERTY => 1);
	} else {
		$tmpl->param(PAGETITLE => "Query OrthoMCL Groups By PPE (Phyletic Pattern Expression)");
		$tmpl->param(PPEXPRESSION => 1);

		my %para;
		# my $query_taxon = $dbh->prepare('SELECT abbrev, name FROM taxon');
		my $query_taxon = $dbh->prepare('SELECT DISTINCT tn.unique_name_variant AS abbrev, 
		                                        tn.unique_name_variant AS name 
		                                 FROM sres.TaxonName tn, dots.ExternalAaSequence eas 
		                                 WHERE tn.taxon_id = eas.taxon_id');
		$query_taxon->execute();
		my $count=0;
		my @prev_data;
		while (my @data = $query_taxon->fetchrow_array()) {
			$count++;
			if ($count%2==0) {    # which means every tr has two td
				push(@{$para{LOOP_TR}},{LOOP_TD=>[
						{ABBREV=>$prev_data[0],NAME=>$prev_data[1]},
						{ABBREV=>$data[0],NAME=>$data[1]}
					]});
			}
			@prev_data=@data;
		}
		if ($count%2) {
			push(@{$para{LOOP_TR}},{LOOP_TD=>[
					{ABBREV=>$prev_data[0],NAME=>$prev_data[1]}
				]});
		}

		push(@{$para{LOOP_GROUPTR}},
			{LOOP_GROUPTD=>[{ABBREV=>'API',NAME=>'all apicomplexan genomes'}]},
			{LOOP_GROUPTD=>[{ABBREV=>'BAC',NAME=>'all Bacterial genomes'}]},
			{LOOP_GROUPTD=>[{ABBREV=>'ARC',NAME=>'all Archaeal genomes'}]},
			{LOOP_GROUPTD=>[{ABBREV=>'EUK',NAME=>'all Eukaryotic genomes'}]},
			{LOOP_GROUPTD=>[{ABBREV=>'OTHER',NAME=>'genomes not specified in the expression'}]},
			);
	
		

		$tmpl->param(\%para);
	}

	return $self->done($tmpl);
}

sub sequenceQueryForm {
	my $self = shift;
	my $q = $self->query();
	my $type=$q->param("type");  # query type: keyword or blast

	my $tmpl = $self->load_tmpl("sequencequeryform.tmpl");
	$self->defaults($tmpl);

#	$tmpl->param(LEFTNAV => 1);

	if ($type eq 'blast') {
		$tmpl->param(PAGETITLE => "Query Protein Sequences By BLAST Search");
		$tmpl->param(BLAST => 1);
	} else {
		$tmpl->param(PAGETITLE => "Query Protein Sequences By Accession/Keyword");
		$tmpl->param(ACKEYWORD => 1);
	}

	return $self->done($tmpl);
}

sub querySave {
	my $self = shift;
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
			# $query_accession_string = 'SELECT sequence.name,orthogroup.accession,taxon.name FROM taxon INNER JOIN sequence USING (taxon_id) LEFT JOIN orthogroup USING (orthogroup_id) WHERE sequence_id = ?';
			$query_accession_string = 'SELECT DISTINCT eas.source_id, og.name, tn.unique_name_variant 
			                           FROM dots.ExternalAaSequence eas, apidb.OrthologGroup og, 
			                                apidb.OrthologGroupAaSequence ogs, sres.TaxonName tn 
			                           WHERE tn.taxon_id = eas.taxon_id 
			                             AND eas.aa_sequence_id = ogs.aa_sequence_id(+)
			                             AND ogs.ortholog_group_id = og.ortholog_group_id(+)
			                             AND eas.aa_sequence_id = ?';
		} elsif ($type eq 'group') {
			$query_ids_history = $self->session->param("GROUP_QUERY_IDS_HISTORY");
			# $query_accession_string = 'SELECT accession FROM orthogroup WHERE orthogroup_id = ?';
			$query_accession_string = 'SELECT og.name FROM apidb.OrthologGroup of WHERE ortholog_group_id = ?';
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
	return $file_content;
}

sub queryTransform {
	my $self = shift;
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
		my $query_group = $dbh->prepare("SELECT ogs.ortholog_group_id 
		                                 FROM apidb.OrthologGroupAaSequence ogs 
		                                 WHERE ogs.aa_sequence_id = ?");
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
		push(@{$group_query_history},{	CODE   =>$action_description,
								TYPE   =>'Query Transform',
								TIME   =>$time,
								NUMHITS=>scalar(@result_ids),
								SHOW   =>1,
								});
		$self->session->param("GROUP_QUERY_HISTORY",$group_query_history);
		push(@{$group_query_ids_history},\@result_ids);
		$self->session->param("GROUP_QUERY_IDS_HISTORY",$group_query_ids_history);
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
		my $query_sequence = $dbh->prepare("SELECT ogs.aa_sequence_id 
		                                    FROM apidb.OrthologGroupAaSequence ogs 
		                                    WHERE ortholog_group_id = ?");
		foreach (keys %group_ids) {
			next if ($_==0); # (groupid is zero) means not clustered
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
		return "Redirecting to Sequence Query History";
	}
}

sub groupQueryHistory {
	my $self = shift;
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
			if ($present_ids{$_}==scalar(@select)) {push(@result_ids,$_);}
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
		    foreach (@{$group_query_ids_history->[$b-1]}) {$b_ids{$_}=1;}
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
			push(@{$group_query_history},{	CODE   =>$action_description,
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
#	    $q->param(-file=>'');
#	    $q->clear("file");#otherwise, there will be errors generated like "Do not know how to reconstitute blessed object of base type GLOB"
	    $filename=~s/.*[\/\\](.*)/$1/g;
		my $group_query_ids_history = $self->session->param("GROUP_QUERY_IDS_HISTORY");
		my $query_orthogroupid = $dbh->prepare('SELECT og.ortholog_group_id 
		                                        FROM apidb.OrthologGroup og 
		                                        WHERE og.name = ?');
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
		push(@{$group_query_history},{	CODE   =>$filename,
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

	if ($number_history==0) {$para{NO_HISTORY}=1;}

	my $tmpl = $self->load_tmpl('group_queryhistory.tmpl');  # loading template
	$self->defaults($tmpl);
	$tmpl->param(\%para);
	return $self->done($tmpl);
}

sub groupList {
	my $self = shift;
	my $q = $self->query();
	my $dbh = $self->dbh();

	my $tmpl = $self->load_tmpl('group_listing.tmpl');  # loading template
	$self->defaults($tmpl);

	my %para;   # the parameters to fill in the html template
	$para{PAGETITLE}="OrthoMCL Group List";

	my $group_query_history = $self->session->param("GROUP_QUERY_HISTORY") || [];
	my $group_query_ids_history = $self->session->param("GROUP_QUERY_IDS_HISTORY") || [];

	my $querynumber;
	my $querycode;
	my $orthogroup_ids_ref=[];
	my $debug_info;
#	my ($orthogroup_ids_ref,$debug_info);  # store all the orthogroup ids for current query

	if (my $querytype = $q->param('type')) {   # initiate a new query
		#dealing with query time
		my $query_time = $dbh->prepare('SELECT SYSDATE FROM dual');
		$query_time->execute();
		my @tmp = $query_time->fetchrow_array();
		my $time=$tmp[0];
		if ($querytype eq 'ppexpression') {
			if ($querycode = $q->param("q")) {
				($orthogroup_ids_ref,$debug_info)=CommandQueryPhyPat::query_phy_pat($querycode,$dbh);
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
				if ($in eq 'Accession') {
					my @qc=split(" ",$querycode);
					foreach (@qc) {
						my $query_orthogroup = $dbh->prepare('SELECT og.ortholog_group_id 
						                                      FROM apidb.OrthologGroup og 
						                                      WHERE og.name = ?');
						$query_orthogroup->execute($_);
						while (my @data = $query_orthogroup->fetchrow_array()) {
							push(@{$orthogroup_ids_ref},$data[0]);
						}
					}
				} else {
				    my $query_string;
				    if ($in eq 'Keyword') {
#					my $query_string = "SELECT orthogroup.orthogroup_id FROM orthogroup INNER JOIN sequence USING (orthogroup_id) WHERE orthogroup.orthogroup_id <> 0 AND sequence.description LIKE '%".$querycode."%' GROUP BY orthogroup.orthogroup_id";
					# $query_string = "SELECT orthogroup.orthogroup_id FROM orthogroup INNER JOIN sequence USING (orthogroup_id) WHERE orthogroup.orthogroup_id <> 0 AND MATCH (sequence.description) AGAINST ('".$querycode."' IN BOOLEAN MODE) GROUP BY orthogroup.orthogroup_id";
					$query_string = "SELECT ogs.ortholog_group_id 
					                 FROM apidb.OrthologGroupAaSequence ogs, 
					                      dots.ExternalAaSequence eas
					                 WHERE ogs.aa_sequence_id = eas.aa_sequence_id
					                   AND ogs.ortholog_group_id != 0 
					                   AND (eas.description LIKE '%".$querycode."%'
					                        OR eas.source_id LIKE '%".$querycode."%'
					                        OR eas.name LIKE '%".$querycode."%') 
					                 GROUP BY ogs.ortholog_group_id";
				    } elsif ($in eq 'Pfam_Accession') {
					# $query_string = "SELECT orthogroup.orthogroup_id FROM orthogroup INNER JOIN sequence USING (orthogroup_id) INNER JOIN sequence2domain USING (sequence_id) INNER JOIN domain USING (domain_id) WHERE orthogroup.orthogroup_id <> 0 AND domain.accession = '".$querycode."' GROUP BY orthogroup.orthogroup_id";
					$query_string = "SELECT ogs.ortholog_group_id 
					                 FROM apidb.OrthologGroupAaSequence ogs,
					                      dots.DomainFeature df, 
					                      dots.DbRefAaFeature dbaf,
					                      sres.DbRef db
					                 WHERE ogs.aa_sequence_id = df.aa_sequence_id
					                   AND df.aa_feature_id = dbaf.aa_feature_id
					                   AND dbaf.db_ref_id = db.db_ref_id
					                   AND ogs.ortholog_group_id != 0 
					                   AND db.primary_identifier LIKE '%".$querycode."%'
					                 GROUP BY ogs.ortholog_group_id";
				    } elsif ($in eq 'Pfam_Name') {
					# $query_string = "SELECT orthogroup.orthogroup_id FROM orthogroup INNER JOIN sequence USING (orthogroup_id) INNER JOIN sequence2domain USING (sequence_id) INNER JOIN domain USING (domain_id) WHERE orthogroup.orthogroup_id <> 0 AND domain.name = '".$querycode."' GROUP BY orthogroup.orthogroup_id";
					$query_string = "SELECT ogs.ortholog_group_id 
					                 FROM apidb.OrthologGroupAaSequence ogs,
					                      dots.DomainFeature df, 
					                      dots.DbRefAaFeature dbaf,
					                      sres.DbRef db
					                 WHERE ogs.aa_sequence_id = df.aa_sequence_id
					                   AND df.aa_feature_id = dbaf.aa_feature_id
					                   AND dbaf.db_ref_id = db.db_ref_id
					                   AND ogs.ortholog_group_id != 0 
					                   AND db.secondary_identifier LIKE '%".$querycode."%'
					                 GROUP BY ogs.ortholog_group_id";
				    } elsif ($in eq 'Pfam_Keyword') {
					# $query_string = "SELECT orthogroup.orthogroup_id FROM orthogroup INNER JOIN sequence USING (orthogroup_id) INNER JOIN sequence2domain USING (sequence_id) INNER JOIN domain USING (domain_id) WHERE orthogroup.orthogroup_id <> 0 AND MATCH (domain.description) AGAINST ('".$querycode."' IN BOOLEAN MODE) GROUP BY orthogroup.orthogroup_id";
					$query_string = "SELECT ogs.ortholog_group_id 
					                 FROM apidb.OrthologGroupAaSequence ogs,
					                      dots.DomainFeature df, 
					                      dots.DbRefAaFeature dbaf,
					                      sres.DbRef db
					                 WHERE ogs.aa_sequence_id = df.aa_sequence_id
					                   AND df.aa_feature_id = dbaf.aa_feature_id
					                   AND dbaf.db_ref_id = db.db_ref_id
					                   AND ogs.ortholog_group_id != 0 
					                   AND db.remark LIKE '%".$querycode."%'
					                 GROUP BY ogs.ortholog_group_id";
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
					# my $query_string = "SELECT orthogroup_id FROM sequence WHERE orthogroup_id <> 0 GROUP BY orthogroup_id HAVING COUNT(DISTINCT(sequence_id)) $number";
					my $query_string = "SELECT og.ortholog_group_id 
					                    FROM apidb.OrthologGroup og
					                    WHERE og.ortholog_group_id != 0 
					                      AND og.number_of_members $number";
					$query_orthogroup=$dbh->prepare($query_string);
				} elsif ($sizeof eq 'Genomes') {
					# my $query_string = "SELECT orthogroup_id FROM sequence WHERE orthogroup_id <> 0 GROUP BY orthogroup_id HAVING COUNT(DISTINCT(taxon_id)) $number";
					my $query_string = "SELECT ogs.ortholog_group_id 
					                    FROM apidb.OrthologGroupAaSequence ogs,
					                         dots.ExternalAaSequence eas
					                    WHERE ogs.ortholog_group_id != 0
					                      AND ogs.aa_sequence_id = eas.aa_sequence_id
					                    GROUP BY ogs.ortholog_group_id
					                      HAVING count(DISTINCT(eas.taxon_id)) $number";
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
				my ($querystring,$query_orthogroup);
				if ($prop=~/Pairs/) {
					# my $querystring="SELECT orthogroup.orthogroup_id, orthogroup.num_match_pairs AS matchpair FROM sequence INNER JOIN orthogroup USING (orthogroup_id) GROUP BY orthogroup_id HAVING 100 * matchpair * 2 / (COUNT(*) * (COUNT(*) - 1)) $number";
					my $querystring="SELECT og.ortholog_group_id, og.number_of_match_pairs AS matchpair 
					                 FROM apidb.OrthologGroup og
					                 WHERE 100 * og.number_of_match_pairs * 2 / (og.number_of_members * (og.number_of_members - 1)) $number";
					$query_orthogroup=$dbh->prepare($querystring);
				# } elsif ($prop=~/DCS/) {
				# 	my $querystring="SELECT orthogroup_id FROM orthogroup WHERE ave_dcs $number";
				# 	$query_orthogroup=$dbh->prepare($querystring);
				} elsif ($prop=~/Identity/) {
					# my $querystring="SELECT orthogroup_id FROM orthogroup WHERE ave_pi $number";
					my $querystring="SELECT ortholog_group_id FROM apidb.OrthologGroup WHERE avg_percent_identity $number";
					$query_orthogroup=$dbh->prepare($querystring);
				} elsif ($prop=~/Match/) {
					# my $querystring="SELECT orthogroup_id FROM orthogroup WHERE ave_pm $number";
					my $querystring="SELECT ortholog_group_id FROM apidb.OrthologGroup WHERE avg_percent_match $number";
					$query_orthogroup=$dbh->prepare($querystring);
				} elsif ($prop=~/BLAST/) {
					# my $querystring="SELECT orthogroup_id FROM orthogroup WHERE ave_eval $number";
					my $querystring="SELECT ortholog_group_id FROM apidb.OrthologGroup 
					                 WHERE avg_evalue_mant * power(10, avg_evalue_exp) $number";
					$query_orthogroup=$dbh->prepare($querystring);
				}

				if ($debug) {
					push(@{$para{LOOP_DEBUG}},{DEBUG=>$querystring});
				}

				$query_orthogroup->execute();
				while (my @data = $query_orthogroup->fetchrow_array()) {
					push(@{$orthogroup_ids_ref},$data[0]);
				}
				if (not defined $orthogroup_ids_ref) {$orthogroup_ids_ref=[];}
				push(@{$group_query_history},{
												CODE   => "$prop$number",
												TYPE   => 'Property Search',
												TIME   => $time,
												NUMHITS=> scalar(@{$orthogroup_ids_ref}),
												SHOW   => 1,
											});
			}
		} elsif ($querytype eq 'ppform') {
			
		}
		$self->session->param("GROUP_QUERY_HISTORY",$group_query_history);
		@$orthogroup_ids_ref=sort {$a<=>$b} @$orthogroup_ids_ref;
		push(@{$group_query_ids_history},$orthogroup_ids_ref);
		$self->session->param("GROUP_QUERY_IDS_HISTORY",$group_query_ids_history);

		$querynumber=scalar(@{$group_query_history});
		$para{QUERY_TYPE}=$group_query_history->[$querynumber-1]->{TYPE};   # for group_listing page to display
		$para{QUERY_CODE}=$group_query_history->[$querynumber-1]->{CODE};   # for group_listing page to display
		$self->session->param('GROUP_QUERY_NUMBER',$querynumber);# store the current querynumber for later paging
	} else {  # refer to an old query
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

	$para{NUM_GROUPS}=scalar(@{$orthogroup_ids_ref});
	$para{NUM_PAGES}=int(($para{NUM_GROUPS}-1)/10)+1;
	if ($para{NUM_PAGES}==1) {$para{ONEPAGE}=1;}
	
	$tmpl->param(\%para);

	require HTML::Pager;
	my $pager = HTML::Pager->new( query => $self->query,
				template => $tmpl,
				get_data_callback => [ \&getGroupRows,
										$orthogroup_ids_ref, $dbh, $tmpl
									],
				rows => scalar(@{$orthogroup_ids_ref}),
				page_size => 10,
				);

	return $pager->output;
}

sub getGroupRows {
	my ($offset, $rows, $orthogroup_ids_ref, $dbh, $tmpl) = @_;

	$tmpl->param(ROWSPERPAGE => $rows);
	$tmpl->param(GROUP_NUM_S => $offset+1);
	if (scalar(@{$orthogroup_ids_ref})<$offset+$rows) {
		$tmpl->param(GROUP_NUM_E => scalar(@{$orthogroup_ids_ref}));
	} else {
		$tmpl->param(GROUP_NUM_E => $offset+$rows);
	}
#	$tmpl->param(CURRENTPAGE => int($offset / $rows) + 1);

	my @rows;

#   this is for phyletic pattern display
	my @class;
	my %taxaclass;
		while (<DATA>) {
			$_=~s/\r|\n//g;
			next if (/^\#/);
			next unless (length($_) >= 3);
			my ($t,$c)=split("	",$_);
			unless (exists $taxaclass{$c}) {
				push(@class,$c);
			}
			push(@{$taxaclass{$c}},$t);
		}
	my %taxaname;
	# my $query_taxonname = $dbh->prepare('SELECT abbrev, name FROM taxon');
	my $query_taxonname = $dbh->prepare('SELECT DISTINCT tn.unique_name_variant AS abbrev, tn.unique_name_variant AS name 
	                                     FROM sres.TaxonName tn, dots.ExternalAaSequence eas 
	                                     WHERE tn.taxon_id = eas.taxon_id');
	$query_taxonname->execute();
	while (my @data = $query_taxonname->fetchrow_array()) {
		$taxaname{$data[0]}=$data[1];
	}



	# my $query_orthogroup = $dbh->prepare('SELECT * FROM orthogroup where orthogroup_id = ?');
	my $query_orthogroup = $dbh->prepare('SELECT ortholog_group_id, name, 0 AS avg_dcs,
	                                             avg_percent_identity, avg_percent_match, 
	                                             (avg_evalue_mant * power(10, avg_evalue_exp)) AS evalue, 
	                                             number_of_match_pairs 
	                                      FROM apidb.OrthologGroup 
	                                      WHERE ortholog_group_id = ?');
	
	# my $query_nogene_by_ot = $dbh->prepare('SELECT COUNT(*) FROM sequence INNER JOIN taxon USING (taxon_id) WHERE orthogroup_id = ? AND abbrev = ?');
	my $query_nogene_by_ot = $dbh->prepare('SELECT COUNT(*) 
	                                        FROM apidb.OrthologGroupAaSequence ogs, dots.ExternalAaSequence eas
	                                        WHERE ogs.aa_sequence_id = eas.aa_sequence_id
	                                          AND ogs.ortholog_group_id = ?
	                                          AND eas.taxon_id IN (SELECT taxon_id FROM sres.TaxonName WHERE unique_name_variant = ?)');

	# my $query_nogene_by_o = $dbh->prepare('SELECT COUNT(*) FROM sequence WHERE orthogroup_id = ?');
	my $query_nogene_by_o = $dbh->prepare('SELECT COUNT(*) FROM apidb.OrthologGroupAaSequence WHERE ortholog_group_id = ?');

	# my $query_notaxa_by_o = $dbh->prepare('SELECT COUNT(DISTINCT taxon_id) FROM sequence WHERE orthogroup_id = ?');
	my $query_notaxa_by_o = $dbh->prepare('SELECT COUNT(DISTINCT eas.taxon_id)  
	                                       FROM apidb.OrthologGroupAaSequence ogs, dots.ExternalAaSequence eas
	                                       WHERE ogs.aa_sequence_id = eas.aa_sequence_id
	                                         AND ogs.ortholog_group_id = ?');
	
	# my $query_sdescription_by_o = $dbh->prepare('SELECT description FROM sequence WHERE orthogroup_id = ?'); # used for summarizing keyword
	my $query_sdescription_by_o = $dbh->prepare('SELECT eas.description  
	                                             FROM apidb.OrthologGroupAaSequence ogs, dots.ExternalAaSequence eas
	                                             WHERE ogs.aa_sequence_id = eas.aa_sequence_id
	                                               AND ogs.ortholog_group_id = ?'); # used for summarizing keyword
	
	# my $query_domain_by_o = $dbh->prepare('SELECT sequence2domain.sequence_id, sequence2domain.domain_id FROM sequence2domain INNER JOIN sequence USING (sequence_id) WHERE sequence.orthogroup_id = ?');
	my $query_domain_by_o = $dbh->prepare('SELECT ogs.aa_sequence_id, dbaf.db_ref_id 
	                                       FROM apidb.OrthologGroupAaSequence ogs, 
	                                            dots.DomainFeature df,
	                                            dots.DbRefAaFeature dbaf
	                                       WHERE ogs.aa_sequence_id = df.aa_sequence_id
	                                         AND df.aa_feature_id = dbaf.aa_feature_id
	                                         AND ogs.ortholog_group_id = ?');

	# my $query_ddescription_by_d = $dbh->prepare('SELECT description FROM domain WHERE domain_id = ?');
	my $query_ddescription_by_d = $dbh->prepare('SELECT remark FROM sres.DbRef WHERE db_ref_id = ?');
	my $count=0;

	for (my $x = 0; $x < $rows; $x++) {
		last if ($offset+$x>$#{$orthogroup_ids_ref});
		my $orthogroup_id=$orthogroup_ids_ref->[$offset+$x];
#	foreach my $orthogroup_id (sort {$a<=>$b} @{$orthogroup_ids_ref}) {
		
		$query_orthogroup->execute($orthogroup_id);
		my @data = $query_orthogroup->fetchrow_array();

		my %group;
		$count++;
		if ($count%2) {
			$group{__ODD__}=1;
		} else {
			$group{__EVEN__}=1;
		}

		$group{GROUP_NUMBER}=$offset+$x+1;
		$group{GROUP_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupid=$data[0]";
		$group{DOMARCH_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=domarchList&groupac=$data[1]";
		$group{SEQUENCE_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=getSeq&groupac=$data[1]";


		my @tmp;
		$query_nogene_by_o->execute($orthogroup_id);
		@tmp = $query_nogene_by_o->fetchrow_array();
		$group{NO_SEQUENCES}=$tmp[0];

		if (($tmp[0]<=100) && ($tmp[0]>=2)) {
			$group{BIOLAYOUT_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=BLGraph&groupac=$data[1]";
			$group{MSA_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=MSA&groupac=$data[1]";
		}

		$query_notaxa_by_o->execute($orthogroup_id);
		@tmp = $query_notaxa_by_o->fetchrow_array();
		$group{NO_TAXA}=$tmp[0];



		$group{GROUP_ACCESSION}=$data[1];
		$group{NO_MATCH_PAIRS}=$data[6];
		$group{PERC_MATCH_PAIRS}=int(1000*$group{NO_MATCH_PAIRS}/($group{NO_SEQUENCES}*($group{NO_SEQUENCES}-1)/2))/10;

		if ($group{NO_MATCH_PAIRS}==0) {
		    $group{AVE_EVAL}='N/A';
		    $group{AVE_PM}='N/A';
		    $group{AVE_PI}='N/A';
		} else {
		    $group{AVE_EVAL}=sprintf("%8.2e",$data[5]);
		    $group{AVE_PM}=$data[4];
		    $group{AVE_PI}=$data[3];
		}
#		$group{AVE_DCS}=$data[2];

# about Keywords summary
		if (1) {
		    $query_sdescription_by_o->execute($orthogroup_id);
		    my @funlines;
		    while (@tmp = $query_sdescription_by_o->fetchrow_array()) {
			push(@funlines,$tmp[0]);
		    }
		    my %keywords = %{FunKeyword(\@funlines)};
		    foreach my $k (keys %keywords) {
			my $c=sprintf("%X",int((1-$keywords{$k})*255));
			$group{KEYWORDS}.="<font color=\"#$c$c$c\">$k</font>; ";
		    }
		}
# about Pfam domain summary
		if (1) {
			my %sequence_domain;
			$query_domain_by_o->execute($orthogroup_id);
			while (@tmp = $query_domain_by_o->fetchrow_array()) {
			    $sequence_domain{$tmp[0]}->{$tmp[1]}=1;
			}
			my %domains = %{DomainFreq($group{NO_SEQUENCES},\%sequence_domain)};
			foreach my $d (keys %domains) {
			    my $c=sprintf("%X",int((1-$domains{$d})*255));
			    $query_ddescription_by_d->execute($d);
			    @tmp = $query_ddescription_by_d->fetchrow_array();
			    $group{DOMAIN}.="<font color=\"#$c$c$c\">$tmp[0]</font>; ";
			}
		}

		foreach my $c (@class) {
			my %category;
			$category{CATEGORY_ID}=$c;
			foreach my $t (@{$taxaclass{$c}}) {
				my %taxon;

				if ($t eq 'SPACE') {
					push(@{$category{LOOP_TAXON}},\%taxon);
					next;
				}

				$taxon{TAXON_ID}=$t;
				$taxon{TAXON_NAME}=$taxaname{$t};
				$query_nogene_by_ot->execute($orthogroup_id,$t);
				@tmp = $query_nogene_by_ot->fetchrow_array();
				$taxon{NO_GENES}=$tmp[0];
				push(@{$category{LOOP_TAXON}},\%taxon);
			}
			push(@{$group{LOOP_CATEGORY}},\%category);
		}
		push(@rows,\%group);
	}

	return \@rows;
}

sub sequenceQueryHistory {
	my $self = shift;
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
					if ($present_ids{$_}==scalar(@select)) {push(@result_ids,$_);}
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
				foreach (@{$sequence_query_ids_history->[$b-1]}) {$b_seqids{$_}=1;}
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
			push(@{$sequence_query_history},{	CODE   =>$action_description,
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
		my $query_sequenceid = $dbh->prepare('SELECT aa_sequence_id FROM dots.ExternalAaSequence WHERE source_id = ?');
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
		# insert into history as a new query
		my $query_time = $dbh->prepare('SELECT SYSDATE FROM dual');
		$query_time->execute();
		my @data = $query_time->fetchrow_array();
		push(@{$sequence_query_history},{	CODE   =>$filename,
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

	if ($number_history==0) {$para{NO_HISTORY}=1;}

	my $tmpl = $self->load_tmpl('sequence_queryhistory.tmpl');  # loading template
	$self->defaults($tmpl);
	$tmpl->param(\%para);
	return $self->done($tmpl);
}


sub sequenceList {
	my $self   = shift;
	my $config = $self->param("config");
	my $q      = $self->query();
	my $dbh    = $self->dbh();

	my $tmpl   = $self->load_tmpl('sequence_listing.tmpl');
	$self->defaults($tmpl);

	my %para;

	$para{PAGETITLE}="Sequence List";

	my $sequence_ids_ref;  # store all the sequence ids for current query
	# this variable is used for paging,  thus not suitable for sequence list of certain groupid

	if ($q->param("groupid") || $q->param("groupac")) {

	    my ($orthogroup_id,$orthogroup_ac);
	    if ($orthogroup_ac = $q->param("groupac")) {
		# my $query_orthogroupid = $dbh->prepare('SELECT orthogroup_id FROM orthogroup WHERE accession = ?');
		my $query_orthogroupid = $dbh->prepare('SELECT ortholog_group_id FROM apidb.OrthologGroup WHERE name = ?');
		$query_orthogroupid->execute($orthogroup_ac);
		my @tmp = $query_orthogroupid->fetchrow_array();
		$orthogroup_id = $tmp[0];
	    } else {
		$orthogroup_id = $q->param("groupid");
	    }

		$para{GROUP}=1;

		# Prepare Group Summary Part #
		my @class;
		my %taxaclass;
		while (<DATA>) {
			$_=~s/\r|\n//g;
			next if (/^\#/);
			next unless (length($_) >= 3);
			my ($t,$c)=split("	",$_);
			unless (exists $taxaclass{$c}) {
				push(@class,$c);
			}
			push(@{$taxaclass{$c}},$t);
		}

		#my $query_orthogroup = $dbh->prepare('SELECT * FROM orthogroup where orthogroup_id = ?');
		my $query_orthogroup = $dbh->prepare('SELECT ortholog_group_id, name, 0 AS avg_dcs,
	                                             avg_percent_identity, avg_percent_match, 
	                                             (avg_evalue_mant * power(10, avg_evalue_exp)) AS evalue, 
	                                             number_of_match_pairs 
	                                          FROM apidb.OrthologGroup 
	                                          WHERE ortholog_group_id = ?');
		
		#my $query_nogene_by_ot = $dbh->prepare('SELECT COUNT(*) FROM sequence INNER JOIN taxon USING (taxon_id) WHERE orthogroup_id = ? AND abbrev = ?');
		my $query_nogene_by_ot = $dbh->prepare('SELECT COUNT(*) 
	                                            FROM apidb.OrthologGroupAaSequence ogs, dots.ExternalAaSequence eas
	                                            WHERE ogs.aa_sequence_id = eas.aa_sequence_id
	                                              AND ogs.ortholog_group_id = ?
	                                              AND eas.taxon_id IN (SELECT taxon_id 
	                                                                   FROM sres.TaxonName 
	                                                                   WHERE unique_name_variant = ?)');
		
		#my $query_nogene_by_o = $dbh->prepare('SELECT COUNT(*) FROM sequence WHERE orthogroup_id = ?');
		my $query_nogene_by_o = $dbh->prepare('SELECT COUNT(*) FROM apidb.OrthologGroupAaSequence WHERE ortholog_group_id = ?');
		
		# my $query_notaxa_by_o = $dbh->prepare('SELECT COUNT(DISTINCT taxon_id) FROM sequence WHERE orthogroup_id = ?');
		my $query_notaxa_by_o = $dbh->prepare('SELECT COUNT(DISTINCT eas.taxon_id)  
	                                           FROM apidb.OrthologGroupAaSequence ogs, dots.ExternalAaSequence eas
	                                           WHERE ogs.aa_sequence_id = eas.aa_sequence_id
	                                             AND ogs.ortholog_group_id = ?');


		my @tmp;
		$query_nogene_by_o->execute($orthogroup_id);
		@tmp = $query_nogene_by_o->fetchrow_array();
		$para{NO_SEQUENCES}=$tmp[0];
		$query_notaxa_by_o->execute($orthogroup_id);
		@tmp = $query_notaxa_by_o->fetchrow_array();
		$para{NO_TAXA}=$tmp[0];

		$query_orthogroup->execute($orthogroup_id);
		my @data = $query_orthogroup->fetchrow_array();

		$para{GROUP_ACCESSION}=$data[1];
		$para{NO_MATCH_PAIRS}=$data[6];
		$para{PERC_MATCH_PAIRS}=int(1000*$para{NO_MATCH_PAIRS}/($para{NO_SEQUENCES}*($para{NO_SEQUENCES}-1)/2))/10;
		$para{AVE_EVAL}=sprintf("%8.2e",$data[5]);
		$para{AVE_PM}=$data[4];
		$para{AVE_PI}=$data[3];
#		$para{AVE_DCS}=$data[2];

		$para{DOMARCH_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=domarchList&groupac=".$para{GROUP_ACCESSION};
		$para{SEQUENCE_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=getSeq&groupac=".$para{GROUP_ACCESSION};
		if (($para{NO_SEQUENCES}<=100) && ($para{NO_SEQUENCES}>=2)) {
		    $para{BIOLAYOUT_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=BLGraph&groupac=".$para{GROUP_ACCESSION};
		    $para{MSA_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=MSA&groupac=".$para{GROUP_ACCESSION};
		}

		foreach my $c (@class) {
			my %category;
			$category{CATEGORY_ID}=$c;
			foreach my $t (@{$taxaclass{$c}}) {
				my %taxon;

				if ($t eq 'SPACE') {
					push(@{$category{LOOP_TAXON}},\%taxon);
					next;
				}

				$taxon{TAXON_ID}=$t;
				$query_nogene_by_ot->execute($orthogroup_id,$t);
				@tmp = $query_nogene_by_ot->fetchrow_array();
				$taxon{NO_GENES}=$tmp[0];
				push(@{$category{LOOP_TAXON}},\%taxon);
			}
			push(@{$para{LOOP_CATEGORY}},\%category);
		}



		# Prepare Sequence List Part #
		# my $query_sequence_by_groupid = $dbh->prepare('SELECT sequence.accession,sequence.name,sequence.description,sequence.length,taxon.name,taxon.xref FROM sequence INNER JOIN taxon USING (taxon_id) WHERE orthogroup_id = ?');
		my $query_sequence_by_groupid = $dbh->prepare('SELECT DISTINCT eas.source_id, eas.name, eas.description,
		                                                      eas.length, tn.unique_name_variant, edr.id_url 
		                                               FROM apidb.OrthologGroupAaSequence ogs,
		                                                    dots.ExternalAaSequence eas,
		                                                    sres.ExternalDatabaseRelease edr,
		                                                    sres.TaxonName tn
		                                               WHERE ogs.aa_sequence_id = eas.aa_sequence_id
		                                                 AND eas.external_database_release_id = edr.external_database_release_id
		                                                 AND eas.taxon_id = tn.taxon_id
		                                                 AND ogs.ortholog_group_id = ?');
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
			$sequence{SEQUENCE_NUMBER}=$count;
			$sequence{SEQUENCE_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=$data[0]";
			$sequence{SEQUENCE_ACCESSION}=$data[0];
			$sequence{XREF}=$data[1];
			if (defined $data[5]) {
			    $sequence{XREF_LINK}=$data[5].$data[1];
			}
			my @desc_info = split(" ",$data[2]);
			shift @desc_info;
			$sequence{SEQUENCE_DESCRIPTION}=join(" ",@desc_info);
			$sequence{SEQUENCE_LENGTH}=$data[3];
			$sequence{SEQUENCE_TAXON}=$data[4];
			push(@{$para{PAGER_DATA_LIST}},\%sequence);
		}
		$para{NO_GROUPAC}=1;
		$tmpl->param(\%para);
		return $self->done($tmpl);

	}
	elsif ((my $querycode = $q->param("q")) && (my $in = $q->param("in"))) {

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
		  open(BLAST, "$config->{BLAST} -p blastp -i $tempfile -d $config->{FA_file} -e 1e-5 -b 0 |") or die $!;
		  # my $query_sequence = $dbh->prepare('SELECT sequence_id FROM sequence WHERE accession = ?');
		  my $query_sequence = $dbh->prepare('SELECT aa_sequence_id FROM dots.ExternalAaSequence WHERE source_id = ?');
		  while (<BLAST>) {
		    if (m/Sequences producing significant alignments/) {
		      <BLAST>; # empty line
		      while (<BLAST>) {
			last if m/^\s*$/;
			if (m/^(\S+)/) {
			  $query_sequence->execute($1);
			  while (my @data = $query_sequence->fetchrow_array()) {
			    push(@{$sequence_ids_ref},$data[0]);
			  }
			}
		      }
		    }
		  }
		  close(BLAST);
		  unlink($tempfile);
		} elsif ($in eq 'Accession') {
			my @qc = split(" ",$querycode);
			# my $query_sequence = $dbh->prepare('SELECT sequence_id FROM sequence WHERE name = ?');
			my $query_sequence = $dbh->prepare('SELECT aa_sequence_id FROM dots.ExternalAaSequence WHERE name = ?');
			foreach (@qc) {
				$query_sequence->execute($_);
				while (my @data = $query_sequence->fetchrow_array()) {
					push(@{$sequence_ids_ref},$data[0]);
				}
			}
		} else {
			my $query_string;
			if ($in eq 'All') {
				# $query_string = "SELECT sequence_id FROM sequence WHERE accession LIKE '%".$querycode."%' OR description LIKE '%".$querycode."%'";
				$query_string = "SELECT aa_sequence_id 
				                 FROM dots.ExternalAaSequence 
				                 WHERE source_id LIKE '%".$querycode."%' 
				                    OR description LIKE '%".$querycode."%'";
			} elsif ($in eq 'Keyword') {
#				$query_string = "SELECT sequence_id FROM sequence WHERE description LIKE '%".$querycode."%'";
			    # $query_string = "SELECT sequence_id FROM sequence WHERE MATCH (description) AGAINST ('".$querycode."' IN BOOLEAN MODE)";
			    $query_string = "SELECT aa_sequence_id 
				                 FROM dots.ExternalAaSequence 
				                 WHERE description LIKE '%".$querycode."%'";
			} elsif ($in eq 'Taxon_Abbreviation') {
				# $query_string = "SELECT sequence.sequence_id FROM sequence INNER JOIN taxon USING (taxon_id) WHERE taxon.abbrev = '".$querycode."'";
				$query_string = "SELECT DISTINCT aa_sequence_id 
				                 FROM dots.ExternalAaSequence 
				                 WHERE taxon_id IN (SELECT taxon_id 
				                                    FROM sres.TaxonName 
				                                    WHERE unique_name_variant = '".$querycode."')";
			} elsif ($in eq 'Pfam_Accession') {
				# $query_string = "SELECT DISTINCT sequence.sequence_id) FROM sequence INNER JOIN sequence2domain USING (sequence_id) INNER JOIN domain USING (domain_id) WHERE domain.accession = '".$querycode."'";
				$query_string = "SELECT DISTINCT eas.aa_sequence_id 
				                 FROM dots.ExternalAaSequence eas,
				                      dots.DomainFeature df,
				                      dots.DbRefAaFeature dbaf,
				                      sres.DbRef db
				                 WHERE eas.aa_sequence_id = df.aa_sequence_id
				                   AND df.aa_feature_id = dbaf.aa_feature_id
				                   AND dbaf.db_ref_id = db.db_ref_id
				                   AND db.primary_identifier = '".$querycode."'";
			} elsif ($in eq 'Pfam_Name') {
				# $query_string = "SELECT DISTINCT(sequence.sequence_id) FROM sequence INNER JOIN sequence2domain USING (sequence_id) INNER JOIN domain USING (domain_id) WHERE domain.name = '".$querycode."'";
				$query_string = "SELECT DISTINCT eas.aa_sequence_id 
				                 FROM dots.ExternalAaSequence eas,
				                      dots.DomainFeature df,
				                      dots.DbRefAaFeature dbaf,
				                      sres.DbRef db
				                 WHERE eas.aa_sequence_id = df.aa_sequence_id
				                   AND df.aa_feature_id = dbaf.aa_feature_id
				                   AND dbaf.db_ref_id = db.db_ref_id
				                   AND db.secondary_identifier = '".$querycode."'";
			} elsif ($in eq 'Pfam_Keyword') {
				# $query_string = "SELECT DISTINCT(sequence.sequence_id) FROM sequence INNER JOIN sequence2domain USING (sequence_id) INNER JOIN domain USING (domain_id) WHERE MATCH (domain.description) AGAINST ('".$querycode."' IN BOOLEAN MODE)";
				$query_string = "SELECT DISTINCT eas.aa_sequence_id 
				                 FROM dots.ExternalAaSequence eas,
				                      dots.DomainFeature df,
				                      dots.DbRefAaFeature dbaf,
				                      sres.DbRef db
				                 WHERE eas.aa_sequence_id = df.aa_sequence_id
				                   AND df.aa_feature_id = dbaf.aa_feature_id
				                   AND dbaf.db_ref_id = db.db_ref_id
				                   AND db.remark = '".$querycode."'";
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

		if (not defined $sequence_ids_ref) {$sequence_ids_ref=[];}

		push(@{$sequence_query_history},{
										CODE   => $querycode,
										TYPE   => $in,
										TIME   => $time,
										NUMHITS=> scalar(@{$sequence_ids_ref}),
										SHOW   => 1,
									});

		$self->session->param("SEQUENCE_QUERY_HISTORY",$sequence_query_history);
	
		push(@{$sequence_query_ids_history},$sequence_ids_ref);
		$self->session->param("SEQUENCE_QUERY_IDS_HISTORY",$sequence_query_ids_history);

		$para{QUERY_TYPE}=$in;          # for sequence_listing page to display
		$para{QUERY_CODE}=$querycode;   # for sequence_listing page to display
		$querynumber=scalar(@{$sequence_query_history});
		$self->session->param('SEQUENCE_QUERY_NUMBER',$querynumber);# store the current querynumber for later paging
	} else {  # refer to an old query
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
	if ($para{NUM_PAGES}==1) {$para{ONEPAGE}=1;}
	
	$tmpl->param(\%para);

	require HTML::Pager;
	my $pager = HTML::Pager->new( query => $self->query,
				template => $tmpl,
				get_data_callback => [ \&getSequenceRows,
										$sequence_ids_ref, $dbh, $tmpl
									],
				rows => scalar(@{$sequence_ids_ref}),
				page_size => 50,
				);
	return $pager->output;
}

sub getSequenceRows {
	my ($offset, $rows, $sequence_ids_ref, $dbh, $tmpl) = @_;

	$tmpl->param(ROWSPERPAGE => $rows);
	$tmpl->param(SEQUENCE_NUM_S => $offset+1);
	if (scalar(@{$sequence_ids_ref})<$offset+$rows) {
		$tmpl->param(SEQUENCE_NUM_E => scalar(@{$sequence_ids_ref}));
	} else {
		$tmpl->param(SEQUENCE_NUM_E => $offset+$rows);
	}

	my @rows;

	# my $query_sequence = $dbh->prepare('SELECT sequence.accession,sequence.name,sequence.description,sequence.length,taxon.name,taxon.xref,orthogroup.accession,orthogroup.orthogroup_id FROM orthogroup RIGHT JOIN sequence USING (orthogroup_id) INNER JOIN taxon USING (taxon_id) WHERE sequence.sequence_id = ?');
	my $query_sequence = $dbh->prepare('SELECT DISTINCT eas.source_id, eas.secondary_identifier, 
	                                           eas.description, eas.length, tn.unique_name_variant,
	                                           edr.id_url, og.name, og.ortholog_group_id 
	                                           FROM dots.ExternalAaSequence eas,
	                                                sres.ExternalDatabaseRelease edr,
	                                                sres.TaxonName tn,
	                                                apidb.OrthologGroup og,
	                                                apidb.OrthologGroupAaSequence ogs
	                                           WHERE eas.external_database_release_id = edr.external_database_release_id
	                                             AND eas.taxon_id = tn.taxon_id
	                                             AND eas.aa_sequence_id = ogs.aa_sequence_id(+)
	                                             AND ogs.ortholog_group_id = og.ortholog_group_id(+) 
	                                             AND eas.aa_sequence_id = ?');

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

		$sequence{SEQUENCE_NUMBER}=$offset+$x+1;;
		$sequence{SEQUENCE_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=$data[0]";
		$sequence{SEQUENCE_ACCESSION}=$data[0];
		$sequence{XREF}=$data[1];
		if (defined $data[5]) {
		    $sequence{XREF_LINK}=$data[5].$data[1];
		}
		my @desc_info = split(" ",$data[2]);
		shift @desc_info;
		$sequence{SEQUENCE_DESCRIPTION}=join(" ",@desc_info);
		$sequence{SEQUENCE_LENGTH}=$data[3];
		$sequence{SEQUENCE_TAXON}=$data[4];
		if (defined $data[6]) {
		    $sequence{GROUP_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupid=$data[7]";
		    $sequence{GROUP_ACCESSION}=$data[6];
		} else {
		    $sequence{GROUP_ACCESSION}='not clustered';
		}
		push(@rows,\%sequence);
	}

	return \@rows;
}



sub domarchList {
	my $self = shift;
	my $config = $self->param("config");
	my $dbh = $self->dbh();
	my $q = $self->query();

	my %para;

	my ($orthogroup_id,$orthogroup_ac);
	if ($orthogroup_id = $q->param("groupid")) {
		# my $query_orthogroup_by_groupid = $dbh->prepare('SELECT accession FROM orthogroup WHERE orthogroup_id = ?');
		my $query_orthogroup_by_groupid = $dbh->prepare('SELECT name FROM apidb.OrthologGroup WHERE ortholog_group_id = ?');
		$query_orthogroup_by_groupid->execute($orthogroup_id);
		my @tmp = $query_orthogroup_by_groupid->fetchrow_array();
		$orthogroup_ac = $tmp[0];
	} elsif ($orthogroup_ac = $q->param("groupac")) {
		# my $query_orthogroup_by_groupac = $dbh->prepare('SELECT orthogroup_id FROM orthogroup WHERE accession = ?');
		my $query_orthogroup_by_groupac = $dbh->prepare('SELECT ortholog_group_id FROM apidb.OrthologGroup WHERE name = ?');
		$query_orthogroup_by_groupac->execute($orthogroup_ac);
		my @tmp = $query_orthogroup_by_groupac->fetchrow_array();
		$orthogroup_id = $tmp[0];
	}

	$para{GROUP_ACCESSION}=$orthogroup_ac;

	$para{PAGETITLE}="Protein Domain Architecture for $orthogroup_ac";
	my $query_sequence_by_groupid = $dbh->prepare('SELECT DISTINCT eas.aa_sequence_id, 
		                                                      eas.source_id, eas.description, 
		                                                      eas.length, tn.unique_name_variant 
		                                               FROM apidb.OrthologGroupAaSequence ogs,
		                                                    dots.ExternalAaSequence eas,
		                                                    sres.TaxonName tn
		                                               WHERE ogs.aa_sequence_id = eas.aa_sequence_id
		                                                 AND eas.taxon_id = tn.taxon_id
		                                                 AND ogs.ortholog_group_id = ?');

	my $query_max_length_by_groupid = $dbh->prepare('SELECT MAX(eas.length)
		                                               FROM apidb.OrthologGroupAaSequence ogs,
		                                                    dots.ExternalAaSequence eas,
		                                                    sres.TaxonName tn
		                                               WHERE ogs.aa_sequence_id = eas.aa_sequence_id
		                                                 AND eas.taxon_id = tn.taxon_id
		                                                 AND ogs.ortholog_group_id = ?');
	
	my $query_domains_by_sequenceid = $dbh->prepare('SELECT eas.source_id, db.primary_identifier,
                                                              db.secondary_identifier, db.remark,
                                                              al.start_min, al.end_max
                                                       FROM dots.ExternalAaSequence eas,
                                                            dots.DomainFeature df,
                                                            dots.DbRefAaFeature dbaf,
                                                            dots.AaLocation al,
                                                            sres.DbRef db
                                                       WHERE eas.aa_sequence_id = df.aa_sequence_id
                                                         AND df.aa_feature_id = al.aa_feature_id
                                                         AND df.aa_feature_id = dbaf.aa_feature_id
                                                         AND dbaf.db_ref_id = db.db_ref_id
                                                         AND eas.aa_sequence_id = ?');

	# Fetch max length, set params needed in order to generate images
	$query_max_length_by_groupid->execute($orthogroup_id);
	my @length_data=$query_max_length_by_groupid->fetchrow_array();
	my $length_max=$length_data[0];
	my $dom_height=10;
	my $spacer_height=15;
	my $margin_x = 10;
	my $margin_y = 40;
	my $scale_factor=0.6;
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
	my %domain_colors;
	my @color_names = sort keys(%colors);
	while (my @sequence_data = $query_sequence_by_groupid->fetchrow_array()) {
	    push(@sequence_ids,$sequence_data[0]);
	    my %sequence;
	    $sequence{SEQUENCE_ACCESSION}=$sequence_data[1];
	    $sequence{SEQUENCE_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=".$sequence{SEQUENCE_ACCESSION};
	    $sequence{SEQUENCE_LENGTH}=$sequence_data[3];
	    $sequence{SEQUENCE_TAXON}=$sequence_data[4];
	    
	    my $sequence_image="cgi-bin/OrthoMclWeb.cgi?rm=drawProtein&margin_x=$margin_x&scale_factor=$scale_factor&pos_y=$pos_y&size_x=$size_x&size_y=$size_y&dom_height=$dom_height&length=$sequence_data[3]&length_max=$length_max&tick_step=$tick_step&margin_y=$margin_y&spacer_height=$spacer_height";

	    #Fetch domains for sequence
	    $query_domains_by_sequenceid->execute($sequence_data[0]);

	    my $num_dom_in_sequence=0;
	    while (my @domain_data = $query_domains_by_sequenceid->fetchrow_array()) {
		if (!exists $domain_colors{$domain_data[1]}) {
		    my %domain;
		    $domain{DOMAIN_ACCESSION}=$domain_data[1];
		    $domain{DOMAIN_LINK}=$config->{PFAM_link}.$domain{DOMAIN_ACCESSION};
		    $domain{DOMAIN_NAME}=$domain_data[2];
		    $domain{DOMAIN_DESCRIPTION}=$domain_data[3];
	    
		    my $from = $domain_data[4];
		    my $to = $domain_data[5];
		    my $length=$to-$from;
		    my $color_name = shift(@color_names);
		    $domain{DOMAIN_IMAGE}="cgi-bin/OrthoMclWeb.cgi?rm=drawDomain&length=$length&margin_x=$margin_x&scale_factor=$scale_factor&pos_y=$pos_y&dom_height=$dom_height&domain_color=$color_name";
		    
		    push(@{$para{LOOP_DOMAIN}},\%domain);
		    $domain_colors{$domain_data[1]}=$color_name;
		}

		$sequence_image = $sequence_image."&domain_from".$num_dom_in_sequence."=".$domain_data[4]."&domain_to".$num_dom_in_sequence."=".$domain_data[5]."&domain_color".$num_dom_in_sequence."=".$domain_colors{$domain_data[1]};
		$num_dom_in_sequence++;
	    }

	    $sequence_image = $sequence_image."&num_domains=".$num_dom_in_sequence;
		
		
	    $sequence{SEQUENCE_IMAGE}=$sequence_image;
	   
	    push(@{$para{LOOP_DOMARCH}},\%sequence);
	}
	
       	# includes scale image in page  (the heading for the column w/sequence images
	$para{SCALE_IMAGE}="cgi-bin/OrthoMclWeb.cgi?rm=drawScale&size_x=$size_x&margin_x=$margin_x&scale_factor=$scale_factor&length_max=$length_max&tick_step=$tick_step&scale_color=white";

	unless (keys(%domain_colors)) {
	    $para{NOPFAM}=1;
	}
	
	my $tmpl = $self->load_tmpl('domarch_listing.tmpl');
	$self->defaults($tmpl);
	$tmpl->param(\%para);
	return $self->done($tmpl);
}

sub sequence {
	my $self = shift;
	my $config = $self->param("config");
	my $dbh = $self->dbh();
	my $q = $self->query();

	my $sequence_accession = $q->param("accession");

	my %para;
	$para{PAGETITLE}="Sequence $sequence_accession";
	
	# prepare data to fill out sequence page
	# my $query_sequence = $dbh->prepare('SELECT sequence.accession,sequence.name,taxon.name,sequence.orthogroup_id,sequence.description,sequence.length,taxon.xref FROM sequence INNER JOIN taxon USING (taxon_id) WHERE sequence.accession = ?');
	my $query_sequence = $dbh->prepare('SELECT DISTINCT eas.source_id, eas.name, 
	                                           tn.unique_name_variant, ogs.ortholog_group_id,
	                                           eas.description, eas.length, edr.id_url 
	                                    FROM dots.ExternalAaSequence eas,
	                                         sres.TaxonName tn,
	                                         sres.ExternalDatabaseRelease edr,
	                                         apidb.OrthologGroupAaSequence ogs
	                                    WHERE eas.taxon_id = tn.taxon_id
	                                      AND eas.external_database_release_id = edr.external_database_release_id
	                                      AND eas.aa_sequence_id = ogs.aa_sequence_id(+)
	                                      AND eas.source_id = ?');

	# my $query_orthogroup = $dbh->prepare('SELECT accession FROM orthogroup WHERE orthogroup_id = ?');
	my $query_orthogroup = $dbh->prepare('SELECT name FROM apidb.OrthologGroup WHERE ortholog_group_id = ?');

	$query_sequence->execute($sequence_accession);
	my @data = $query_sequence->fetchrow_array();
	$para{ACCESSION}=$data[0];
	$para{NAME}=$data[1];
	$para{TAXON}=$data[2];
	my $orthogroup_old_ac;
	if ($data[3]==0) {
	    $para{GROUP_ACCESSION}='not clustered';
	} else {
	    $query_orthogroup->execute($data[3]);
	    my @data2 = $query_orthogroup->fetchrow_array();
	    $para{GROUP_ACCESSION}=$data2[0];
	    $para{GROUP_LINK}="cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupid=$data[3]";
	    $orthogroup_old_ac = transformOGAC($para{GROUP_ACCESSION});
	}
	my @desc_info = split(" ",$data[4]);
	shift @desc_info;
	$para{DESCRIPTION}=join(" ",@desc_info);
	$para{LENGTH}=$data[5];
	if (defined $data[6]) {
	    $para{XREF_LINK}=$data[6].$data[1];
	}


	# use Bio::Index::Fasta to retrieve sequence
	require Bio::Index::Fasta;

	my $inx = Bio::Index::Fasta->new('-filename' => $config->{FAIDX_file});

	my $seq = $inx->fetch($para{ACCESSION});
	my $len = $seq->length();
	$para{SEQUENCE}.="<font face=\"Courier\" size=\"2\">>".$para{NAME}." ".$para{DESCRIPTION}." [".$para{TAXON}."]<br>";
	for (my $i=1;$i<=$len;$i+=60) {
		if ($i+60-1>$len) {$para{SEQUENCE}.=$seq->subseq($i,$len)."<br>";} 
		else {$para{SEQUENCE}.=$seq->subseq($i,$i+60-1)."<br>";}
	}
	$para{SEQUENCE}.="</font>";

	# prepare data to fill out domain architecture block
	if (defined $orthogroup_old_ac) {
		my ($dd)=$orthogroup_old_ac=~/(\d{2})$/;
		unless ($dd) {
			($dd)=$orthogroup_old_ac=~/(\d)$/;
			$dd="0$dd";
		}
		my ($a,$b)=split("",$dd);

		$para{SCALE_IMAGE}="cgi-bin/OrthoMclWeb.cgi?rm=drawScale&size_x=620&margin_x=10&scale_factor=0.6&length_max=1000&tick_step=50&scale_color=black";
		$para{SEQUENCE_IMAGE}=$config->{DOMARCH_url}."$a/$b/$orthogroup_old_ac/".$para{ACCESSION}.'.PNG';
	}
	# my $query_domarch_by_ac = $dbh->prepare('SELECT sequence2domain.start,sequence2domain.end,domain.accession,domain.name,domain.description FROM sequence INNER JOIN sequence2domain USING (sequence_id) INNER JOIN domain USING (domain_id) WHERE sequence.accession = ?');
	my $query_domarch_by_ac = $dbh->prepare('SELECT al.start_min, al.end_max, db.primary_identifier, 
	                                                db.secondary_identifier, db.remark 
	                                         FROM dots.ExternalAaSequence eas,
	                                              dots.DomainFeature df,
	                                              dots.AaLocation al,
	                                              dots.DbRefAaFeature dbaf,
	                                              sres.DbRef db
	                                         WHERE eas.aa_sequence_id = df.aa_sequence_id
	                                           AND df.aa_feature_id = al.aa_feature_id
	                                           AND df.aa_feature_id = dbaf.aa_feature_id
	                                           AND dbaf.db_ref_id = db.db_ref_id
	                                           AND eas.source_id = ?');
	$query_domarch_by_ac->execute($sequence_accession);
	while (@data = $query_domarch_by_ac->fetchrow_array()) {
		my %domain;
		$domain{DOMAIN_START}=$data[0];
		$domain{DOMAIN_END}=$data[1];
		$domain{DOMAIN_ACCESSION}=$data[2];
		$domain{DOMAIN_LINK}=$config->{PFAM_link}.$domain{DOMAIN_ACCESSION};
		$domain{DOMAIN_NAME}=$data[3];
		$domain{DOMAIN_DESCRIPTION}=$data[4];
		push(@{$para{LOOP_DOMAIN}},\%domain);
	}

	my $tmpl = $self->load_tmpl('sequencepage.tmpl');
	$self->defaults($tmpl);
	$tmpl->param(\%para);
	return $self->done($tmpl);
}

sub genome {
	my $self = shift;
	my $dbh = $self->dbh();
	my $q = $self->query();

	my %para;
	$para{PAGETITLE}="Release Summary";

	# my $query_num_taxa = $dbh->prepare('SELECT COUNT(*) FROM taxon');
	my $query_num_taxa = $dbh->prepare('SELECT COUNT(DISTINCT taxon_id) FROM dots.ExternalAASequence');
	$query_num_taxa->execute();
	my @tmp = $query_num_taxa->fetchrow_array();
	$para{NUM_TAXA}=$tmp[0];

	# my $query_num_sequences = $dbh->prepare('SELECT COUNT(*) FROM sequence');
	my $query_num_sequences = $dbh->prepare('SELECT COUNT(*) FROM dots.ExternalAASequence');
	$query_num_sequences->execute();
	@tmp = $query_num_sequences->fetchrow_array();
	$para{NUM_SEQUENCES}=$tmp[0];


	my (%description,%source,%url);
	while (<DATA>) {
		$_=~s/\r|\n//g;
		next if (/^\#/);
		next unless (length($_) >= 6);
		my @data = split("	",$_);
		$description{$data[0]}=$data[2];
		$source{$data[0]}=$data[3];
		$url{$data[0]}=$data[4];
	}

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
	
	# my $query_taxon = $dbh->prepare('SELECT * FROM taxon');
	my $query_taxon = $dbh->prepare('SELECT COUNT(DISTINCT taxon_id) FROM dots.ExternalAASequence');

	# my $query_numseq = $dbh->prepare('SELECT COUNT(*) FROM sequence WHERE taxon_id = ?');
	my $query_numseq = $dbh->prepare('SELECT COUNT(*) FROM dots.ExternalAASequence WHERE taxon_id = ?');

	# my $query_numseqclustered = $dbh->prepare('SELECT COUNT(*) FROM sequence INNER JOIN orthogroup USING (orthogroup_id) WHERE taxon_id = ?');
	my $query_numseqclustered = $dbh->prepare('SELECT COUNT(ogs.aa_sequence_id) 
	                                           FROM dots.ExternalAASequence eas,
	                                                apidb.OrthologGroupAaSequence ogs
	                                           WHERE eas.aa_sequence_id = ogs.aa_sequence_id
	                                             AND eas.taxon_id = ?');
	
	# my $query_numgroup = $dbh->prepare('SELECT COUNT(DISTINCT(sequence.orthogroup_id)) FROM sequence INNER JOIN orthogroup USING (orthogroup_id) WHERE taxon_id = ?');
	my $query_numgroup = $dbh->prepare('SELECT COUNT(DISTINCT(ogs.ortholog_group_id)) 
	                                           FROM dots.ExternalAASequence eas,
	                                                apidb.OrthologGroupAaSequence ogs
	                                           WHERE eas.aa_sequence_id = ogs.aa_sequence_id
	                                             AND eas.taxon_id = ?');
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
				$taxon{DATASOURCE}=$source{$data[2]};
				$taxon{URL}=$url{$data[2]};
			} elsif ($type eq 'summary') {
				$query_numseq->execute($data[0]);
				my @tmp = $query_numseq->fetchrow_array();
				$taxon{NUMSEQ}=$tmp[0];
				$query_numseqclustered->execute($data[0]);
				@tmp = $query_numseqclustered->fetchrow_array();
				$taxon{NUMSEQ_CLUSTERED}=$tmp[0];
				$query_numgroup->execute($data[0]);
				@tmp = $query_numgroup->fetchrow_array();
				$taxon{NUMGROUPS}=$tmp[0];
			}
		} else {
			$taxon{DESCRIPTION}=$description{$data[2]};
		}
		push(@{$para{LOOP_TAXON}},\%taxon);
	}

	my $tmpl = $self->load_tmpl('genomepage.tmpl');
	$self->defaults($tmpl);
	$tmpl->param(\%para);
	return $self->done($tmpl);
}

sub MSA {
	my $self = shift;
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
		
		my $query_msa = $dbh->prepare('SELECT multiple_sequence_alignment FROM apidb.OrthologGroup WHERE name = ?');
	    $query_msa->execute($ac);
    	if (my @data = $query_msa->fetchrow_array()) {
			$para{T}="Multiple Sequence Alignment for Group <font color=\"red\">$ac</font>";
			$para{CONTENT}.=$data[0];
		
		#my $old_ac = transformOGAC($ac);
		#my $file=$config->{MSA_dir}."$old_ac.clw";
		#if (-e $file) {
		#	$para{T}="Multiple Sequence Alignment for Group <font color=\"red\">$ac</font>";
		#	open(F,$file);
		#	while (<F>) {
		#		$para{CONTENT}.=$_;
		#	}
		#	close(F);
		} else {
			# $para{ERROR}="The file '$file' doesn't exist. Please check it later because we are updating data currently."
			$para{ERROR}="The MSA result doesn't exist. Please check it later because we are updating data currently."
		}
	}

	my $tmpl = $self->load_tmpl('empty.tmpl');
	$self->defaults($tmpl);
	$tmpl->param(\%para);
	return $self->done($tmpl);
}

sub BLGraph {
	my $self = shift;
	my $config = $self->param("config");
	my $dbh = $self->dbh();
	my $q = $self->query();

	my %para;
	my $ac;
	if (($ac = $q->param("groupac")) && ($q->param("svg"))) {
	    $para{PAGETITLE}="BioLayout Graph (SVG) for $ac";
	    my $old_ac = transformOGAC($ac);
	    my $file=$config->{BLSVG_dir}."$old_ac.bl.svg";
	    my $blsvg_src = $config->{BLSVG_url}."$old_ac.bl.svg";
	    if (-e $file) {
		open(TMPFILE,$file) or $para{ERROR}="The file '$file' can't be opened.";
		my $size;
		while (<TMPFILE>) {
		    last if (defined $size);
		    if (/\<svg (.*) xml\:xlink/) {$size=$1;}
		}
		$para{T} = "BioLayout Graph (SVG) for Group <font color=\"red\">$ac</font>";
		$para{CONTENT}="<embed src=\"$blsvg_src\" $size type=\"image/svg+xml\"></embed><p>Notes: In this graph, nodes represent proteins (species are color-coded); edges stand for three edge relationships: <font color=\"red\">reciprocal best hit across species</font>, <font color=\"green\">reciprocal better hit within species</font>, and <font color=\"#888888\">general edges</font>. You can switch these edges on and off by clicking the text in \"EDGES CONTROL\" box. Due to the large number of general edges, by default they are not shown until you switch them on. When you move your mouse over a certain node (or edge), associated information will be displayed in the \"INFORMATION\" box, the nodes from the same species will also be highlighted.";
	    } else {
		$para{ERROR}="The file '$file' doesn't exist. Please check it later because we are updating data currently."
	    }
	} elsif ($ac = $q->param("groupac")) {
	    $para{PAGETITLE}="BioLayout Graph for $ac";
	    my $old_ac = transformOGAC($ac);
	    my $file=$config->{BL_dir}."$old_ac.bl.png";
	    my $bl_src = $config->{BL_url}."$old_ac.bl.png";
	    if (-e $file) {
	    	$para{T}="BioLayout Graph for Group <font color=\"red\">$ac</font>";
			$para{CONTENT}="Link to <a href=\"cgi-bin/OrthoMclWeb.cgi?rm=BLGraph&groupac=$ac&svg=1\"><b>Interactive Graph (SVG)</b></a></font> <font size=\"1\">.    You may need a <a href=\"http://www.adobe.com/svg/viewer/install/main.html\">Scalable Vector Graphics Viewer</a></font>.<p><img src=\"$bl_src\">";
		} else {
			$para{ERROR}="The file '$file' doesn't exist. Please check it later because we are updating data currently."
		}
	}

	my $tmpl = $self->load_tmpl('empty.tmpl');
	$self->defaults($tmpl);
	$tmpl->param(\%para);
	return $self->done($tmpl);
}

sub getSeq {
	my $self = shift;
	my $config = $self->param("config");
	my $dbh = $self->dbh();
	my $q = $self->query();


	require Bio::Index::Fasta;
	my $inx = Bio::Index::Fasta->new('-filename' => $config->{FAIDX_file});
	
	if ($q->param("groupid") || $q->param("groupac")) {
		my %para;
		my $query_sequence;
		if (my $groupac = $q->param("groupac")) {
			$para{PAGETITLE}="FASTA Sequences for $groupac";
			# $query_sequence = $dbh->prepare('SELECT sequence.accession,sequence.description,taxon.name FROM taxon INNER JOIN sequence USING (taxon_id) INNER JOIN orthogroup USING (orthogroup_id) WHERE orthogroup.accession = ?');
			$query_sequence = $dbh->prepare('SELECT DISTINCT eas.source_id, eas.description, 
			                                        tn.unique_name_variant 
			                                 FROM apidb.OrthologGroup og,
			                                      apidb.OrthologGroupAaSequence ogs,
			                                      dots.ExternalAaSequence eas,
			                                      sres.TaxonName tn
			                                 WHERE og.ortholog_group_id = ogs.ortholog_group_id
			                                   AND ogs.aa_sequence_id = eas.aa_sequence_id
			                                   AND eas.taxon_id = tn.taxon_id
			                                   AND og.name = ?');

			$para{T}='FASTA Sequences for Group <font color="red">'.$groupac.'</font>';
			$query_sequence->execute($groupac);
		} elsif (my $groupid = $q->param("groupid")) {
			# $query_sequence = $dbh->prepare('SELECT sequence.accession,sequence.description,taxon.name FROM taxon INNER JOIN sequence USING (taxon_id) WHERE sequence.orthogroup_id = ?');
			$query_sequence = $dbh->prepare('SELECT DISTINCT eas.source_id, eas.description, 
			                                        tn.unique_name_variant 
			                                 FROM apidb.OrthologGroupAaSequence ogs,
			                                      dots.ExternalAaSequence eas,
			                                      sres.TaxonName tn
			                                 WHERE ogs.aa_sequence_id = eas.aa_sequence_id
			                                   AND eas.taxon_id = tn.taxon_id
			                                   AND ogs.ortholog_group_id = ?');
			$query_sequence->execute($groupid);
		}

		while (my @data = $query_sequence->fetchrow_array()) {
			my $ac = $data[0];
			my $desc = $data[1];
			my $taxon = $data[2];

			my $seq = $inx->fetch($ac);
			my $len = $seq->length();
			$para{CONTENT}.="\n<font face=\"Courier\" size=\"2\">>$desc [$taxon]<br>";
			for (my $i=1;$i<=$len;$i+=60) {
				if ($i+60-1>$len) {$para{CONTENT}.=$seq->subseq($i,$len)."<br>";} 
				else {$para{CONTENT}.=$seq->subseq($i,$i+60-1)."<br>";}
			}
			$para{CONTENT}.="</font>";
		}

		my $tmpl = $self->load_tmpl('empty.tmpl');
		$self->defaults($tmpl);
		$tmpl->param(\%para);
		return $self->done($tmpl);
	} elsif (my $querynumber = $q->param("querynumber")) {
		my $sequence_query_history = $self->session->param("SEQUENCE_QUERY_HISTORY");
		my $sequence_query_ids_history = $self->session->param("SEQUENCE_QUERY_IDS_HISTORY");
		# my $query_sequence = $dbh->prepare('SELECT sequence.accession,sequence.description,taxon.name FROM taxon INNER JOIN sequence USING (taxon_id) WHERE sequence.sequence_id = ?');
		my $query_sequence = $dbh->prepare('SELECT DISTINCT eas.source_id, eas.description, 
			                                        tn.unique_name_variant 
			                                 FROM dots.ExternalAaSequence eas,
			                                      sres.TaxonName tn
			                                 WHERE eas.taxon_id = tn.taxon_id
			                                   AND eas.aa_sequence_id = ?');

		my $file_content;
		foreach my $sequence_id (@{$sequence_query_ids_history->[$querynumber-1]}) {
			$query_sequence->execute($sequence_id);
			my @data = $query_sequence->fetchrow_array();
			my $ac = $data[0];
			my $desc = $data[1];
			my $taxon = $data[2];

			my $seq = $inx->fetch($ac);
			my $len = $seq->length();
			$file_content.=">$desc [$taxon]\r\n";
			for (my $i=1;$i<=$len;$i+=60) {
				if ($i+60-1>$len) {$file_content.=$seq->subseq($i,$len)."\r\n";} 
				else {$file_content.=$seq->subseq($i,$i+60-1)."\r\n";}
			}
		}

		my $file_name = 'OrthoMCL-DB_sequence_query_'.$querynumber.'.fasta';
		$self->header_props(
			-type=>'text/plain',
			'-Content-Disposition'=>'attachment; filename="'.$file_name.'"');
		return $file_content;
	}
}

sub blast {
    my $self = shift;
    my $config = $self->param("config");
    my $q = $self->query();
    my $dbh = $self->dbh();

    my $tmpl = $self->load_tmpl('empty.tmpl');
    $self->defaults($tmpl);

    my $querynumber;
    my $sequence_ids_ref;  # store all the sequence ids for current query

    my %para;
    $para{CONTENT}="<pre>";
    $para{PAGETITLE}="BLASTP Result";

    if (my $fasta = $q->param("q")) {
	my $fasta_name;
	if ($fasta=~/^\>(\S+)/) {
	  $fasta_name=$1;
	} else {$fasta_name='<unknown sequence>';}
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
	open(BLAST, $config->{BLAST}." -p blastp -i $tempfile -d ".$config->{FA_file}." -e 1e-5 |") or die $!;
	
	# my $query_sequence = $dbh->prepare('SELECT sequence_id, orthogroup_id FROM sequence WHERE sequence.accession = ?');
	my $query_sequence = $dbh->prepare('SELECT ogs.aa_sequence_id, ogs.ortholog_group_id 
	                                    FROM apidb.OrthologGroupAaSequence ogs, dots.ExternalAaSequence eas
	                                    WHERE ogs.aa_sequence_id = eas.aa_sequence_id
	                                      AND eas.source_id = ?');

	# my $query_orthogroup = $dbh->prepare('SELECT accession FROM orthogroup WHERE orthogroup_id = ?');
	my $query_orthogroup = $dbh->prepare('SELECT name FROM apidb.OrthologGroup WHERE ortholog_group_id = ?');
	
	while (<BLAST>) {
	    $_=~s/\r|\n//g;
	    if (/Sequences producing significant alignments/) {
		<BLAST>; # empty line
		$para{CONTENT}.="\n";
		while (<BLAST>) {
		    $_=~s/\r|\n//g;
		    if (m/^\s*$/) {$para{CONTENT}.="$_\n";last;}
		    if (m/^(\S+)(\s+)(\S+.*)/) {
			$query_sequence->execute($1);
			my ($sequence_id,$orthogroup_ac,$orthogroup_id);
			while (my @data = $query_sequence->fetchrow_array()) {
			    $sequence_id = $data[0];
			    $orthogroup_id = $data[1];
			}
			if (($sequence_id ne '') && ($orthogroup_id != 0)) {
			    $query_orthogroup->execute($orthogroup_id);
			    while (my @data = $query_orthogroup->fetchrow_array()) {
				$orthogroup_ac = $data[0];
			    }
			    push(@{$sequence_ids_ref},$sequence_id);
			    $para{CONTENT}.="<a href=\"/cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=$1\">$1</a> <a href=\"/cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupid=$orthogroup_id\">$orthogroup_ac</a>";
			    for (my $i=1;$i<=length($2)-length($orthogroup_ac)-1;$i++) {
				$para{CONTENT}.=' ';
			    }
			    $para{CONTENT}.="$3\n";
			} elsif ($sequence_id ne '') {
			    $para{CONTENT}.="<a href=\"/cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=$1\">$1</a>$2$3\n";
			} else {
			    $para{CONTENT}.="$1$2$3\n";
			}
		    }
		}
	    } elsif (/^\>(\S+)/) {
		$query_sequence->execute($1);
		my ($sequence_id,$orthogroup_ac,$orthogroup_id);
		while (my @data = $query_sequence->fetchrow_array()) {
		    $sequence_id = $data[0];
		    $orthogroup_id = $data[1];
		}
		if (($sequence_id ne '') && ($orthogroup_id != 0)) {
		    $query_orthogroup->execute($orthogroup_id);
		    while (my @data = $query_orthogroup->fetchrow_array()) {
			$orthogroup_ac = $data[0];
		    }
		    $para{CONTENT}.="><a href='/cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=$1'>$1</a> <a href='/cgi-bin/OrthoMclWeb.cgi?rm=sequenceList&groupid=$orthogroup_id'>$orthogroup_ac</a>\n";
		} elsif ($sequence_id ne '') {
		    $para{CONTENT}.="><a href='/cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=$1'>$1</a>\n";
		} else {
		    $para{CONTENT}.=">$1\n";
		}
	    } else {
		$para{CONTENT}.="$_\n";
	    }
	}

	close(BLAST);
	unlink($tempfile);

	if (not defined $sequence_ids_ref) {$sequence_ids_ref=[];}

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
      $self->session->param('SEQUENCE_QUERY_NUMBER',$querynumber);# store the current querynumber for later paging

    } else {
	$para{ERROR}="Please provide protein sequence for BLASTP!";
    }


    $tmpl->param(\%para);
    return $self->done($tmpl);
}

#drawDomain works for test values
sub drawDomain {
    my $self = shift;
    my $q = $self->query();

    my $length = $q->param("length");
    my $domain_red = $q->param("domain_red");
    my $domain_blue = $q->param("domain_blue");
    my $domain_green = $q->param("domain_green");
    my $domain_color_name = $q->param("domain_color");
    my $margin_x = $q->param("margin_x");
    my $scale_factor = $q->param("scale_factor");
    my $pos_y = $q->param("pos_y");
    my $dom_height = $q->param("dom_height");
    my $dom_xsize = $length*$scale_factor+1;
    my $dom_ysize = $dom_height+1;


    # domain image
    my $domain_image = new GD::Image($dom_xsize,$dom_ysize);
    my $domain_bg = $domain_image->colorAllocate(1,1,1);
    my $domain_black = $domain_image->colorAllocate(0,0,0);
    my $domain_color = $domain_image->colorAllocate($colors{$domain_color_name}[0],$colors{$domain_color_name}[1],$colors{$domain_color_name}[2]);

    $domain_image->transparent($domain_bg);
    $domain_image->filledRectangle(0,0,$margin_x+$length*$scale_factor,$dom_height,$domain_color);
    $domain_image->rectangle(0,0,$dom_xsize-1,$dom_ysize-1,$domain_black);

    print CGI::header("image/png"), $domain_image->png(9);
}

#drawProtein returns image, but has no domains drawn
sub drawProtein {
    my $self = shift;
    my $q = $self->query();
    
    # need to find another way to pass in hashtables of 'key'->[values]
    my $margin_x = $q->param("margin_x");
    my $scale_factor = $q->param("scale_factor");
    my $pos_y = $q->param("pos_y");
    my $size_x = $q->param("size_x");
    my $size_y = $q->param("size_y");
    my $dom_height = $q->param("dom_height");
    my $length = $q->param("length");
    my $length_max = $q->param("length_max");
    my $tick_step = $q->param("tick_step");
    my $margin_y = $q->param("margin_y");
    my $spacer_height = $q->param("spacer_height");
    my $num_domains = $q->param("num_domains");

    my @domain_info;
    #pass in to, from, r, g, b
    #or is it easier to pass in: to, from...
    #and then r,g,b...

    # or pass in as string, to,from,r,g,b,...
    # and then split string on ,
    # and then iterate over?
    #for (my $i=0;$i<$num_domains;$i++) {
	#my @cur_domain;

	#push(@cur_domain,$q->param("domain_from$i"));
	#push(@cur_domain,$q->param("domain_to$i"));
	#push(@cur_domain,$q->param("domain_red$i"));
	#push(@cur_domain,$q->param("domain_green$i"));
	#push(@cur_domain,$q->param("domain_blue$i"));

	#push (@domain_info, @cur_domain);
    #}

    my $image = new GD::Image($size_x,$dom_height+1);

    my $image_bg = $image->colorAllocate(1,1,1);
    my $image_black = $image->colorAllocate(0,0,0);
    my $image_gray = $image->colorAllocate(153,153,153);

    $image->transparent($image_bg);

    my $tick_len=4;
    for (my $i=0;$i<=$length_max;$i+=$tick_step) {
	$image->line($margin_x+$i*$scale_factor,0,$margin_x+$i*$scale_factor,$dom_height,$image_gray);
    }

    $image->filledRectangle($margin_x+1,3,$margin_x+$length*$scale_factor,7,$image_gray);
     
   for (my $i=0;$i<$num_domains;$i++) {
	my $from = $q->param("domain_from$i");
	my $to = $q->param("domain_to$i");
	my $color = $q->param("domain_color$i");
	my $domain_color = $image->colorAllocate($colors{$color}[0],$colors{$color}[1],$colors{$color}[2]);

	$image->filledRectangle($margin_x+$from*$scale_factor,0,$margin_x+$to*$scale_factor,$dom_height,$domain_color);
	$image->rectangle($margin_x+$from*$scale_factor,0,$margin_x+$to*$scale_factor,$dom_height,$image_black);
    }
    
    print CGI::header("image/png"), $image->png(9);
}

#drawScale works for test values
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
    my $image_color = $image->colorAllocate($colors{$scale_color}[0],$colors{$scale_color}[1],$colors{$scale_color}[2]);
    $image->transparent($image_bg);
    $image->line($margin_x,4,$margin_x+$length_max*$scale_factor,4,$image_color);
    my $tick_len=4;
    for (my $i=0;$i<=$length_max;$i+=$tick_step) {
	$image->line($margin_x+$i*$scale_factor,4,$margin_x+$i*$scale_factor,4+$tick_len,$image_color);
	if ($tick_len==4) {
	    $image->string(gdTinyFont,$margin_x+$i*$scale_factor-1.5-(length($i)-1)*5/2,4+5,$i,$image_color);
	    $tick_len=2;
	    }
	else {$tick_len=4;}
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

1;  # Perl requires this at the end of all modules


__DATA__
aae	Bacteria	Bacteria: Aquifex	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Aquifex_aeolicus/
tma	Bacteria	Bacteria: Thermotoga	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Thermotoga_maritima/
det	Bacteria	Bacteria: Green nonsulfur bacteria	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Dehalococcoides_ethenogenes_195
dra	Bacteria	Bacteria: Deinococci	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Deinococcus_radiodurans/
tpa	Bacteria	Bacteria: Spirochetes	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Treponema_pallidum/
cte	Bacteria	Bacteria: Green sulfur bacteria	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Chlorobium_tepidum_TLS/
rba	Bacteria	Bacteria: Planctomyces/Pirella	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Pirellula_sp/
cpn	Bacteria	Bacteria: Chlamydia	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Chlamydophila_pneumoniae_CWL029/
syn	Bacteria	Bacteria: Cyanobacteria	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Synechococcus_sp_WH8102/
mtu	Bacteria	Bacteria: Actinobacteria	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Mycobacterium_tuberculosis_H37Rv/
ban	Bacteria	Bacteria: Gram-positive	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Bacillus_anthracis_Ames/
wsu	Bacteria	Bacteria: epsilon-proteobacteria	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Wolinella_succinogenes/
gsu	Bacteria	Bacteria: delta-proteobacteria	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Geobacter_sulfurreducens/
atu	Bacteria	Bacteria: alpha-proteobacteria	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Agrobacterium_tumefaciens_C58_UWash/
rso	Bacteria	Bacteria: beta-proteobacteria	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Ralstonia_solanacearum/
eco	Bacteria	Bacteria: gamma-proteobacteria	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Escherichia_coli_K12/

hal	Archaea	Archaea: Euryarchaeota	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Halobacterium_sp/
mja	Archaea	Archaea: Euryarchaeota	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Methanococcus_jannaschii/
sso	Archaea	Archaea: Crenarchaeota	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Sulfolobus_solfataricus/
neq	Archaea	Archaea: Nanoarchaeota	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Nanoarchaeum_equitans/

ehi	Single-Cellular Eukaryota	amoebae	TIGR	ftp://ftp.tigr.org/pub/data/Eukaryotic_Projects/e_histolytica/annotation_dbs/EHA1.pep
ddi	Single-Cellular Eukaryota	social amoebae, slime mold	dictyBase	http://www.dictybase.org/db/cgi-bin/dictyBase/download/download.pl?area=blast_databases&ID=dicty_primary_protein.gz
pfa	Single-Cellular Eukaryota	APICOMPLEXA	PlasmoDB, v4.4	http://plasmodb.org/restricted/data/P_falciparum/WG/cds.aa/Pfa3D7_WholeGenome_Annotated_PEP_2005.2.11.fasta
pyo	Single-Cellular Eukaryota	APICOMPLEXA	PlasmoDB, v4.4	http://www.plasmodb.org/restricted/data/P_yoelii/Whole_genome/cds.aa/Pyoelii_WholeGenome_Annotated_PEP_2002.9.10.fasta
pkn	Single-Cellular Eukaryota	APICOMPLEXA	PlasmoDB, v4.3	http://www.plasmodb.org/restricted/data/P_knowlesi/WG/cds.aa/pkn_prots.db
cpa	Single-Cellular Eukaryota	APICOMPLEXA	CryptoDB	http://cryptodb.org/download/public/pep/genomic/CpIOWA/CpIOWA_protein.gz
cho	Single-Cellular Eukaryota	APICOMPLEXA	CryptoDB	http://cryptodb.org/download/public/pep/genomic/ChTU502/ChTU502_protein.gz
tgo	Single-Cellular Eukaryota	APICOMPLEXA	ToxoDB	N/A
the	Single-Cellular Eukaryota	APICOMPLEXA	TIGR	ftp://ftp.tigr.org/pub/data/Eukaryotic_Projects/t_parva/annotation_dbs/
sce	Single-Cellular Eukaryota	FUNGI	SGD	ftp://genome-ftp.stanford.edu/pub/yeast/sequence/genomic_sequence/orf_protein/orf_trans_all.fasta.gz
spo	Single-Cellular Eukaryota	FUNGI	Sanger	ftp://ftp.sanger.ac.uk/pub/yeast/pombe/Protein_data/pompep
yli	Single-Cellular Eukaryota	FUNGI	Genolevures	http://cbi.labri.u-bordeaux.fr/Genolevures/raw/seq/Y_lipolytica.rc2.aa
kla	Single-Cellular Eukaryota	FUNGI	Genolevures	http://cbi.labri.u-bordeaux.fr/Genolevures/raw/seq/K_lactis.rc2.aa
dha	Single-Cellular Eukaryota	FUNGI	Genolevures	http://cbi.labri.u-bordeaux.fr/Genolevures/raw/seq/D_hansenii.rc2.aa
cgl	Single-Cellular Eukaryota	FUNGI	Genolevures	http://cbi.labri.u-bordeaux.fr/Genolevures/raw/seq/C_glabrata.rc2.aa
ecu	Single-Cellular Eukaryota	FUNGI	GenBank	ftp://ftp.ncbi.nih.gov/genomes/Encephalitozoon_cuniculi/*.faa
cne	Single-Cellular Eukaryota	FUNGI	TIGR	ftp://ftp.tigr.org/pub/data/Eukaryotic_Projects/c_neoformans/annotation_dbs/CNA1.pep
ago	Single-Cellular Eukaryota	FUNGI	AGD	http://agd.unibas.ch/Ashbya_gossypii/downloads/AGD_ORF_translations_r2_1.fas
ncr	Single-Cellular Eukaryota	FUNGI	WI	ftp://www-genome.wi.mit.edu/pub/annotation/N_crassa/release7/neurospora_crassa_7_proteins.fasta.gz
cme	Single-Cellular Eukaryota	Red algae	UTOKYO	http://merolae.biol.s.u-tokyo.ac.jp/download/cds.fasta.txt
tps	Single-Cellular Eukaryota	Diatom	JGI	ftp://ftp.jgi-psf.org/pub/JGI_data/Diatom/thaps1/thaps1Prots.fasta.gz
ath	Multi-Cellular Eukaryota	PLANTS	TIGR	ftp://ftp.tigr.org/pub/data/a_thaliana/ath1/SEQUENCES/ATH1.pep.gz
osa	Multi-Cellular Eukaryota	PLANTS, rice	TIGR	ftp://ftp.tigr.org/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/BAC_PAC_clones/OSA1.pep
cel	Multi-Cellular Eukaryota	NEMATODES	WORMBASE	ftp://ftp.wormbase.org/pub/wormbase/data_freezes/WS140/acedb/wormpep140.tar.gz
cbr	Multi-Cellular Eukaryota	NEMATODES	SANGER	ftp://ftp.sanger.ac.uk/pub/wormbase/cbriggsae/cb25.agp8/brigpep2.pep.gz
dme	Multi-Cellular Eukaryota	ARTHROPODA, fruit fly	ensembl	ftp://ftp.ensembl.org/pub/fly-30.3d/data/fasta/pep/Drosophila_melanogaster.BDGP3.2.1.apr.pep.fa.gz
aga	Multi-Cellular Eukaryota	ARTHROPODA, mosquito	ensembl	ftp://ftp.ensembl.org/pub/anopheles-30.2e/data/fasta/pep/Anopheles_gambiae.MOZ2a.apr.pep.fa.gz
cin	Multi-Cellular Eukaryota	FISH, sea squirt	JGI	ftp://ftp.jgi-psf.org/pub/JGI_data/Ciona/v1.0/ciona.prot.fasta.gz
fru	Multi-Cellular Eukaryota	FISH, fugu	ensembl	ftp://ftp.ensembl.org/pub/fugu-30.2e/data/fasta/pep/Fugu_rubripes.FUGU2.apr.pep.fa.gz
tni	Multi-Cellular Eukaryota	FISH, teleost fish 	ensembl	ftp://ftp.ensembl.org/pub/tetraodon-30.1b/data/fasta/pep/Tetraodon_nigroviridis.TETRAODON7.apr.pep.fa.gz
dre	Multi-Cellular Eukaryota	FISH, zebrafish	ensembl	ftp://ftp.ensembl.org/pub/zebrafish-30.4c/data/fasta/pep/Danio_rerio.ZFISH4.apr.pep.fa.gz
hsa	Multi-Cellular Eukaryota	PRIMATES, human	ensembl	ftp://ftp.ensembl.org/pub/human-30.35c/data/fasta/pep/Homo_sapiens.NCBI35.apr.pep.fa.gz
mmu	Multi-Cellular Eukaryota	MAMMALS, mouse	ensembl	ftp://ftp.ensembl.org/pub/mouse-30.33f/data/fasta/pep/Mus_musculus.NCBIM33.apr.pep.fa.gz
rno	Multi-Cellular Eukaryota	MAMMALS, Brown Norway Rat	ensembl	ftp://ftp.ensembl.org/pub/rat-30.34/data/fasta/pep/Rattus_norvegicus.RGSC3.4.apr.pep.fa.gz
gga	Multi-Cellular Eukaryota	BIRD, chicken	ensembl	ftp://ftp.ensembl.org/pub/chicken-30.1f/data/fasta/pep/Gallus_gallus.WASHUC1.apr.pep.fa.gz
