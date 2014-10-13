use strict;
use warnings;
use Test::More;
use AnyMQ;
no warnings 'once';

# setup action queue
my $mq = AnyMQ->topic('March::Action');
my $listener = AnyMQ->new_listener($mq);
my $msg;
$listener->poll(sub { $msg = $_[0] } );

# create an object
my $self = bless {}, 'March::Action::Move';

# add required subs to symbol-table
*March::Action::Move::id = sub { 20 };
*March::Action::Move::move_allowance = sub { 100 };
*March::Action::Move::shape = sub { Math::Shape::Circle->new(5, 10, 3) };

BEGIN { use_ok 'March::Action::Move' }

ok $self->move( Math::Shape::Vector->new(10, 10) ), 'Move to new vector';
is $self->can_move( Math::Shape::Vector->new(10, 10) ),   5, 'Object can move to new vector, distance 5';
is $self->can_move( Math::Shape::Vector->new(150, 200) ), 0, 'Object cant move to new vector distance too great';

is $msg->{id}, 20, 'msg id equals 20';
is $msg->{action}, 'March::Action::Move', 'action equals March::Action::Move';

done_testing();

