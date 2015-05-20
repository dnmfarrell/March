use strict;
use warnings;
use Test::More;
use Role::Tiny::With;
with 'March::Component::PostMsg';

BEGIN { use_ok 'March::Logger' }

ok my $logger = March::Logger->new,  'Constructor';

# Poll once to subscribe to msg queue
$logger->poll('March::Logger');

# post test msg to logger queue
post(bless({}, 'A::Class'), 'March::Logger', 'test message');

$logger->poll('March::Logger');

done_testing;
