use strict;
use warnings;
use Test::More;

my $self = bless { move_allowance => 59 }, 'March::Attribute::MoveAllowance';

BEGIN { use_ok 'March::Attribute::MoveAllowance' }

is $self->move_allowance, 59, 'move_allowance()';

done_testing();
