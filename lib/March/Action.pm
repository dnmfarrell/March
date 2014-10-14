package March::Action;
use AnyMQ;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';

sub publish_action ($self, $msg)
{
    AnyMQ->topic('March::Game')->publish($msg);
}

1;
