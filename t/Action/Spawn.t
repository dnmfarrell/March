use strict;
use warnings;
use Test::More;
use March::Msg;
use Math::Shape::Vector;
use March::Log;
use March::Game;
use Test::Exception;

# initialize log with tmp filehandle
open my $TMP_FH, "+>", undef or die $!;
March::Game->instance->{config}{log}{filehandle} = $TMP_FH;
March::Log->instance; # start subscription

# create an object
my $self = bless {}, 'March::Action::Spawn';

# add required subs to symbol-table
sub March::Action::Spawn::id { 20 };

sub March::Action::Spawn::position
{
    $_[1] ? $_[0]->{direction} = $_[1]
          : $self->{direction};
}

BEGIN { use_ok 'March::Action::Spawn' }

ok $self->spawn( Math::Shape::Vector->new(74, 999) ), 'Spawn to location 74, 999';
is $self->position->{x}, 74,  'Has spawned to x 74';
is $self->position->{y}, 999, 'Has spawned to y 999';

# slurp the tmp log
seek $TMP_FH, 0, 0;
my $tmp_log_content = join "", <$TMP_FH>;

like $tmp_log_content, qr/March::Action::Spawn\s+20\s+Vector x: 74, y: 999/, 'Check spawn msg written to game log';

dies_ok { $self->spawn( Math::Shape::Vector->new(74, 999) ) } 'Spawning twice croaks';

done_testing();

