use strict;
use warnings;

use Test::More;
use Test::MinimumVersion;
all_minimum_version_ok( qq{5.006} , { skip => [qw(t/given_when.t t/when.t)] });
