use strict;
use warnings;
use Test::More;
use AnyMQ;
use March::Msg;
use March::Game;
use March::Phase::Deploy;
use March::Map;
use March::Actor::Humanoid;

my $deploy_phase = March::Phase::Deploy->new;
my $human = bless {}, 'March::Actor::Humanoid';
my $map = March::Map->new(1000, 1000);
ok my $game = March::Game->instance([$deploy_phase], [$human], $map);

# create a temporary log file
open my $FH, "+>", undef or die $!;

# set the game log file to the temp FH
March::Game->instance->{config}{log}{filehandle} = $FH;

BEGIN { use_ok 'March::Log' }

ok my $log = March::Log->instance, 'Singleton constructor';
ok (AnyMQ->topic('March::Game')->publish(March::Msg->new('Test', 999, 'Test Msg')), 'Publish msg');

# rewind the temp FH
seek($FH, 0, 0);

# slurp and test
my $log_content = join "", <$FH>;
like $log_content, qr/Test\s+999\s+Test Msg/, 'Check log file written';

done_testing();
