package MooseX::Privacy::Meta::Class::Role;

use MooseX::Role::Parameterized;
use Scalar::Util;
use Carp qw/confess/;
use MooseX::Types::Moose qw/Str ArrayRef/;
use MooseX::Privacy::Meta::Method::Protected;
use MooseX::Privacy::Meta::Method::Private;

parameter name => ( isa => 'Str', required => 1, );

role {
    my $p = shift;

    my $name             = $p->name;
    my $local_methods    = "local_" . $name . "_methods";
    my $local_attributes = "local_" . $name . "_attributes";
    my $push_method      = "_push_" . $name . "_method";
    my $push_attribute   = "_push_" . $name . "_attribute";
    my $meta_method      = "add_" . $name . "_method";

    has $local_methods => (
        traits     => ['Array'],
        is         => 'ro',
        isa        => ArrayRef [Str],
        required   => 1,
        default    => sub { [] },
        auto_deref => 1,
        handles    => { $push_method => 'push' },
    );

    has $local_attributes => (
        traits     => ['Array'],
        is         => 'ro',
        isa        => ArrayRef [Str],
        required   => 1,
        default    => sub { [] },
        auto_deref => 1,
        handles    => { $push_attribute => 'push' },
    );

    method $meta_method => sub {
        my ( $self, $method_name, $method ) = @_;

        my $class = "MooseX::Privacy::Meta::Method::" . ( ucfirst $name );

        my $custom_method = blessed $method ? $method : $class->wrap(
            name         => $method_name,
            package_name => $self->name,
            body         => $method
        );

        confess $method_name . " is not a " . $name . " method"
            unless $custom_method->isa($class);

        $self->add_method( $custom_method->name, $custom_method );
        $self->$push_method( $custom_method->name );
    };
};

1;
__END__

=head1 NAME

MooseX::Privacy::Meta::Class::Role

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

  $object->meta->add_private_method('foo', MooseX::Privacy::Meta::Method::Priva
te->wrap(name => 'foo', package_name => 'Foo', body => sub {return 23});

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
