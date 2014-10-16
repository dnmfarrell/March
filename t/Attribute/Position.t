use strict;
use warnings;
no warnings 'once';
use Test::More;
use AnyMQ;
use Math::Shape::Vector;
use March::Log;

# initialize log with tmp filehandle
open my $TMP_FH, "+>", undef or die $!;
March::Game->instance->{config}{log}{filehandle} = $TMP_FH;
March::Log->instance; # start subscription

# create an object
my $self = bless { position => Math::Shape::Vector->new(54, 67) }, 'March::Attribute::Position';

# add required sub
*March::Attribute::Position::id = sub { 107 };

BEGIN { use_ok 'March::Attribute::Position' }

is $self->position->{x}, 54, 'Check position';
is $self->position->{y}, 67, 'Check position';
ok $self->position( Math::Shape::Vector->new(10, 90) ), 'Update position to new vector';
is $self->position->{x}, 10, 'Check position';
is $self->position->{y}, 90, 'Check position';

# slurp the tmp log
seek $TMP_FH, 0, 0;
my $tmp_log_content = join "", <$TMP_FH>;

like $tmp_log_content, qr/March::Attribute::Position\s+107\s+Vector x: 10, y: 90/, 'Check direction msg written to game log';

done_testing();

