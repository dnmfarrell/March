use strict;
use warnings;
use Test::More;
use Role::Tiny;

with 'March::Component::PostMsgQueue';

BEGIN { use_ok 'March::Logger' }

ok my $logger = March::Logger->new,  'Constructor';

#Poll once to subscribe to msg queue
$logger->poll;

# post test msg to logger queue
post(bless({}, 'A::Class'), 'March::Logger', 'test message');

$logger->poll;

done_testing;
