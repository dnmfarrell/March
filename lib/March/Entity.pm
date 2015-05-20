package March::Entity;
use Role::Tiny::With;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental';

with 'March::Component::Id';

=head1 NAME

March::Entity - the base class for all entities

=cut

sub new ($class) { bless {}, $class }

1;
