package MooseX::Privacy::Meta::Attribute::Protected;

use Moose::Role;
use Carp qw/confess/;

with 'MooseX::Privacy::Meta::Attribute::Privacy' => {level => 'protected'};

sub _check_protected {
    my ($meta, $caller, $attr_name, $package_name, $object_name) = @_;
    confess "Attribute " . $attr_name . " is protected"
      unless $caller eq $object_name
          or $caller->isa($package_name);
}

1;

__END__

=head1 NAME

MooseX::Privacy::Meta::Attribute::Protected

=head1 SYNOPSIS

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
