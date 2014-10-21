use 5.020;
use warnings;
use Test::More;
use Math::Shape::Vector;

BEGIN { use_ok 'March::Map' }

ok my $tabletop = March::Map->new(500, 500);

is $tabletop->within_bounds(Math::Shape::Vector->new( 100,  100)), 1;
is $tabletop->within_bounds(Math::Shape::Vector->new(   0,    0)), 1;
is $tabletop->within_bounds(Math::Shape::Vector->new( 500,  500)), 1;
is $tabletop->within_bounds(Math::Shape::Vector->new(-  1,    0)), 0;
is $tabletop->within_bounds(Math::Shape::Vector->new(-500, -500)), 0;

done_testing();
