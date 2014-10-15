use strict;
use warnings;
use Test::More;
use AnyMQ;
use Math::Shape::Vector;
use March::Log;
no warnings 'once';

# create an object
my $self = bless { direction => Math::Shape::Vector->new(1, 2) }, 'March::Attribute::Direction';

# add required sub
*March::Attribute::Direction::id = sub { 107 };

BEGIN { use_ok 'March::Attribute::Direction' }

is $self->direction->{x}, 1, 'Check direction';
is $self->direction->{y}, 2, 'Check direction';
ok $self->direction( Math::Shape::Vector->new(1, 0) ), 'Update direction to new vector';
is $self->direction->{x}, 1, 'Check direction';
is $self->direction->{y}, 0, 'Check direction';

done_testing();

