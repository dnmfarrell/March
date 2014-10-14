use Test::More;
use warnings;
use strict;
use AnyMQ;
use Math::Shape::Circle;
use Math::Shape::Vector;

# for listening to actions
my $game_queue = AnyMQ->topic('March::Game');
my $game_listener = AnyMQ->new_listener($game_queue);
my $action_msg;

$game_listener->poll(sub { $action_msg = $_[0] } );

BEGIN { use_ok 'March::Unit' }

# constructor, attributes
my $position = Math::Shape::Vector->new(10, 10);
ok my $unit = March::Unit->new(1, 25, $position), 'constructor';
is $unit->id, 1;
is_deeply $unit->position, $position;
is $unit->move_allowance, 25;

# moving
my $target_vector = Math::Shape::Vector->new(10, 20); # 10 north of $unit current position
ok $unit->move($target_vector);
is $action_msg->{actor_id}, 1;
is $action_msg->{type}, 'March::Action::Move';
is $unit->position->{x}, 10;
is $unit->position->{y}, 20;

done_testing();
