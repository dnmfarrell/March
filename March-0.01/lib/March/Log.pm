use strict;
use warnings;
package March::Log;
$March::Log::VERSION = '0.01';
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

__END__

=pod

=encoding UTF-8

=head1 NAME

March::Log

=head1 VERSION

version 0.01

=head1 AUTHOR

David Farrell <sillymoos@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by David Farrell.

This is free software, licensed under:

  The (two-clause) FreeBSD License

=cut
