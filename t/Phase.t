use strict;
use warnings;
use Test::More;
use Math::Shape::Vector;
use March::Log;
use March::Game;
use March::Phase::Deploy;
use March::Actor::Humanoid;
use March::Map;

my $deploy_phase = March::Phase::Deploy->new;
my $human = bless {}, 'March::Actor::Humanoid';
my $map = March::Map->new(1000, 1000);
ok my $game = March::Game->instance([$deploy_phase], [$human], $map);

BEGIN { use_ok 'March::Phase' }
ok my $phase = March::Phase->new;
is $deploy_phase->name, 'Deploy';

done_testing();


