package MooseX::Privacy::Meta::Attribute::Private;

use Moose::Role;
use Carp qw/confess/;
use MooseX::Types::Moose qw/Str ArrayRef/;

sub _generate_accessor_method {
    my $self = shift;
    my $attr = $self->associated_attribute;

    my $package_name = $attr->associated_class->name;
    my $class = $attr->associated_class->name->meta;
    if ( $class->meta->has_attribute('local_private_attributes') ) {
        $class->_push_private_attribute( $attr->name );
    }

    return sub {
        my $self   = shift;
        my $caller = ( scalar caller() );
        confess "Attribute " . $attr->name . " is private"
            unless $caller eq $package_name;
        $attr->set_value( $self, $_[0] ) if scalar @_;;
        $attr->get_value($self);
    };
}

1;
__END__

=head1 NAME

MooseX::Privacy::Meta::Attribute::Private

=head1 SYNOPSIS

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
