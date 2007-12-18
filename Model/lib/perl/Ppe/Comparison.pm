package Ppe::Comparison;

sub new {
    my ($class,
	$operands,   # one or more species or clades
	$comparator, # '=', '<', '>', '>=', '<='
	$value,      # numeric value 
	$proteinOrTaxonFlag # 'P' or 'T'
	= @_;

    my $self = {};

    bless($class,$self);
    $self->{operands} = $operands; 
    $self->{comparator} = $comparator;
    $self->{value} = $value;
    $self->{proteinOrTaxonFlag} = $proteinOrTaxonFlag;
   return $self;
}

sub toString {
    my ($self) = @_;

    @typedOperands = map {$_ . "_$self->{proteinOrTaxonFlag}" } @$self->{operands};
    $operandsString = join(" + ", $typedOperands);
    print "($operandsString $comparator $value)";
}

sub toSqlString {
    my ($self, $columnMgr) = @_;

    @typedOperands = map {$columnMgr->getColumn($_, _$self->{proteinOrTaxonFlag}) } @$self->{operands};
    $operandsString = join(" + ", $typedOperands);
    print "($operandsString $comparator $value)";
}

