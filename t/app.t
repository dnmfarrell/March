use 5.020;
use Test::More;
use March::Msg;
use March::Game;
use March::Phase::Deploy;
use March::Actor::Humanoid;
use March::Map;
use AnyMQ;
use feature 'postderef';
no warnings 'experimental';

my $deploy_phase = March::Phase::Deploy->new;
my $human = bless {}, 'March::Actor::Humanoid';
my $map = March::Map->new(1000, 1000);
my $game = March::Game->instance([$deploy_phase], [$human], $map);

AnyMQ->topic('March::Game::Orders')->publish(March::Msg->new('March::Game::End', 0, 'End the game'));

BEGIN { use_ok 'March' }

ok March::start;

done_testing();
