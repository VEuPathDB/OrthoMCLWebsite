package CommandQueryPhyPat;

use strict;

our @debug;
our @error;


sub query_phy_pat {
	my $query=$_[0];
	my $dbh=$_[1];

	my %tid;my @all_tac;
	my $query_alltaxa = $dbh->prepare('SELECT * FROM taxon');
	$query_alltaxa->execute();
	while (my @data = $query_alltaxa->fetchrow_array()) {
		$tid{$data[2]}=$data[0];
		push(@all_tac,$data[2]);
	}

#	push(@debug,$query);
	$query =~ s/\s+//g;
#	push(@debug,$query);

#	$query = lc($query);
	$query =~ s/and|AND/&/g;
	$query =~ s/or|OR/|/g;
#	replace the group query
	$query =~ s/BAC/aae+tma+det+dra+tpa+cte+rba+cpn+syn+mtu+ban+wsu+gsu+atu+rso+eco/g;
		$query =~ s/PRO/wsu+gsu+atu+rso+eco/g;
	$query =~ s/ARC/hal+mja+sso+neq/g;
	$query =~ s/EUK/ehi+ddi+pfa+pyo+pvi+pkn+cpa+cho+tgo+the+sce+spo+yli+kla+dha+cgl+ecu+cne+ago+ncr+cme+tps+ath+osa+cel+cbr+dme+aga+cin+fru+tni+dre+hsa+mmu+rno+gga/g;
		$query =~ s/VIR/cme+tps+ath+osa/g;
		$query =~ s/ALV/the+tgo+cpa+cho+pfa+pyo+pkn/g;
		$query =~ s/API/pfa+pyo+pkn+cpa+cho+tgo+the/g;
			$query =~ s/COC/tgo+cpa+cho/g;
			$query =~ s/HAE/pfa+pyo+pkn/g;
		$query =~ s/FUN/sce+spo+yli+kla+dha+cgl+ecu+cne+ago+ncr/g;
		$query =~ s/MET/cel+cbr+dme+aga+cin+fru+tni+dre+gga+mmu+rno+hsa/g;
			$query =~ s/ART/dme+aga/g;
			$query =~ s/DEU/cin+fru+tni+dre+gga+mmu+rno+hsa/g;
				$query =~ s/BON/fru+tni+dre/g;
				$query =~ s/TET/gga+mmu+rno+hsa/g;
					$query =~ s/MAM/mmu+rno+hsa/g;
						$query =~ s/PRI/hsa/g;
#	replacement of the group "ALL" should be put right before processing query
#	if ($query =~ /ALL|all/) {
#		my $all_tac_list = join("+",@all_tac);
#		$query =~ s/ALL|all/$all_tac_list/g;
#	}
#	replacement of the group "OTHER" should be put right before processing query
	if ($query =~ /OTHER|other/) {
		my @present_tac = split(/[\+\>\=\<\&\|\(\)\s]/,$query);
		my %present_flag;
		my @other_tac;
		foreach (@present_tac) {$present_flag{$_} = 1;}
		foreach (@all_tac) {push(@other_tac, $_) unless (defined $present_flag{$_});}
		my $other_tac_list = join("+",@other_tac);
		$query =~ s/OTHER|other/$other_tac_list/g;
	}


	$query=$query.'#';
	my @char;

	my $query_length = length($query);
	for (my $i=0;$i<=$query_length-1;$i++) {
		push(@char,substr($query,$i,1));
	}

	my @optr; #store & | ( ) and dummy operator #
	my @opnd; #store reference to cluster id array
	my $expression;

	push(@optr,'#');

	my $letter = shift(@char);

	while (($letter ne '#') || ($optr[$#optr] ne '#')) {
		if ($letter =~ /[a-zA-Z\+\>\=\<\d]/) {
			$expression.=$letter;
			$letter = shift(@char);
		} elsif ($letter =~ /[\&\|\(\)\#]/) {
			if ($expression) {
				my ($cluster_ref,$debug_ref) = get_cluster($expression,$dbh);
				push(@debug,@$debug_ref);
				$expression = '';
				push(@opnd,$cluster_ref);
			}
			my $curr_optr = $letter;
			my $pre_optr  = $optr[$#optr];
			my $relation  = optr_relation($pre_optr,$curr_optr);
			if ($relation eq ">") {
				my $pre_optr = pop(@optr);
				my $opnd_b   = pop(@opnd);
				my $opnd_a   = pop(@opnd);
				push(@opnd,merge_two_clusters($opnd_a,$pre_optr,$opnd_b));
			} elsif ($relation eq "<") {
				push(@optr,$curr_optr);
				$letter = shift(@char);

			} elsif ($relation eq "=") {
				pop(@optr);
				$letter = shift(@char);
			}
		} else {$letter = shift(@char);}
	}
			if ($expression) {
				my ($cluster_ref,$debug_ref) = get_cluster($expression,$dbh);
				push(@debug,@$debug_ref);
				$expression = '';
				push(@opnd,$cluster_ref);
			}

	return ($opnd[$#opnd],\@debug,\@error);
}

sub optr_relation {

	my $optr_a = $_[0];
	my $optr_b = $_[1];
	my %rel = (
		'&'=>{'&'=>'>','|'=>'>','('=>'<',')'=>'>','#'=>'>'},
		'|'=>{'&'=>'>','|'=>'>','('=>'<',')'=>'>','#'=>'>'},
		'('=>{'&'=>'<','|'=>'<','('=>'<',')'=>'=','#'=>'' },
		')'=>{'&'=>'>','|'=>'>','('=>'', ')'=>'>','#'=>'>'},
		'#'=>{'&'=>'<','|'=>'<','('=>'<',')'=>'', '#'=>'='},
	);
	if ($rel{$optr_a}->{$optr_b}) {return $rel{$optr_a}->{$optr_b};}
	else {
		print "ERROR! Operator sequential error: $optr_a $optr_b\n";
		die "ERROR! Operator sequential error: $optr_a $optr_b\n";
		push(@error,"ERROR! Operator sequential error: $optr_a $optr_b\n");
	}
}

sub merge_two_clusters {
	my @cluster_a = @{$_[0]};
	my $operation =   $_[1];
	my @cluster_b = @{$_[2]};
	if ($operation eq "&") {
		my %is;
		my @return_cluster;
		foreach (@cluster_a) {$is{$_}++;}
		foreach (@cluster_b) {$is{$_}++;}
		foreach (keys %is) {
			push(@return_cluster,$_) if ($is{$_}==2);
		}
		return \@return_cluster;
	} elsif ($operation eq "|") {
		my %is;
		my @return_cluster;
		foreach (@cluster_a) {$is{$_}++;}
		foreach (@cluster_b) {$is{$_}++;}
		foreach (keys %is) {
			push(@return_cluster,$_) if ($is{$_}>=1);
		}
		return \@return_cluster;
	}
}

sub get_cluster {
	my $expression = $_[0];
	my $dbh        = $_[1];
	my @debug;

	my $tac_line;
	my $compare;
	my $number;
	my $by_taxon;

#	push(@debug,"expression: $expression");

	if ($expression =~ /([a-zA-Z\+]+)([\>\=\<]+)(\d+)([tT]{0,1})/) {
		$tac_line=$1;
		$compare = $2;
		$number  = $3;
		$by_taxon= $4 || 0;
		$tac_line=~s/\+/\"\, \"/g;
		$tac_line='"'.$tac_line.'"';
	} else {print "ERROR! $expression\n"; die "ERROR! $expression\n";}

	my @return_cluster;

	my $sql_string;
	if ($by_taxon) {
		if ($tac_line eq '"all"' or $tac_line eq '"ALL"') {
			$sql_string = "SELECT sequence.orthogroup_id FROM sequence INNER JOIN taxon USING (taxon_id) WHERE sequence.orthogroup_id <> 0 GROUP BY sequence.orthogroup_id HAVING COUNT(DISTINCT(taxon.abbrev)) $compare $number;";
		} else {
			if (($compare eq '=') && ($number eq '0')) {
				$sql_string = "SELECT orthogroup_id FROM orthogroup AS a1 WHERE NOT EXISTS (SELECT a2.orthogroup_id FROM orthogroup AS a2 INNER JOIN sequence on (a2.orthogroup_id=sequence.orthogroup_id) INNER JOIN taxon USING (taxon_id) WHERE a1.orthogroup_id=a2.orthogroup_id AND taxon.abbrev IN ($tac_line))";
			} else {
				$sql_string = "SELECT sequence.orthogroup_id FROM sequence INNER JOIN taxon USING (taxon_id) WHERE sequence.orthogroup_id <> 0 AND taxon.abbrev IN ($tac_line) GROUP BY sequence.orthogroup_id HAVING COUNT(DISTINCT(taxon.abbrev)) $compare $number;";
			}
		}
	} else {
		if ($tac_line eq '"all"' or $tac_line eq '"ALL"') {
			$sql_string = "SELECT sequence.orthogroup_id FROM sequence INNER JOIN taxon USING (taxon_id) WHERE sequence.orthogroup_id <> 0 GROUP BY sequence.orthogroup_id HAVING COUNT(*) $compare $number;";
		} else {
			if (($compare eq '=') && ($number eq '0')) {
			    $sql_string = "SELECT orthogroup_id FROM orthogroup AS a1 WHERE NOT EXISTS (SELECT a2.orthogroup_id FROM orthogroup AS a2 INNER JOIN sequence on (a2.orthogroup_id=sequence.orthogroup_id) INNER JOIN taxon USING (taxon_id) WHERE a1.orthogroup_id=a2.orthogroup_id AND taxon.abbrev IN ($tac_line))";
			} else {
				$sql_string = "SELECT sequence.orthogroup_id FROM sequence INNER JOIN taxon USING (taxon_id) WHERE sequence.orthogroup_id <> 0 AND taxon.abbrev IN ($tac_line) GROUP BY sequence.orthogroup_id HAVING COUNT(*) $compare $number;";
			}
		}
	}
	my $query_phypat = $dbh->prepare($sql_string);
	$query_phypat->execute();

	while (my @data = $query_phypat->fetchrow_array()) {
		push(@return_cluster,$data[0]);
	}

	push(@debug,$sql_string);
	push(@debug,scalar(@return_cluster)." group hit");
	return \@return_cluster,\@debug;
}


1;
