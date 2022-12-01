use v5.10;
use strict;
use warnings;

my $count = 0;
my @max;

while (<>) {
    if ($_ =~/(\d+)/) {
        $count += $1;
    }
    else {
        push @max, $count;
        $count = 0 ;
    }
}

my @s = sort { $b <=> $a } @max;
say ($s[0] + $s[1] + $s[2]);