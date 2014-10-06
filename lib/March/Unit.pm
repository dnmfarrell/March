use strict;
use warnings;
package March::Unit;

use feature qw/signatures postderef/;
no warnings 'experimental';
use Math::Shape::Circle;
use March::Log;

sub new ($class, $id, $type, $name, $profile)
{
    March::Log->instance()->log_msg("Creating new $class of type $type");
    bless {
        id      => $id,
        type    => $type,
        name    => $name,
        profile => $profile,
        size    => 8,
    }, $class;
}

sub spawn ($self, $x, $y)
{
    die 'Already spawned!' if $self->{loc};
    $self->{loc} = Math::Shape::Circle->new($x, $y, $self->{size});
    March::Log->instance->log_msg("Spawned new unit $self->{type}, #$self->{id}, at " . $self->location);
    $self;
}

sub location ($self)
{
    "$self->{loc}{center}{x}, $self->{loc}{center}{y}";
}

sub collides ($self, $shape)
{
    $self->{loc}->collides($shape);
}

1;
