use warnings;
use strict;
use Test::More;
use Scalar::Util 'blessed';

BEGIN { use_ok 'March::Factory' }

# mint class
ok my $entity_class
  = March::Factory->mint_class('March::Entity', ['March::Component::Direction']);
ok my $entity_obj = bless {}, $entity_class;
ok $entity_obj->isa('March::Entity');

# mint object
ok my $entity
  = March::Factory->mint_object('March::Entity', ['March::Component::Direction']);
ok blessed $entity;
ok $entity->isa('March::Entity');

done_testing;
