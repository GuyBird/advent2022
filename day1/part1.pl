use v5.10;
use strict;
use warnings;

my $count = 0;
my $max = 0;

while (<>) {
    if ($_ =~/(\d+)/) {
        $count += $1;
    } 
    else {
        if ($max < $count) {
            $max = $count;
        }
        $count = 0;
    }
}

say $max;