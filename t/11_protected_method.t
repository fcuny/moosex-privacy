use strict;
use warnings;

use Test::More tests => 7;
use Test::Exception;

{

    package Foo;
    use Moose;
    use MooseX::Privacy;

    protected_method 'bar' => sub {
        my $self = shift;
        return 'baz';
    };
}

{

    package Bar;
    use Moose;
    extends 'Foo';

    sub baz {
        my $self = shift;
        return $self->bar;
    }

    sub add_public_method {
        my $self = shift;
        $self->meta->add_method(
            'public_foo',
            sub {
                $self->protected_meta_method;
            }
        );
    }

}

my $foo = Foo->new();
isa_ok( $foo, 'Foo' );
dies_ok { $foo->bar } "... can't call bar, method is protected";

my $bar = Bar->new();
isa_ok( $bar, 'Bar' );
is $bar->baz(), 'baz', "... got the good value from &bar";

is scalar @{ $foo->meta->local_protected_methods }, 1,
    '... got one protected method';

my $protected_method = Class::MOP::Method->wrap(
    sub { return 23 },
    name         => 'protected_meta_method',
    package_name => 'Foo'
);

$foo->meta->add_protected_method($protected_method);

dies_ok { $foo->protected_meta_method } '... can\'t call the protected method';

$bar->add_public_method;
is $bar->public_foo, 23, '... call protected method via public method';
