package March::Component::Move::Allowance;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';

sub move_allowance ($self)
{
    $self->{move_allowance};
}

1;
