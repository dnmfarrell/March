package March::Action::Walk;
use 5.020;
use Role::Tiny;
use Math::Shape::LineSegment;
use March::Msg;
use March::Game;
use feature 'signatures';
no warnings 'experimental';
use Carp;

requires qw/move move_allowance turn/;

=head2 walk

Walking is where the character turns in the direction they wish to walk, and then (move_allowance permitting) walk there in a straight line. Walk includes collision checks. This method will return 0 if there is a collision along the walk path, or the target distance is beyond the actor's move_allowance. Requires a L<Math::Shape::Vector> object as an argument.

=cut

sub walk ($self, $end_vector)
{
    croak 'perform requires a Math::Shape::Vector object'
        unless $end_vector->isa('Math::Shape::Vector');

    # get the distance
    my $start_position = $self->position;
    my $distance = $start_position->distance($end_vector);

    # move allowance
    return 0 if $distance > $self->move_allowance;

    # collision check
    my $walking_line = Math::Shape::LineSegment->new(
        $start_position->{x},
        $start_position->{y},
        $end_vector->{x},
        $end_vector->{y},
    );
    return 0 if March::Game->instance->collision_check($walking_line);

    # turn to face the direction of the walk
    my $new_direction = $end_vector->subtract_vector($start_position)->convert_to_unit_vector;
    $self->turn($new_direction);

    # update position
    $self->move($end_vector);

    # return the distance moved
    $distance;
}

1;

