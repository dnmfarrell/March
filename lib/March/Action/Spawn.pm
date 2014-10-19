package March::Action::Spawn;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';
use Carp;
use March::Game;
use March::Msg;

requires qw/id position/;

=head2 spawn

Sets the actors position for the first time to deploy them into the game.

=cut

sub spawn ($self, $position)
{
    croak 'spawn requires a Math::Shape::Vector object'
        unless $position->isa('Math::Shape::Vector');

    croak 'object id ' . $self->id . ' already has a position!'
        if $self->position;

    croak 'cannot spawn there' if March::Game->collision_check($position);

    # emit msg and set position and return position
    March::Game->instance->publish(
        March::Msg->new(__PACKAGE__, $self->id, $position)
    );
    $self->position($position);
}

1;
