use v5.10;
use strict;
use warnings;

my $score = 0;
while (<>) {
    if ($_ =~/(\w) (\w)/) {
            my $o_choice = $1;
            my $choice = $2;

        if ($choice eq "Y") {
            $score += 3;
            $score += 1 if ($o_choice eq "A");
            $score += 2 if ($o_choice eq "B");
            $score += 3 if ($o_choice eq "C");
        }
        if ($choice eq "X") {
            $score += 3 if ($o_choice eq "A");
            $score += 1 if ($o_choice eq "B");
            $score += 2 if ($o_choice eq "C");
        }
        if ($choice eq "Z") {
            $score += 6;
            $score += 2 if ($o_choice eq "A");
            $score += 3 if ($o_choice eq "B");
            $score += 1 if ($o_choice eq "C");

        }
    }
}

say $score;