package March::Component::Move::Turn;
use 5.020;
use Role::Tiny;
use March::Msg;
use March::Game;
use feature 'signatures';
no warnings 'experimental';
use Carp;

requires qw/id direction/;

=head2 turn

Turns the actor to the direction of the header_vector argument. Requires a L<Math::Shape::Vector> object as an argument. Returns the header_vector;

=cut

sub turn ($self, $header_vector)
{
    croak 'turn requires a Math::Shape::Vector object'
        unless $header_vector->isa('Math::Shape::Vector');

    # update direction and return it
    March::Game->instance->publish(
        March::Msg->new(__PACKAGE__, $self->id, $header_vector)
    );

    $self->direction($header_vector);
}

1;

