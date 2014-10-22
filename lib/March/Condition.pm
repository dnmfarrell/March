package March::Condition;
use 5.020;
use Role::Tiny;
use AnyMQ;
use feature 'signatures';
no warnings 'experimental';

requires qw/check_condition new/;

sub subscribe ($self)
{
    # subscribe to the game message queue
    my $mq = AnyMQ->topic('March::Game');
    my $sub = AnyMq->new_listener($mq);
    $sub->poll(sub { is_victory($_[0]) });

    bless { sub => $sub }, $class;
}

1;

