use strict;
use warnings;
package March::Log;
use feature qw/signatures say/;
no warnings 'experimental';
use AnyMQ;
use March::Game;

my $instance = undef;

sub instance ($class)
{
    unless ($instance)
    {
        my $game_queue = AnyMQ->topic('March::Game');
        my $subscriber = AnyMQ->new_listener($game_queue);
        $instance = bless { subscriber => $subscriber }, $class;

        # poll for msgs
        $subscriber->poll(sub { log_msg($_[0]) });
    }
    $instance;
}

sub log_msg
{
    my $msg = shift;
    my $config = March::Game->instance->config;

    if (exists $config->{game_filehandle})
    {
        my $FH = $config->{game_filehandle};
        printf $FH "%-20s %-5d %-65s\n", $msg->{type}, $msg->{actor_id}, $msg->{content};
    }
    else
    {
        printf "%-20s %-5d %-65s\n", $msg->{type}, $msg->{actor_id}, $msg->{content};
    }
}

1;
