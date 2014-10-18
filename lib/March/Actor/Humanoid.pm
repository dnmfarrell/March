package March::Actor::Humanoid;
use Role::Tiny;
use Role::Tiny::With;

with qw/March::Attribute::Id
        March::Actor
        March::Attribute::Direction
        March::Attribute::Position
        March::Attribute::MoveAllowance
        March::Action::Turn
        March::Action::Move
      /;

1;
