package March::Component::PollMsgQueue;
use 5.020;
use warnings;
use AnyMQ;
use Role::Tiny;
use Role::Tiny::With;
use Scalar::Util 'blessed';
use feature 'signatures';
no warnings 'experimental';

requires 'process_msg';
with 'March::Component::PostMsgQueue';

=head2 poll ()

=head2 poll ($queue)

Will poll the C<$queue> arg provided (just the queue name) for messages and call C<process_msg> for each message received. Must be called as an object method. If called without C<$queue>, will poll the queue of it's own class name.

=cut

sub poll ($self, $queue = undef)
{
  my $class = blessed $self;

  die 'poll must be called as an object method' unless $class;

  $queue = $class unless $queue;

  unless (exists $self->{msg_queues}{$queue})
  {
    $self->post('March::Logger', "$class subscribing to $queue");
    $self->{msg_queues}{$queue} = AnyMQ->new_listener(AnyMQ->topic($queue))
  }

  $self->{msg_queues}{$queue}->poll_once( sub { $self->process_msg($_) for(@_) }, 0);
}

1;
