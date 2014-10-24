package March::Manager;
use 5.020;
use AnyMQ;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';

my $instance;
my @msgs;

sub new ($class)
{
    my $listener = AnyMQ->new_listener(AnyMQ->topic('March::Message::Queue'));

    $instance = bless { listener => $listener,
                        continue => 1,
    }, $class;
}

sub instance ($class) { $instance }

sub start ($self)
{
    while ($self->continue)
    {
        say "polling for msgs";
        $self->{listener}->poll_once( sub { push @msgs, @_ }, 1);
        for (@msgs)
        {
            say $_->type;
        }
        sleep(1);
    }
}

sub continue ($self) { $self->{continue} }

sub process_msg ($msg)
{
    if ($msg->type eq 'March::Game::End')
    {
        March::Manager->instance->{continue} = 0;
    }
    else
    {
        say $msg->content;
    }
}

1;
