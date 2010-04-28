package MooseX::Privacy::Meta::Class;

use Moose::Role;
use Moose::Meta::Class;

with (
    'MooseX::Privacy::Meta::Class::Role' => { name => 'protected' },
    'MooseX::Privacy::Meta::Class::Role' => { name => 'private' },
);

package Moose::Meta::Attribute::Custom::Trait::Private;
sub register_implementation {'MooseX::Privacy::Trait::Private'}

package Moose::Meta::Attribute::Custom::Trait::Protected;
sub register_implementation {'MooseX::Privacy::Trait::Protected'}


1;
__END__

=head1 NAME

MooseXMooseX::Privacy::Meta::Class

=head1 SYNOPSIS

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
