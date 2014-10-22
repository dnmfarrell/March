package March::Condition;
use 5.020;
use Role::Tiny;
use AnyMQ;
use feature 'signatures';
no warnings 'experimental';

requires 'is_victory';

sub new ($class)
{
    # subscribe to the game message queue
    my $mq = AnyMQ->topic('March::Game');
    my $sub = AnyMq->new_listener($mq);
    $sub->poll(sub { is_victory($_[0]) });

    bless { sub => $sub }, $class;
}

1;

