package March::Logger;
use warnings;
use Role::Tiny::With;
use 5.020;
use feature 'signatures';
no warnings 'experimental';
use Time::Piece;

with 'March::Component::PollMsgQueue';

=head2 new()

=head2 new($log_fh)

Constructor - optionally takes a filehandle, else March::Logger will log all messages to STDOUT.

=cut

sub new ($class, $fh_log = *main::STDOUT)
{
  bless {
    log_filehandle => $fh_log,
  }, $class;
}


=head2 process_msg ($msg)

This will print the message to the log.

=cut

sub process_msg ($self, $msg)
{
  my $timestamp = gmtime->datetime;
  say { $self->{log_filehandle} } "$timestamp,$msg";
}

1;
