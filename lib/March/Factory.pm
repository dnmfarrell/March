package March::Factory;
use Role::Tiny;
use warnings;
use strict;
use feature 'signatures';
no warnings 'experimental';

=head1 DESCRIPTION

This class is a factory for creating entity classes.

=cut

=head2 mint_class ( $class, @components )

Mints a new class composed with the roles in C<@components>, which must be an array of L<March::Component> names.

=cut

sub mint_class ($self, $class, @components)
{
  Role::Tiny->create_class_with_roles($class, @components);
}

=head2 mint_object ( @components )

Mints a new object composed with the roles in C<@components>, which must be an array of L<March::Component> names.

=cut

sub mint_object ($self, @components)
{
  bless {}, $self->mint_class('March::Entity', @components);
}

1;
