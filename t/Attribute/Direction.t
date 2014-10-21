use strict;
use warnings;
use Test::More;
use Math::Shape::Vector;
use March::Log;
use March::Game;
use March::Phase::Deploy;
use March::Map;
use March::Actor::Humanoid;

my $deploy_phase = March::Phase::Deploy->new;
my $human = bless {}, 'March::Actor::Humanoid';
my $map = March::Map->new(1000, 1000);
ok my $game = March::Game->instance([$deploy_phase], [$human], $map);

# initialize log with tmp filehandle
open my $TMP_FH, "+>", undef or die $!;
March::Game->instance->{config}{log}{filehandle} = $TMP_FH;
March::Log->instance; # start subscription

# create an object
my $self = bless { direction => Math::Shape::Vector->new(1, 2) }, 'March::Attribute::Direction';

# add required sub
sub March::Attribute::Direction::id { 107 }

BEGIN { use_ok 'March::Attribute::Direction' }

is $self->direction->{x}, 1, 'Check direction';
is $self->direction->{y}, 2, 'Check direction';
ok $self->direction( Math::Shape::Vector->new(1, 0) ), 'Update direction to new vector';
is $self->direction->{x}, 1, 'Check direction';
is $self->direction->{y}, 0, 'Check direction';

# slurp the tmp log
seek $TMP_FH, 0, 0;
my $tmp_log_content = join "", <$TMP_FH>;

like $tmp_log_content, qr/March::Attribute::Direction\s+107\s+Vector x: 1, y: 0/, 'Check direction msg written to game log';

done_testing();

