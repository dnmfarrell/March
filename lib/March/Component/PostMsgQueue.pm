package March::Component::PostMsgQueue;
use 5.020;
use AnyMQ;
use Role::Tiny;
use Scalar::Util 'blessed';
use feature 'signatures';
no warnings 'experimental';

=head2 post ($queue, $msg)

Will post a message to the message queue (just the queue name as a string).

=cut

sub post ($self, $queue, $msg)
{
  die 'post must be called as an object method' unless blessed $self;
  AnyMQ->topic($queue)->publish($msg);
}

1;

