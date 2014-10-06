use strict;
use warnings;
package March;
$March::VERSION = '0.01';
use 5.020;
use March::Log;

# ABSTRACT: A 2d web game engine, for turn based games written in Perl

sub start ()
{
    # configuration
    March::Log->instance()->log_msg('Starting up');

    # begin game loop
    while (1)
    {
        # Process input
        # Logical engine
        # Render, SFX
        last;
    }
    March::Log->instance()->log_msg('Shutting down');
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

March - A 2d web game engine, for turn based games written in Perl

=head1 VERSION

version 0.01

=head2 DESCRIPTION

This is an experiment - a 2d web game engine, for turn based games written in Perl

=head1 AUTHOR

David Farrell <sillymoos@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by David Farrell.

This is free software, licensed under:

  The (two-clause) FreeBSD License

=cut
