use strict;
use warnings;

use Test::More tests => 9;
use Test::Exception;

{

    package Foo;
    use Moose;
    use MooseX::Privacy;

    private_method 'bar' => sub {
        my $self = shift;
        return 'baz';
    };

    sub baz {
        my $self = shift;
        return $self->bar;
    }

    sub foo {
        my $self = shift;
        return $self->foobar(shift);
    }

    private_method 'foobar' => sub {
        my $self = shift;
        my $str  = shift;
        return 'foobar' . $str;
    };

    sub add_public_method {
        my $self = shift;
        $self->meta->add_method(
            'public_foo',
            sub {
                $self->private_meta_method;
            }
        );
    }

}

{

    package Bar;
    use Moose;
    extends 'Foo';

    sub newbar {
        my $self = shift;
        return $self->bar;
    }
}

my $foo = Foo->new();
isa_ok( $foo, 'Foo' );
dies_ok { $foo->bar } "... can't call bar, method is private";
is $foo->baz, 'baz', "... got the good value from &baz";
is $foo->foo('baz'), 'foobarbaz', "... got the good value from &foobar";

my $bar = Bar->new();
isa_ok( $bar, 'Bar' );
dies_ok { $bar->newbar() } "... can't call bar, method is private";

is scalar @{ $foo->meta->local_private_methods }, 2,
    '... got two privates method';

my $private_method = Class::MOP::Method->wrap(
    sub { return 23 },
    name         => 'private_meta_method',
    package_name => 'Foo'
);

$foo->meta->add_private_method($private_method);

dies_ok { $foo->private_meta_method } '... can\'t call the private method';

$foo->add_public_method;
is $foo->public_foo, 23, '... call private method via public method';
