package March::Actor::Player;
use Role::Tiny;
use Role::Tiny::With;
use 5.020;
use feature 'signatures';
no warnings 'experimental';

with qw/March::Attribute::Name
        March::Attribute::HadPhase
        March::Attribute::HadTurn
        March::Actor/;


sub new ($class, $name)
{
    my $self = bless {}, $class;
    $self->name($name);

    $self;
}

1;
