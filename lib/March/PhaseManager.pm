package March::PhaseManager;
use 5.020;
use Role::Tiny;
use feature qw/signatures postderef/;
no warnings 'experimental';
use March::ConfigManager;
use March::Msg;
use Carp;

my $instance;

sub new ($class)
{
    my $listener = March::ConfigManager->instance->create_listener;
    $listener->poll(sub { process_message($_[0]) });
    
    $instance = bless { 
        listener  => $listener,
        phases    => [],
    }, $class;
}

sub instance () { $instance }

sub process_messagel($message)
{
    if ($message->type eq 'March::Actor::Phase::Next')
    {
        March::PhaseManager->instance->next_phase;
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
    March::ConfigManager->instance->publish(March::Msg->new(
            __PACKAGE__, "The " . $self->current_phase->name . "is ending", 0)
    );
    
    $self->{current_phase} =
        $self->{current_phase} == $self->{phases}->$#*
        ? 0 : $self->{current_phase} + 1;

    # end turn
    unless ($self->{current_phase})
    {
        March::ConfigManager->instance->publish(March::Msg->new(
            'March::Actor::Turn::End', undef, 0)
        );
    }

    March::ConfigManager->instance->publish(March::Msg->new(
        __PACKAGE__, "The " . $self->current_phase->name . "is starting", 0)
    );
    
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
