use strict;
use warnings;
use Test::More;
use March::Factory;

# setup test data
# on update() this entity will end the game loop :-)
no warnings 'once';
local *March::Entity::update = sub { $_[0]->end_game() };
my $entity = March::Factory->mint_object(qw/
  March::Component::PostMsg
  March::Component::Update
  March::Component::EndGame
  /);

BEGIN { use_ok 'March::Game' }

ok my $game = March::Game->new([$entity]), 'constructor';
ok $game->start, 'start the game, run one loop and exit';

done_testing;
