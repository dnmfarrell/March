use strict;
use warnings;
package March::Log;

use feature qw/signatures say/;
no warnings 'experimental';
use List::Util 'any';

my $instance = undef;
my @msg_queue = ();

sub instance
{
    $instance = bless { fh => undef }, shift unless $instance;
    return $instance;
}

sub msg_add ($self, $msg) { push @msg_queue, $msg }

sub msg_delete ($self, $msg)
{ 
	for (0..$#msg_queue)
    {
        if ($msg_queue[$_] eq $msg)
        {
            splice @msg_queue, $_, 1;
            last;
        }
    }
}


sub msg_exists ($self, $msg_string) { any { /^$msg_string$/ } @msg_queue }

sub msg_print ($self, $msg)
{
    my $FH = $self->{fh};

    if ($FH)
    {
        say $FH $msg;
    }
    else
    {
        say $msg;
    }
}

1;
