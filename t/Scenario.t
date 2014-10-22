use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'March::Scenario' }

ok my $scenario = March::Scenario->new('Last Gang Standing');
is $scenario->name, 'Last Gang Standing';

done_testing();
