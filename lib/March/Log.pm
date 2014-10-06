use strict;
use warnings;
package March::Log;

use feature qw/signatures say/;
no warnings 'experimental';

my $instance = undef;

sub instance
{
    $instance = bless { fh => undef }, shift unless $instance;
    return $instance;
}

sub log_msg ($self, $msg)
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
