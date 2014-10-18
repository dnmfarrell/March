use strict;
use warnings;
use feature 'postderef';
no warnings 'experimental';
use Test::More;
use March::Actor::Humanoid;

my $actor = bless { id => 1 }, 'March::Actor::Humanoid';

BEGIN { use_ok 'March::Game' }

ok my $game = March::Game->instance, 'Singleton Constructor';
is $game->actors->@*, 0, 'Actors list is empty';
ok $game->add_actor($actor), 'add_actor';
is $game->actors->@*, 1, 'Actors list has one actor';
ok $game->delete_actor($actor), 'delete_actor';
is $game->actors->@*, 0, 'Actors list is empty';

done_testing();
