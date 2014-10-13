package March::Phase;
use Role::Tiny;
use AnyMQ;
use feature qw/signatures postderef/;
no warnings 'experimental';

requires qw/permitted_actions/;

sub new ($class)
{
    my $action_queue = AnyMQ->topic('March::Action');

    my $self = bless {
        action_list => {},
        listener    => AnyMQ->new_listener($action_queue),
    }, $class;

    $self->{listener}->poll(sub { print "receiving msg\n"; $self->record_action($_) });
    $self;
}


=head2 record_action

Called whenever an action is performed that is permitted in the phase. The action type and id of the performing object is saved.

=cut

sub record_action ($self, $msg)
{
    print "Recording action!\n";
    my $msg_action = $msg->{action};
    if (grep { /$msg_action/ } $self->permitted_actions->@*)
    {
        push $self->{action_list}{ $msg->{action} }->@*, $msg->{actor_id};
    }
}


sub clear_action_list ($self)
{
    $self->{action_list} = {};
    $self;
}

1;
