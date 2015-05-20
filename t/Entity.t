use warnings;
use strict;
use Test::More;

BEGIN { use_ok 'March::Entity' }

ok my $entity = March::Entity->new, 'constructor';
ok $entity->id, 'check entity has id';

done_testing;
