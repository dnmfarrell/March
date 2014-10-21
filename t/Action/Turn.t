use strict;
use warnings;
use Test::More;
use AnyMQ;
use March::Msg;
use March::Game;
use Math::Shape::Vector;
use March::Log;
use March::Actor::Humanoid;
use March::Map;
use March::Phase::Deploy;

my $deploy_phase = March::Phase::Deploy->new;
my $human = bless {}, 'March::Actor::Humanoid';
my $map = March::Map->new(1000, 1000);
my $game = March::Game->instance([$deploy_phase], [$human], $map);

# initialize log with tmp filehandle
open my $TMP_FH, "+>", undef or die $!;
March::Game->instance->{config}{log}{filehandle} = $TMP_FH;
March::Log->instance; # start subscription

# create an object
my $self = bless { direction => Math::Shape::Vector->new(1, 0) }, 'March::Action::Turn';

# add required subs to symbol-table
sub March::Action::Turn::id { 20 };
sub March::Action::Turn::direction
{
    $_[1] ? $_[0]->{direction} = $_[1]
          : $self->{direction};
}

BEGIN { use_ok 'March::Action::Turn' }

ok $self->turn( Math::Shape::Vector->new(0, 1) ), 'Turn to new vector';
is $self->direction->{x}, 0, 'Has turned to x 0';
is $self->direction->{y}, 1, 'Has turned to y 1';

# slurp the tmp log
seek $TMP_FH, 0, 0;
my $tmp_log_content = join "", <$TMP_FH>;

like $tmp_log_content, qr/March::Action::Turn\s+20\s+Vector x: 0, y: 1/, 'Check direction msg written to game log';
done_testing();

