package March::Component::EndGame;
use 5.020;
use Role::Tiny;
use warnings;
use strict;
use feature 'signatures';
no warnings 'experimental';

with 'March::Component::PostMsg';

sub end_game ($self)
{
  $self->post('March::Game', 'END');
}


1;
