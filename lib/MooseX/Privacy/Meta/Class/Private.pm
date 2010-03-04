package MooseX::Privacy::Meta::Class::Private;

use Scalar::Util;
use Carp qw/confess/;
use Moose::Role;
use MooseX::Types::Moose qw/Str ArrayRef/;
use MooseX::Privacy::Meta::Method::Private;

has local_private_methods => (
    traits     => ['Array'],
    is         => 'ro',
    isa        => ArrayRef [Str],
    required   => 1,
    default    => sub { [] },
    auto_deref => 1,
    handles    => { '_push_private_method' => 'push' },
);

has local_private_attributes => (
    traits     => ['Array'],
    is         => 'ro',
    isa        => ArrayRef [Str],
    required   => 1,
    default    => sub { [] },
    auto_deref => 1,
    handles    => { '_push_private_attribute' => 'push' },
);

sub add_private_method {
    my ( $self, $method_name, $method ) = @_;

    my $private_method
        = blessed $method
        ? $method
        : MooseX::Privacy::Meta::Method::Private->wrap(
        name         => $method_name,
        package_name => $self->name,
        body         => $method
        );

    confess 'not a private method'
        unless $private_method->isa('MooseX::Privacy::Meta::Method::Private');

    $self->add_method( $private_method->name, $private_method );
    $self->_push_private_method( $private_method->name );
}

1;

__END__

=head1 NAME

MooseX::Privacy::Meta::Class::Private

=head1 SYNOPSIS

=head1 METHODS

=head2 local_private_attributes

Arrayref of all private attributes

  my $private_attributes = $self->meta->local_private_attributes;

=head2 local_private_methods

Arrayref of all private methods

  my $private_methods = $self->meta->local_private_methods;

=head2 add_private_method

Add a private method to your object.

  $object->meta->add_private_method('foo', sub { return 23 });

or

  $object->meta->add_private_method('foo', MooseX::Privacy::Meta::Method::Private->wrap(name => 'foo', package_name => 'Foo', body => sub {return 23});

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

