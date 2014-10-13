package March::Action::Move;
use 5.020;
use Role::Tiny;
use Role::Tiny::With;
use Math::Shape::Vector;
use Math::Shape::Circle;
use feature 'signatures';
no warnings 'experimental';
use Carp;

with 'March::Action';

requires qw/id move_allowance shape/;

sub move ($self, $end_vector)
{
    croak 'perform requires a Math::Shape::Vector object'
        unless $end_vector->isa('Math::Shape::Vector');

    croak 'unable to move' unless $self->can_move($end_vector);

    croak 'move can only be called on circle shapes'
        unless $self->shape->isa('Math::Shape::Circle');

    $self->shape(Math::Shape::Circle->new(
                    $end_vector->{x},
                    $end_vector->{y},
                    $self->shape->{radius},
    ));
    # publish move
    $self->publish_action({ id => $self->id, action => __PACKAGE__ });
    $self;
}

sub can_move ($self, $end_vector)
{
    croak 'perform requires a Math::Shape::Vector object'
        unless $end_vector->isa('Math::Shape::Vector');

    my $shape = $self->shape;
    croak 'move can only be called on circle shapes'
        unless $shape->isa('Math::Shape::Circle');

    my $distance = $shape->{center}->distance($end_vector);

    # if distance > move allowance, deny
    return 0 unless $distance <= $self->move_allowance;

    # TODO collision check

    # return the distance to move
    $distance;
}

1;
