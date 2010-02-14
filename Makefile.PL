use inc::Module::Install;
name 'MooseX-Privacy';
all_from 'lib/MooseX/Privacy.pm';

requires 'Moose';
requires 'Scalar::Util';

tests 't/*.t';
author_tests 'xt';

author 'Franck Cuny';
license 'perl';
readme_from 'lib/MooseX/Privacy.pm';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
