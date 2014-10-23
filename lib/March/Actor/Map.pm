package March::Actor::Map;
use Role::Tiny::With;
use 5.020;
use feature 'signatures';
no warnings 'experimental';

with qw/March::Attribute::Name
        March::Attribute::Rectangle/;

sub new ($class, $name, $x, $y)
{
    my $self = bless {}, $class;
    $self->name($name);
    $self->square($x, $y);

    $self;
}

1;
