use v5.10;
use strict;
use warnings;

my $knots = 10;
my @rope;
map { push @rope, [(0) x 2] } (1 .. $knots);

my %tail_visits;

while (<>) {
    chomp;
    if ($_ =~ /([RULD]) (\d+)/) {
        my $dir = $1;
        for (1 .. $2) {
            for (1 .. (scalar @rope) - 1) {
                my ($end,$beg);
                $end = 1 if ($_ == (scalar @rope) - 1);
                $beg = 1 if ($_ == 1);
                ($rope[$_ - 1], $rope[$_]) = moveRope($dir, $rope[$_ - 1], $rope[$_], $beg, $end);
            }
        }
    }
}
say scalar keys %tail_visits;

sub moveRope {
    my ($dir, $head, $tail, $beg, $end) = @_;

    $head->[1]++ if ($dir eq "U" and $beg);
    $head->[1]-- if ($dir eq "D" and $beg);
    $head->[0]++ if ($dir eq "R" and $beg);
    $head->[0]-- if ($dir eq "L" and $beg);

    if (abs($tail->[0] - $head->[0]) > 1 or abs($tail->[1] - $head->[1]) > 1) {
        if ($tail->[0] < $head->[0]) {
            $tail->[0] = $tail->[0] + 1;
        } 
        if ($tail->[0] > $head->[0]) {
            $tail->[0] = $tail->[0] - 1;
        }
        if ($tail->[1] < $head->[1]) {
            $tail->[1] = $tail->[1] + 1;
        } 
        if ($tail->[1] > $head->[1]) {
            $tail->[1] = $tail->[1] - 1;
        }
    }

    if ($end) {
        my $tail_visit = $tail->[0] . "," . $tail->[1];
        $tail_visits{$tail_visit} = 1;
    }

    return ($head, $tail);
}