use warnings;
use strict;
use Test::More;
use AnyMQ;
use March::Msg;
use March::Game;

March::Game->instance;

BEGIN { use_ok 'March' }

ok March::start;

done_testing();
