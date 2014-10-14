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
my $self = bless { position => Math::Shape::Vector->new(54, 67) }, 'March::Attribute::Position';

# add required sub
*March::Attribute::Position::id = sub { 107 };

BEGIN { use_ok 'March::Attribute::Position' }

is $self->position->{x}, 54, 'Check position';
ok $self->position( Math::Shape::Vector->new(10, 10) ), 'Update position to new vector';
is $msg_received->isa('March::Msg'), 1, 'Received msg is type March::Msg';
is $msg_received->{actor_id}, 107, 'March::Msg object has actor_id of moving object';
is $msg_received->{type}, 'March::Attribute::Position', 'type equals March::Action::Move';

done_testing();

