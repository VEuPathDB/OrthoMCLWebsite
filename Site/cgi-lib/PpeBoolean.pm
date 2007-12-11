package PpeBoolean;

sub new {
    my ($class, 
	$operands, # one or more PpeSums or PpeBooleans
	$operator, # 'AND' or 'OR'
	$other)    # undef or a PpeOther
	= @_;

    my $self = {};

    bless($class,$self);
    $self->{operator} = $operator;
    $self->{operands} = $operand;
    $self->{other} = $other;
    return $self;
}

sub toString {
    print "(";
    my @operandsAsStrings = map {$_->toString()} @{$self->{operands}};
    push(@operandsAsStrings, $other->toString()) if $other;
    print join(" $operator ", @operandsAsStrings);
    print ")";
}

