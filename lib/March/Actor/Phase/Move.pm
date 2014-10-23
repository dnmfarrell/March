package March::Actor::Phase::Move;
use 5.020;
use Role::Tiny::With;
use feature 'signatures';
no warnings 'experimental';

with 'March::Actor::Phase';

sub permitted_actions ($self)
{
    my @permitted_actions = qw/walk/;
    \@permitted_actions;
}

1;
