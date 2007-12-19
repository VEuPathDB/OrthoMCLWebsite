package OrthoMCLWebsite::Model::Ppe::Comparison;

use strict;
use Data::Dumper;

sub new {
    my ($class,
	$taxa,   # one or more species or clades
	$comparator, # '=', '<', '>', '>=', '<='
	$value,      # numeric value 
	$proteinOrTaxonFlag) # 'P' or 'T'
	= @_;

    my $self = {};

    bless($self,$class);
    $self->{taxa} = $taxa;
    $self->{comparator} = $comparator;
    $self->{value} = $value;
    $self->{proteinOrTaxonFlag} = $proteinOrTaxonFlag;
    print STDERR Dumper($self);

    return $self;
}

sub toString {
    my ($self) = @_;

    my @typedTaxa = map { $_ . "_$self->{proteinOrTaxonFlag}" } @{$self->{taxa}};
    my $taxaString = join(" + ", @typedTaxa);
    return "($taxaString $self->{comparator} $self->{value})";
}

sub toSqlString {
    my ($self, $columnMgr) = @_;

    my @columns = map { $columnMgr->getColumnName($_ . "_$self->{proteinOrTaxonFlag}") } @{$self->{taxa}};
    my $taxaString = join(" + ", @columns);
    return "($taxaString $self->{comparator} $self->{value})";
}

1;
