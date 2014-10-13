use strict;
use warnings;
use Test::More;
use AnyMQ;

# setup action queue
my $mq = AnyMQ->topic('March::Action');
my $listener = AnyMQ->new_listener($mq);
my $msg;
$listener->poll(sub { $msg = $_[0] } );

# create an object
my $self = bless {}, 'March::Action';

BEGIN { use_ok 'March::Action' }

ok $self->publish_action({ id => 1, action => 'March::Action'}), 'Publish() msg';
is $msg->{id}, 1, 'msg id equals 1';
is $msg->{action}, 'March::Action', 'action equals March::Action';

done_testing();



