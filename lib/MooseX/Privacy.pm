package MooseX::Privacy;

our $VERSION = '0.01';

use Moose::Exporter;

Moose::Exporter->setup_import_methods(
    with_caller => [qw( private protected )], );

sub private {
    my ( $caller, $name, $body ) = @_;
    $caller->meta->add_private_method( $name, $body );
}

sub protected {
    my ( $caller, $name, $body ) = @_;
    $caller->meta->add_protected_method( $name, $body );
}

sub init_meta {
    my ( $me, %options ) = @_;

    my $for = $options{for_class};
    Moose->init_meta(%options);

    Moose::Util::MetaRole::apply_metaclass_roles(
        for_class       => $for,
        metaclass_roles => [ 'MooseX::Privacy::Meta::Class', ],
    );
}

1;
__END__

=head1 NAME

MooseX::Privacy - Provides syntax to enable privacy on your methods

=head1 SYNOPSIS

  use MooseX::Privacy;

  private foo => sub {
    return 23;
  };

  protect bar => sub {
    return 42;
  };

=head1 DESCRIPTION

MooseX::Privacy is

=head1 AUTHOR

franck cuny E<lt>franck.cuny@rtgi.frE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
