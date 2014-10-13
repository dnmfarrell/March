use Test::More;
use warnings;
use strict;
use AnyMQ;
use Math::Shape::Circle;
use Math::Shape::Vector;

# for listening to actions
my $action_queue = AnyMQ->topic('March::Action');
my $action_listener = AnyMQ->new_listener($action_queue);
my $action_msg;

$action_listener->poll(sub { $action_msg = $_[0] } );

BEGIN { use_ok 'March::Unit' }

# constructor, attributes
my $circle = Math::Shape::Circle->new(10, 10, 2);
ok my $unit = March::Unit->new(1, 25, $circle), 'constructor';
is $unit->id, 1;
is_deeply $unit->shape, $circle;
is $unit->move_allowance, 25;

# moving
my $target_vector = Math::Shape::Vector->new(10, 20); # 10 north of $unit current position
ok $unit->move($target_vector);
is $action_msg->{id}, 1;
is $action_msg->{action}, 'March::Action::Move';
is $unit->shape->{center}{x}, 10;
is $unit->shape->{center}{y}, 20;

done_testing();
