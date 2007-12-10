package PpeBoolean;

sub new {
    my ($class, $operands, $operator, $other, $proteinOrTaxonFlag) = @_;

    my $self = {};

    bless($class,$self);
    $self->{operator} = $operator;
    $self->{operands} = [$operand];
    return $self;
}

sub addOperand {
    my ($self, $operand) = @;
    push(@{$self->{operands}}, $operand);
}

sub toString {
    $operandsString = join(" + ", $self->{operands});
    print "($operandsString $relation $result)";
}

