package March::Game;
use Role::Tiny;
use AnyMQ;
use 5.020;
use Carp;
use feature qw/signatures postderef/;
no warnings 'experimental';

1;

__END__
=head2 instance

Returns the singleton March::Game object.

=cut

my $instance;

sub instance ($class, $phase_mgr = 0, $actors = [], $map = 0)
{
    unless($instance)
    {
        $instance = bless {
            actors        => [],
            phases        => $phase_mgr,
            turn          => 0,
            ids           => 0,
            orders        => [],
            continue      => 1,
            map           => $map,
        }, $class;

        # process actor list
        foreach my $actor ($actors->@*)
        {
            croak "$actor is not a March::Actor" unless Role::Tiny::does_role($actor, 'March::Actor');
            $instance->add_actor($actor);
        }

        # phases
        croak "$phase_mgr is not a March::PhaseManager object" unless $phase_mgr->isa('March::PhaseManager');

        # subscribe to the orders queue
        my $listener = AnyMQ->new_listener(AnyMQ->topic('March::Game::Orders'));
        $instance->{listener} = $listener;
        $listener->poll(sub { March::Game->instance->add_order($_[0]) });

        # check min requirements met
        croak 'March::Game requires at least one actor argument'
            unless scalar $instance->actors->@*;

        croak 'March::Game requires a map argument'
            unless $instance->{map} && $instance->{map}->isa('March::Map');
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
    no strict 'refs';

    # execute orders
    for my $order ($self->orders->@*)
    {
        if ($self->current_phase->action_is_allowed($order->{type}))
        {
            my $actor = $self->get_actor_by_id($order->{actor_id});
            my $action = $order->{type};

            if ($actor->can($action))
            {
                $actor->$action($order->{content});
            }
        }
        elsif ($order->{type} eq 'March::Phase::Next')
        {
            $self->next_phase;
        }
        elsif ($order->{type} eq 'March::Game::End')
        {
            $self->end;
        }
    }
    $self->clear_orders;
}

=head2 get_actor_by_id

Returns an actor with the matching id or croaks.

=cut

sub get_actor_by_id ($self, $id)
{
    for ($self->{actors}->@*)
    {
        return $_ if $_->id == $id;
    }
    croak 'No actor with matching id found';
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
=head2 next_available_id

Increments and returns the value of the internal id counter - ids are used to uniquely identify actors.

=cut

sub next_available_id ($self)
{
    ++$self->{ids};
}

=head2 collision_check

Checks an object for collisions.

=cut

sub collision_check ($self, $actor, $shape)
{
    for ($self->actors->@*)
    {
        next unless $_->id != $actor->id && $_->can('position') && $_->position;
        return 1 if $shape->collides($_->position);
    }
    0;
}

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

sub map ($self)
{
    $self->{map};
}

1;
