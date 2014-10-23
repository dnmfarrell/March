package March::Attribute::HadTurn;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';
use Carp;

sub had_turn ($self, $bool)
{
    $self->{had_turn} = $bool;
}

1;
