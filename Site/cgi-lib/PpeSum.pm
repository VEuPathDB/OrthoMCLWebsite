package PpeSum;

sub new {
    my ($class, $operands, $relation, $result, $proteinOrTaxonFlag) = @_;

    my $self = {};

    bless($class,$self);
    $self->{operands} = $operands; 
    $self->{relation} = $relation; # =, >=, >, <, <=
    $self->{result} = $result;
    $self->{proteinOrTaxonFlag} = $proteinOrTaxonFlag; # P T
   return $self;
}

sub toString {
    my ($self) = @_;

    @typedOperands = map {$_ . "_$self->{proteinOrTaxonFlag}" } @$self->{operands};
    $operandsString = join(" + ", $typedOperands);
    print "($operandsString $relation $result)";
}

