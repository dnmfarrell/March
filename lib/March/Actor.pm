package March::Actor;
use Role::Tiny::With;
use Role::Tiny

# every actor must have an id
with 'March::Component::Id';

1;
