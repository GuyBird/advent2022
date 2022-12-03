use v5.10;
use strict;
use warnings;
use List::MoreUtils qw(uniq);

my $score = 0;
while (<>) {
    chomp;

    substr($_, (length($_)/ 2), 0) = '-';
    my @backpack = split '-', $_;
    map {$backpack[$_] = [split //, $backpack[$_]]} (0 .. 1);

    my %seen = map { $_ => 1 } @{$backpack[0]};
    my @intersection = grep { $seen{$_} } @{$backpack[1]};
    
    foreach my $x (uniq @intersection) {
        $score += (ord($x) - 96) if ($x =~/([a-z])/);
        $score += (ord($x) - 38) if ($x =~/([A-Z])/);
    }
}

say $score;