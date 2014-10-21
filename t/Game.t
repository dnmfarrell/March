use 5.020;
use warnings;
use feature 'postderef';
no warnings 'experimental';
use Test::More;
use Test::Exception;
use March::Actor::Humanoid;
use March::Phase::Deploy;
use March::Phase::Move;
use March::Map;
use Math::Trig ':pi';


BEGIN { use_ok 'March::Game' }

my $deploy_phase = March::Phase::Deploy->new;
my $move_phase = March::Phase::Move->new;
my $map = March::Map->new(1000, 1000);
my $actor = bless { id => 75, move_allowance => 20 }, 'March::Actor::Humanoid';
ok my $game = March::Game->instance([$deploy_phase, $move_phase], [$actor], $map);

# actors
ok $game->delete_actor($actor), 'delete_actor';
is $game->actors->@*, 0, 'Actors list is empty';
ok $game->add_actor($actor), 'add_actor';
is $game->actors->@*, 1, 'Actors list has one actor';
is_deeply $game->get_actor_by_id($actor->id), $actor;
ok $game->delete_actor($actor), 'delete_actor';
is $game->actors->@*, 0, 'Actors list is empty';

# ids
is $game->next_available_id, 1;
is $game->next_available_id, 2;
is $game->next_available_id, 3;
is $game->next_available_id, 4;
is $game->next_available_id, 5;

# phases
is_deeply $game->current_phase, $deploy_phase;
ok $game->next_phase;
is_deeply $game->current_phase, $move_phase;
ok $game->next_phase;
is_deeply $game->current_phase, $deploy_phase;
ok $game->next_phase;
is_deeply $game->current_phase, $move_phase;
ok $game->next_phase;
is_deeply $game->current_phase, $deploy_phase;

# spawn order
ok $game->add_actor($actor), 'add_actor';
my $spawn_order = March::Msg->new('spawn', $actor->id, Math::Shape::Vector->new(50, 50));
AnyMQ->topic('March::Game::Orders')->publish($spawn_order);
$game->instance->update;
is $actor->position->{x}, 50;

# walk order
my $walk_order = March::Msg->new('walk', $actor->id, Math::Shape::Vector->new(60, 50));
AnyMQ->topic('March::Game::Orders')->publish($walk_order);
$game->update;
is $actor->position->{x}, 50, 'Actor did not move because in Spawn phase';
ok $game->next_phase,'Change to move phase';
AnyMQ->topic('March::Game::Orders')->publish($walk_order);
$game->update;
is $actor->position->{x}, 60, 'Actor moved because in walk phase';
is $actor->direction->radians, pip2, 'Actor is facing "east"';
done_testing();
