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
    my $count_methods    = "_count_" . $name . "_methods";
    my $count_attributes = "_count_" . $name . "_attributes";

    my $meta_method = "add_" . $name . "_method";

    has $local_methods => (
        traits     => ['Array'],
        is         => 'ro',
        isa        => ArrayRef [Str],
        required   => 1,
        default    => sub { [] },
        auto_deref => 1,
        handles    => { $push_method => 'push', $count_methods => 'count' },
    );

    has $local_attributes => (
        traits     => ['Array'],
        is         => 'ro',
        isa        => ArrayRef [Str],
        required   => 1,
        default    => sub { [] },
        auto_deref => 1,
        handles =>
            { $push_attribute => 'push', $count_attributes => 'count' },
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

MooseX::Privacy::Meta::Class::Role - Private and Protected parameterized roles

=head1 SYNOPSIS

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
