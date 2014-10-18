package March::Tabletop;
use 5.020;
use warnings;
use feature 'signatures';
no warnings 'experimental';
use Carp;

sub new ($class, $rectangle)
{
    croak 'new requires a Math::Shape::Rectangle object'
        unless $rectangle->isa('Math::Shape::Rectangle');

    bless { grid => $rectangle }, $class;
}

=head2 within_bounds

Checks that the vector is within the bounds of the Tabletop object.

=cut

sub within_bounds ($self, $position)
{
    croak "__SUB__ requires a Math::Shape::Vector object"
        unless $position->isa('Math::Shape::Vector');

    $self->{grid}->collides($position);
}

1;
