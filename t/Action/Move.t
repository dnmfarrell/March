use strict;
use warnings;
use Test::More;
use AnyMQ;
no warnings 'once';
use March::Msg;
use Math::Shape::Vector;

# setup action queue
my $mq = AnyMQ->topic('March::Game');
my $listener = AnyMQ->new_listener($mq);
my $msg_received;
$listener->poll(sub { $msg_received = $_[0] } );

# create an object
my $self = bless { position => Math::Shape::Vector->new(54, 67) }, 'March::Action::Move';

# add required subs to symbol-table
*March::Action::Move::id = sub { 20 };
*March::Action::Move::move_allowance = sub { 100 };
*March::Action::Move::position
    = sub { $_[1] ? $_[0]->{position} = $_[1]
                  : $self->{position} };

BEGIN { use_ok 'March::Action::Move' }

ok $self->move( Math::Shape::Vector->new(10, 10) ), 'Move to new vector';
is $msg_received->isa('March::Msg'), 1, 'Received msg is type March::Msg';
is $msg_received->{actor_id}, 20, 'March::Msg object has actor_id of moving object';
is $msg_received->{type}, 'March::Action::Move', 'type equals March::Action::Move';

done_testing();

