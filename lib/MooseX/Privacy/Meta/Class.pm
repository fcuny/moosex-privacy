package MooseX::Privacy::Meta::Class;

use Moose::Role;
use Moose::Meta::Class;

with qw/MooseX::Privacy::Meta::Class::Private
    MooseX::Privacy::Meta::Class::Protected/;

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
