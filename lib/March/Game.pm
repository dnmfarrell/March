package March::Game;
use Role::Tiny;
use AnyMQ;
use feature qw/signatures postderef/;
no warnings 'experimental';
use Carp;

=head2 instance

Returns the singleton March::Game object.

=cut

my $instance;

sub instance
{
    unless($instance)
    {
        $instance = bless {
            actors        => [],
            phases        => [],
            current_phase => 0,
            ids           => 0,
            orders        => [],
            continue      => 1,
        }, shift;

        # subscribe to the orders queue
        my $listener = AnyMQ->new_listener(AnyMQ->topic('March::Game::Orders'));
        $instance->{listener} = $listener;
        $listener->poll(sub { March::Game->instance->add_order($_[0]) });
    }
    $instance;
}

=head2 orders

Returns the current list of actor orders received.

=cut

sub orders ($self)
{
    $self->{orders};
}

sub add_order ($self, $order)
{
    push $self->{orders}->@*, $order;
}

sub clear_orders ($self)
{
    $self->{orders} = [];
}

sub update ($self)
{
    for ($self->orders->@*)
    {
        # execute orders
        $self->end if $_->{type} eq 'March::Game::End';
    }
    $self->clear_orders;
}

=head2 actors

Returns an arrayref of actors.

=cut

sub actors ($self)
{
    $self->{actors};
}

=head2 add_actor

Adds an actor to the game, returns the March::Game object.

=cut

sub add_actor ($self, $actor)
{
    croak 'add_actor method requires a March::Actor object' unless Role::Tiny::does_role($actor, 'March::Actor');
    push $self->{actors}->@*, $actor;
    $self;
}

=head2 delete_actor

Removes an actor from the game, returns the March::Game object.

=cut

sub delete_actor ($self, $actor)
{
    croak 'delete_actor method requires a March::Actor object' unless Role::Tiny::does_role($actor, 'March::Actor');
    $self->{actors} = [ grep { $_->id != $actor->id } $self->{actors}->@* ];
    $self;
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
    $self->{current_phase} =
        $self->{current_phase} == $self->{phases}->$#*
        ? 0 : $self->{current_phase} + 1;
    $self->current_phase;
}

=head2 current_phase

Returns the current phase object

=cut

sub current_phase ($self)
{
    $self->phases->[$self->{current_phase}];
}

=head2 next_available_id

Increments and returns the value of theinternal id counter - ids are used to uniquely identify actors.

=cut

sub next_available_id ($self)
{
    ++$self->{ids};
}

=head2 collision_check

Checks an object for collisions - TODO implement ;)

=cut

sub collision_check { 0 }

=head2 config

Returns a hashref of config options.

=cut

sub config { $_[0]->{config} }


=head2 publish

Publishes a L<March::Msg> object to the C<March::Game> queue.

=cut

sub publish ($self, $msg)
{
    AnyMQ->topic(__PACKAGE__)->publish($msg);
}

sub continue ($self)
{
    $self->{continue};
}

sub end ($self)
{
    $self->{continue} = 0;
}

1;
