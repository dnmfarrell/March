use strict;
use warnings;
use Test::More;

my $self = bless { id => 5 }, 'March::Attribute::Id';

BEGIN { use_ok 'March::Attribute::Id' }

is $self->id, 5, 'id()';

done_testing();
