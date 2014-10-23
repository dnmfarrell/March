package March::Component::Spawn;
use Role::Tiny;
use Role::Tiny::With;
use feature 'signatures';
no warnings 'experimental';
use Carp;
use March::ConfigManager;
use March::Msg;

with qw/March::Component::Id
        March::Component::Position/;

=head2 can_spawn

Boolean method that returns 1 if the actor can spawn (it has not yet spawned) or 0 if it cannot (it has already spawned).

=cut

sub can_spawn ($self)
{
    $self->position ? 0 : 1;
}

=head2 spawn

Sets the actors position for the first time to deploy them into the game.

=cut

sub spawn ($self, $position)
{
    croak 'spawn requires a Math::Shape::Vector object'
        unless $position->isa('Math::Shape::Vector');

    croak 'object id ' . $self->id . ' already has a position!'
        unless $self->can_spawn;

    croak 'cannot spawn there' if March::Game->instance->collision_check($self, $position);

    # emit msg and set position and return position
    March::ConfigManager->instance->publish(
        March::Msg->new(__PACKAGE__, $position, $self->id)
    );
    $self->position($position);
}

1;
