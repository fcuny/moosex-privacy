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

=head2 local_private_methods

=head2 add_private_method

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

