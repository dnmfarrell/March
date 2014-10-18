package March::Action::Move;
use 5.020;
use Role::Tiny;
use Math::Shape::Vector;
use March::Msg;
use March::Game;
use feature 'signatures';
no warnings 'experimental';
use Carp;

requires qw/id position/;

=head2 move

Moves the actor to a new vector requires a L<Math::Shape::Vector> object as an argument. Returns the new vector.

=cut


sub move ($self, $end_vector)
{
    croak 'perform requires a Math::Shape::Vector object'
        unless $end_vector->isa('Math::Shape::Vector');

    # update position
    $self->position($end_vector);

    $end_vector;
}

1;

