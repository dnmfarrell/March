package March::PhaseManager;
use 5.020;
use Role::Tiny;
use feature qw/signatures postderef/;
no warnings 'experimental';
use AnyMQ;
use March::Msg;
use Carp;

my $instance;

sub new ($class)
{
    my $listener = AnyMQ->new_listener(AnyMQ->topic('March::Signal::Game'));
    $listener->poll( sub { March::PhaseManager->instance->process_signal($_[0]) } );

    $instance = bless
    {
        phases        => [],
        current_phase => 0,
        listener      => $listener,
    }, $class;
}

sub instance () { $instance }

sub process_signal($self, $signal)
{
    if ($signal->{type} eq 'March::Signal::Game::Phase::Next')
    {
        $self->next_phase;
    }
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
    croak 'add_phase method requires a March::Actor::Phase object' unless $phase->DOES('March::Actor::Phase');
    push $self->{phases}->@*, $phase;
    $self->phases;
}

=head2 next_phase

Changes the current phase to the next phase in the phases arrayref. Returns the current L<March::Phase> object.

=cut

sub next_phase ($self)
{
    AnyMQ->topic('March::Signal::Game')->publish(March::Msg->new(
            __PACKAGE__, 0, "The " . $self->current_phase->name . "is ending"));

    $self->{current_phase} =
        $self->{current_phase} == $self->{phases}->$#*
        ? 0 : $self->{current_phase} + 1;

    # end turn
    unless ($self->{current_phase})
    {
        AnyMQ->topic('March::Signal::Game')->publish(March::Msg->new(
            'March::Signal::Game::Turn::End', 0, "The turn is ending"));
    }

    AnyMQ->topic('March::Signal::Game')->publish(March::Msg->new(
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
