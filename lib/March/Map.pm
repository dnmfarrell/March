package March::Map;
use 5.020;
use warnings;
use feature 'signatures';
no warnings 'experimental';
use Carp;
use Math::Shape::Rectangle;

sub new ($class, $width, $height)
{
    croak 'Map::new requires width and height arguments to be > 0'
        unless $width > 0 && $height > 0;

    bless { grid => Math::Shape::Rectangle->new(0,0, $width, $height) }, $class;
}

=head2 within_bounds

Checks that the vector is within the bounds of the March::Map object.

=cut

sub within_bounds ($self, $position)
{
    $self->{grid}->collides($position);
}

1;
