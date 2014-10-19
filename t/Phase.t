use strict;
use warnings;
use Test::More;
use Math::Shape::Vector;
use March::Log;
use March::Game;

# initialize log with tmp filehandle
open my $TMP_FH, "+>", undef or die $!;
March::Game->instance->{config}{log}{filehandle} = $TMP_FH;
March::Log->instance; # start subscription

# create an object
my $self = bless { }, 'March::Phase';

BEGIN { use_ok 'March::Phase' }

ok $self->end, 'end() Phase';

# slurp the tmp log
seek $TMP_FH, 0, 0;
my $tmp_log_content = join "", <$TMP_FH>;

like $tmp_log_content, qr/March::Phase\s+0\s+END/, 'Check end phase msg written to game log';

done_testing();


