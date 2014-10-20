package March::Actor::Humanoid;
use Role::Tiny;
use Role::Tiny::With;

with qw/March::Attribute::Id
        March::Actor
        March::Attribute::Name
        March::Attribute::Direction
        March::Attribute::Position
        March::Attribute::MoveAllowance
        March::Action::Spawn
        March::Action::Turn
        March::Action::Walk
      /;

1;
