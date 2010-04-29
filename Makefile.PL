use inc::Module::Install;
name 'MooseX-Privacy';
all_from 'lib/MooseX/Privacy.pm';

requires 'Moose';
requires 'Scalar::Util';
requires 'MooseX::Role::Parameterized';
requires 'MooseX::Types';

tests 't/*.t';
author_tests 'xt';

license 'perl';
readme_from 'lib/MooseX/Privacy.pm';

build_requires 'Test::More';
use_test_base;
auto_include;
author_tests 'xt';
auto_set_repository;
WriteAll;
