package March::Component::HadPhase;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';
use Carp;

sub had_phase ($self, $bool)
{
    $self->{had_phase} = $bool;
}

1;
