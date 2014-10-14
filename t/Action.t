use strict;
use warnings;
use Test::More;
use AnyMQ;
use March::Msg;

# setup action queue
my $mq = AnyMQ->topic('March::Game');
my $listener = AnyMQ->new_listener($mq);
my $msg_sent = March::Msg->new(__PACKAGE__, 32, 'Test message');
my $msg_received;
$listener->poll(sub { $msg_received = $_[0] } );

# create an object
my $self = bless {}, 'March::Action';

BEGIN { use_ok 'March::Action' }

ok $self->publish_action($msg_sent), 'Publish() msg';
is_deeply $msg_received, $msg_sent;

done_testing();

