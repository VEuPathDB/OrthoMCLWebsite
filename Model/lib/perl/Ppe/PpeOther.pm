package PpeOther;

sub new {
    my ($class, 
	$relation, # 'eq', 'lt', 'gt', 'lte', 'gte'
	$value)    # numeric value
	= @_;

    my $self = {};

    bless($class,$self);
    $self->{relation} = $relation;
    $self->{value} = $value;
    return $self;
}

sub toString {
    $operandsString = join(" + ", $self->{operands});
    print "($operandsString $relation $result)";
}

