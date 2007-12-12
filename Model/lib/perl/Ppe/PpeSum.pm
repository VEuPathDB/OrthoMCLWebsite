package PpeSum;

sub new {
    my ($class,
	$operands, # one or more species or clades
	$relation, # 'eq', 'lt', 'gt', 'lte', 'gte'
	$value,    # numeric value
	$proteinOrTaxonFlag)  # 'P' or 'T'
	= @_;

    my $self = {};

    bless($class,$self);
    $self->{operands} = $operands; 
    $self->{relation} = $relation;
    $self->{value} = $value;
    $self->{proteinOrTaxonFlag} = $proteinOrTaxonFlag;
   return $self;
}

sub toString {
    my ($self) = @_;

    @typedOperands = map {$_ . "_$self->{proteinOrTaxonFlag}" } @$self->{operands};
    $operandsString = join(" + ", $typedOperands);
    print "($operandsString $relation $value)";
}

