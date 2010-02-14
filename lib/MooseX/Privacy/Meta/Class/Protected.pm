package MooseX::Privacy::Meta::Class::Protected;

use Scalar::Util;
use Carp qw/confess/;
use Moose::Role;
use MooseX::Types::Moose qw/Str ArrayRef/;
use MooseX::Privacy::Meta::Method::Protected;

has local_protected_methods => (
    traits     => ['Array'],
    is         => 'ro',
    isa        => ArrayRef [Str],
    required   => 1,
    default    => sub { [] },
    auto_deref => 1,
    handles    => { '_push_protected_method' => 'push' },
);

sub add_protected_method {
    my ( $self, $method_name, $method ) = @_;

    my $protected_method
        = blessed $method
        ? $method
        : MooseX::Privacy::Meta::Method::Protected->wrap(
        name         => $method_name,
        package_name => $self->name,
        body         => $method
        );

    confess $method_name . " is not a protected method"
        unless $protected_method->isa(
        'MooseX::Privacy::Meta::Method::Protected');

    $self->add_method( $protected_method->name, $protected_method );
    $self->_push_protected_method( $protected_method->name );
}

1;
__END__

=head1 NAME

MooseX::Privacy::Meta::Class::Protected

=head1 SYNOPSIS

=head1 METHODS

=head2 local_protected_methods

=head2 add_protected_method

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
