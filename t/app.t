use warnings;
use strict;
use Test::More;

BEGIN { use_ok 'March' }

ok March::start();

done_testing();
