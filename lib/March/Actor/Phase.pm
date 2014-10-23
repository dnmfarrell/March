package March::Actor::Phase;
use 5.020;
use Role::Tiny;
use feature qw/signatures postderef/;
no warnings 'experimental';

requires 'permitted_actions';

sub new ($class) { bless {}, $class }

sub action_is_allowed ($self, $action)
{
    grep /$action/, $self->permitted_actions->@*;
}

sub name ($self)
{
    my @name = split(/::/, ref $self);
    $name[$#name];
}

1;
