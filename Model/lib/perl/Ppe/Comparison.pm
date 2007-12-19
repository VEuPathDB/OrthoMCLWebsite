package OrthoMCLWebsite::Model::Ppe::Comparison;

use strict;

sub new {
    my ($class,
	$taxa,   # one or more species or clades
	$comparator, # '=', '<', '>', '>=', '<='
	$value,      # numeric value 
	$proteinOrTaxonFlag) # 'P' or 'T'
	= @_;

    my $self = {};

    bless($class,$self);
    $self->{taxa} = $taxa; 
    $self->{comparator} = $comparator;
    $self->{value} = $value;
    $self->{proteinOrTaxonFlag} = $proteinOrTaxonFlag;
    return $self;
}

sub toString {
    my ($self) = @_;

    @typedTaxa = map { $_ . "_$self->{proteinOrTaxonFlag}" } @$self->{taxa};
    my $taxaString = join(" + ", $typedTaxa);
    return "($taxaString $self->{comparator} $self->{value})";
}

sub toSqlString {
    my ($self, $columnMgr) = @_;

    my @columns = map { $columnMgr->getColumn($_ . "_$self->{proteinOrTaxonFlag}") } @$self->{taxa};
    my $taxaString = join(" + ", $colmns);
    return "($taxaString $self->{comparator} $self->{value})";
}

