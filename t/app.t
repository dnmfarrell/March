use warnings;
use strict;
use Test::More;
use AnyMQ;
use March::Msg;
use March::Game;

March::Game->instance;

BEGIN { use_ok 'March' }

my $pid = fork();

if ($pid)
{
    ok March::start;
    wait;
}
else
{
    AnyMQ->topic('March::Game::Orders')->publish(March::Msg->new('March::Game::End', 0, 'End Game'));
    exit;
}

done_testing();
