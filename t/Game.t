use 5.020;
use warnings;
use feature 'postderef';
no warnings 'experimental';
use Test::More;
use March::Actor::Humanoid;
use March::Phase::Deploy;
use March::Phase::Move;

my $actor = bless { id => 75 }, 'March::Actor::Humanoid';

BEGIN { use_ok 'March::Game' }

ok my $game = March::Game->instance, 'Singleton Constructor';

# actors
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
my $deploy_phase = March::Phase::Deploy->new;
my $move_phase   = March::Phase::Move->new;
ok $game->add_phase($deploy_phase), 'Add deployment phase';
ok $game->add_phase($move_phase), 'Add move phase';
is_deeply $game->current_phase, $deploy_phase;
ok $game->next_phase;
is_deeply $game->current_phase, $move_phase;
ok $game->next_phase;
is_deeply $game->current_phase, $deploy_phase;
ok $game->next_phase;
is_deeply $game->current_phase, $move_phase;
ok $game->next_phase;
is_deeply $game->current_phase, $deploy_phase;

# orders
ok $game->add_actor($actor), 'add_actor';
my $order = March::Msg->new('spawn', $actor->id, Math::Shape::Vector->new(50, 50));
AnyMQ->topic('March::Game::Orders')->publish($order);
$game->instance->update;
is $actor->position->{x}, 50;

done_testing();
