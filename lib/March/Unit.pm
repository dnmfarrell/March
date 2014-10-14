package March::Unit;
use Role::Tiny::With;
use feature 'signatures';
no warnings 'experimental';

with 'March::Attribute::Id';
with 'March::Attribute::MoveAllowance';
with 'March::Attribute::Position';
with 'March::Action::Move';

1;
