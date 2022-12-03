use v5.10;
use strict;
use warnings;
use List::MoreUtils qw(uniq);

my @input = <>;
map {$_ =~ s/\R//g} @input;

my $score = 0;
my $group_size = 3;
for my $i (0 .. scalar @input - 1 ) {
    next unless ($i % $group_size == 0);

    my @backpack;
    map {push @backpack, [split //, $input[$_]]} ($i .. $i + ($group_size - 1));

    my @intersection = @{$backpack[0]};
    for my $j ( 1 .. ($group_size - 1)) {
        my %seen = map { $_ => 1 } @{$backpack[$j]};
        my @new_intersection = grep { $seen{$_} } @intersection;
        @intersection = @new_intersection;
    }

    foreach my $x (uniq @intersection) {
        $score += (ord($x) - 96) if ($x =~/([a-z])/);
        $score += (ord($x) - 38) if ($x =~/([A-Z])/);
    }
}

say $score;