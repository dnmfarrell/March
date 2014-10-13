package March::Action;
use AnyMQ;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';

sub publish_action ($self, $msg)
{
    AnyMQ->topic(__PACKAGE__)->publish($msg);
}

1;
