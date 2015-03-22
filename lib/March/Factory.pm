package March::Factory;
use Role::Tiny;
use warnings;
use strict;
use feature 'signatures';
no warnings 'experimental';

=head1 DESCRIPTION

This class is a factory for creating entity classes.

=cut

=head2 mint_class ($class, [$components])

Mints a new class composed with the roles in C<$components>, which must be an arrayref of L<March::Component> names.

=cut

sub mint_class ($self, $class, $components)
{
  die 'mint_class must be called with an arrayref of March::Components' unless ref $components eq 'ARRAY';
  Role::Tiny->create_class_with_roles($class, @$components);
}

=head2 mint_object ($class, [$components])

Mints a new object composed with the roles in C<$components>, which must be an arrayref of L<March::Component> names.

=cut

sub mint_object ($self, $class, $components)
{
  die 'mint_object must be called with an arrayref of March::Components' unless ref $components eq 'ARRAY';
  my $composed_class = Role::Tiny->create_class_with_roles($class, @$components);
  bless {}, $composed_class;
}

1;
