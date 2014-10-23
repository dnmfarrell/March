use strict;
use warnings;
package March::Log;
use feature qw/signatures/;
no warnings 'experimental';
use March::ConfigManager;
use March::Game;

my $instance;

sub instance ($class)
{
    unless ($instance)
    {
        my $listener = March::ConfigManager->instance->create_listener;
        $listener->poll(sub { log_msg($_[0]) });
       
        $instance = bless {
            listener => $listener,
            output_fh  => March::ConfigManager->log_fh,
        }, $class;
    }
    $instance;
}

sub log_msg ($msg)
{
    if ($self->{output_fh})
    {
        my $FH = $self->{output_fh};
        print { $FH } sprintf("%-20s %-5d %-65s\n", $msg->type, $msg->content, $msg->actor_id, , $msg->action);
    }
    else
    {
        printf "%-20s %-5d %-65s\n",  $msg->type, $msg->content, $msg->actor_id, , $msg->action;
    }
}

1;
