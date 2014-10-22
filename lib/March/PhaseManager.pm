package March::PhaseManager;
use 5.020;
use Role::Tiny;
use feature qw/signatures postderef/;
no warnings 'experimental';
use AnyMQ;
use March::Msg;
use Carp;

sub new ($class)
{
    bless {
        phases        => [],
        current_phase => 0,
    }, $class;
}


=head2 phases

Returns an arrayref of phases

=cut

sub phases ($self)
{
    $self->{phases};
}

=head2 add_phase

Adds a phase to the end of the phase array, returns an arrayref of phases.

=cut

sub add_phase ($self, $phase)
{
    croak 'add_phase method requires a March::Phase class' unless Role::Tiny::does_role($phase, 'March::Phase');
    push $self->{phases}->@*, $phase;
    $self->phases;
}

=head2 next_phase

Changes the current phase to the next phase in the phases arrayref. Returns the current L<March::Phase> object.

=cut

sub next_phase ($self)
{
    AnyMQ->topic('March::Game')->publish(March::Msg->new(
            __PACKAGE__, 0, "The " . $self->current_phase->name . "is ending"));

    $self->{current_phase} =
        $self->{current_phase} == $self->{phases}->$#*
        ? 0 : $self->{current_phase} + 1;

    # end turn 
    unless ($self->{current_phase})
    {
        AnyMQ->topic('March::Game')->publish(March::Msg->new(
            'March::Game::Turn::End', 0, "The turn is ending"));
    }


    AnyMQ->topic('March::Game')->publish(March::Msg->new(
            __PACKAGE__, 0, "The " . $self->current_phase->name . "is starting"));

    $self->current_phase;
}

=head2 current_phase

Returns the current phase object

=cut

sub current_phase ($self)
{
    $self->phases->[$self->{current_phase}];
}

1;
