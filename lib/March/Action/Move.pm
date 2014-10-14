package March::Action::Move;
use 5.020;
use Role::Tiny;
use Math::Shape::Vector;
use March::Msg;
use March::Game;
use feature 'signatures';
no warnings 'experimental';
use Carp;

requires qw/id move_allowance position/;

sub move ($self, $end_vector)
{
    croak 'perform requires a Math::Shape::Vector object'
        unless $end_vector->isa('Math::Shape::Vector');

    my $start_position = $self->position;
    my $distance = $start_position->distance($end_vector);

    # move allowance
    return 0 if $distance > $self->move_allowance;

    # collision check
    return 0 if March::Game->instance->collision_check($start_position, $end_vector);

    # update position
    $self->position($end_vector);

    # publish move
    March::Game->publish(March::Msg->new(__PACKAGE__, $self->id, $end_vector));

    # return the distance moved
    $distance;
}

1;

