package March::ConfigManager;
use 5.020;
use warnings;
use feature 'signatures';
no warnings 'experimental';
use AnyMQ;

my $instance;

sub new ($class)
{
    my $mq = AnyMQ->topic('March::Message::Queue');
    $instance = {
        mq  => $mq,
    }, bless $class;
}

sub instance () { $instance }

sub mq ($self)
{
    $self->{mq};
}

sub publish($self, $msg)
{
    $self->mq->publish($msg);
}

sub create_listener ($self)
{
    AnyMQ->new_listener($self->mq);
}

=head2 log_fh

Returns the filehandle for the logger to use.

=cut

sub log_fh ($self)
{
    undef;
}

1;