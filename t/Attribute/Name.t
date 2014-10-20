use strict;
use warnings;
use Test::More;
use Test::Exception;

my $self = bless {}, 'March::Attribute::Name';

BEGIN { use_ok 'March::Attribute::Name' }

ok $self->name('Mad Jack'), 'Set name';
is $self->name, 'Mad Jack', 'Get name';
dies_ok { $self->name('fuck') } 'Profane name croaks';

done_testing();
