use v5.10;
use strict;
use warnings;

my $score = 0;
while (<>) {
    if ($_ =~/(\d+)-(\d+),(\d+)-(\d+)/) {
        my (@first, @second);

        map {push @first, $_ } ($1 .. $2);
        map {push @second, $_ } ($3 .. $4);

        my %seen = map { $_ => 1 } @first;
        my @intersection = grep { $seen{$_} } @second;

        $score +=1 if (scalar @intersection);
    }

}
say $score;