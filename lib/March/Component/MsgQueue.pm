package March::Component::MsgQueue;
use 5.020;
use warnings;
use AnyMQ;
use Role::Tiny;
use Scalar::Util 'blessed';
use feature 'signatures';
no warnings 'experimental';

requires 'process_msg';

=head2 poll ($queue)

Will poll the C<$queue> arg provided (just the queue name) for messages and call C<process_msg> for each message received. Must be called as an object method.

=cut

sub poll ($self, $queue)
{
  my $class = blessed $self;
  die 'poll must be called as an object method' unless $class;

  unless (exists $self->{msg_queues}{$queue})
  {
    $self->{msg_queues}{$queue} = AnyMQ->new_listener(AnyMQ->topic($queue))
  }

  $self->{msg_queues}{$queue}->poll_once( sub { $self->process_msg($_) for(@_) }, 0);
}

1;

