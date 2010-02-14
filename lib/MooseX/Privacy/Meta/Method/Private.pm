package MooseX::Privacy::Meta::Method::Private;

use Moose;
extends 'Moose::Meta::Method';

use Carp qw/confess/;

sub wrap {
    my $class = shift;
    my %args  = @_;

    my $method       = delete $args{body};
    my $private_code = sub {
        confess "The "
            . $args{package_name} . "::"
            . $args{name}
            . " method is private"
            unless ( scalar caller() ) eq $args{package_name};

        goto &{$method};
    };
    $args{body} = $private_code;
    $class->SUPER::wrap(%args);
}

1;
__END__

=head1 NAME

MooseX::Privacy::Meta::Method::Private

=head1 SYNOPSIS

=head1 METHODS

=head2 wrap

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
