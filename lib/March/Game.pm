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
    $instance = $instance ? $instance : bless { actors => [] }, shift;
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
    croak 'add_actor method requires a March::Game::Actor object' unless Role::Tiny::does_role($actor, 'March::Actor');
    push $self->{actors}->@*, $actor;
    $self;
}

=head2 delete_actor

Removes an actor from the game, returns the March::Game object.

=cut

sub delete_actor ($self, $actor)
{
    croak 'delete_actor method requires a March::Game::Actor object' unless Role::Tiny::does_role($actor, 'March::Actor');
    $self->{actors} = [ grep { $_->id != $actor->id } $self->{actors}->@* ];
    $self;
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

1;
