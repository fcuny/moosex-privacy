package MooseX::Privacy;

our $VERSION = '0.01';

use Moose::Exporter;

Moose::Exporter->setup_import_methods(
    with_meta => [qw( private_method protected_method )], );

sub private_method {
    my ( $meta, $name, $body ) = @_;
    $meta->add_private_method($name, $body);
}

sub protected_method {
    my ( $meta, $name, $body ) = @_;
    $meta->add_protected_method($name, $body);
}

sub init_meta {
    my ( $me, %options ) = @_;

    my $for = $options{for_class};
    Moose->init_meta(%options);

    Moose::Util::MetaRole::apply_metaroles(
        for_class       => $for,
        metaclass_roles => [ 'MooseX::Privacy::Meta::Class', ],
    );
}

package Moose::Meta::Attribute::Custom::Trait::Private;
sub register_implementation { 'MooseX::Privacy::Trait::Private' }

package Moose::Meta::Attribute::Custom::Trait::Protected;
sub register_implementation { 'MooseX::Privacy::Trait::Protected' }

1;
__END__

=head1 NAME

MooseX::Privacy - Provides the syntax to restrict/control visibility of your methods

=head1 SYNOPSIS

  use MooseX::Privacy;

  private_method foo => sub {
    return 23;
  };

  protected_method bar => sub {
    return 42;
  };

=head1 DESCRIPTION

MooseX::Privacy brings the concept of private and protected methods to your class.

=head1 METHODS

=head2 Private

When you declare a method as B<private>, this method can be called only within the class.

    package Foo;

    use Moose;
    use MooseX::Privacy;

    private_method foo => sub { return 23 };

    sub mul_by_foo { my $self = shift; $self->foo * $_[0] }

    1;

    my $foo = Foo->new;
    $foo->foo; # die
    $foo->mul_by_foo;  # ok

=head2 Protected

When you declare a method as B<protected>, this method can be called only
within the class AND any of it's subclasses.

    package Foo;

    use Moose;
    use MooseX::Privacy;

    protected_method foo => sub { return 23 };

    package Bar;

    use Moose;
    extends Foo;

    sub bar { my $self = shift; $self->foo }

    1;

    my $foo = Foo->new;
    $foo->foo; # die
    my $bar = Bar->new;
    $bar->bar;  # ok

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
