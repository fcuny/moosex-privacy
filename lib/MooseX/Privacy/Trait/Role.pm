package MooseX::Privacy::Trait::Role;

use MooseX::Role::Parameterized;

parameter name => ( isa => 'Str', required => 1, );

role {
    my $p         = shift;
    my $role_name = "MooseX::Privacy::Meta::Attribute::" . ucfirst($p->name);

    around accessor_metaclass => sub {
        my ( $orig, $self, @rest ) = @_;

        return Moose::Meta::Class->create_anon_class(
            superclasses => [ $self->$orig(@_) ],
            roles        => [$role_name],
            cache        => 1
        )->name;
    };
};

1;
__END__

=head1 NAME

MooseX::Privacy::Trait::Role

=head1 SYNOPSIS

=head1 METHODS

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
