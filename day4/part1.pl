use v5.10;
use strict;
use warnings;

my $score = 0;
while (<>) {
    if ($_ =~/(\d+)-(\d+),(\d+)-(\d+)/) {
        $score++ if (($1  >= $3 and $2 <= $4) or ($3  >= $1 and $4 <= $2));
    }
}
say $score;