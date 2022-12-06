use v5.10;
use strict;
use warnings;
use List::MoreUtils qw(uniq);

my @input = <>;
map {chomp} @input;

my @stream = split //, $input[0];
my $score;
my $markers = 14;

for my $i ( ($markers - 1) .. (scalar @stream) - 1) {
    my @seen;
    map {push @seen, $stream[$i - $_]} (0 .. ($markers - 1));

    if (scalar(uniq(@seen)) == $markers) {
        $score = $i + 1;
        last;
    }

}

say $score;