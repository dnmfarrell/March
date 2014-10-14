use strict;
use warnings;
use Test::More;
use AnyMQ;
use March::Msg;

BEGIN { use_ok 'March::Log' }

ok my $log = March::Log->instance, 'Singleton constructor';
ok (AnyMQ->topic('March::Game')->publish(March::Msg->new('Test', 999, 'Test Msg')));


done_testing();
