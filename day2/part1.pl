use v5.10;
use strict;
use warnings;

my $score = 0;
while (<>) {
    if ($_ =~/(\w) (\w)/) {
        my $o_choice = $1;
        my $choice = $2;
    
        if ($choice eq "Y") {
            $score += 2;
            $score += 6 if ($o_choice eq "A");
            $score += 3 if ($o_choice eq "B");

        }
        if ($choice eq "X") {
            $score += 1;
            $score += 6 if ($o_choice eq "C");
            $score += 3 if ($o_choice eq "A");

        }
        if ($choice eq "Z") {
            $score += 3;
            $score += 6 if ($o_choice eq "B");
            $score += 3 if ($o_choice eq "C");
        }
    }
}

say $score;