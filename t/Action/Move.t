use strict;
use warnings;
use Test::More;
use AnyMQ;
use March::Msg;
use Math::Shape::Vector;
use March::Log;

# create an object
my $self = bless { position => Math::Shape::Vector->new(54, 67) }, 'March::Action::Move';

# add required subs to symbol-table
sub March::Action::Move::id { 20 };
sub March::Action::Move::position
{
    $_[1] ? $_[0]->{position} = $_[1]
          : $_[0]->{position}
};

BEGIN { use_ok 'March::Action::Move' }

ok $self->move( Math::Shape::Vector->new(10, 10) ), 'Move to new vector';
is $self->position->{x}, 10, 'Has moved to x 10';
is $self->position->{y}, 10,'Has moved to y 10';

done_testing();

