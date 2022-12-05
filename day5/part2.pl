use v5.10;
use strict;
use warnings;

my $stack_num;
my @crates;
my @stacks;

my @input = <>;
map {chomp} @input;

foreach (@input) {
    if ($_ =~ /(\d+) $/) {
        $stack_num = $1;
        last;
    }
    push @crates, $_;
}

while (@crates) {
    my $line = pop @crates;
    foreach my $stack (0 .. ($stack_num - 1)) {
        my $crate = substr $line, (1 + (4 * $stack)), 1;
        push @{$stacks[$stack]} , $crate if ($crate ne " ");
    }
}

foreach (@input) {
    if ($_ =~ /move (\d+) from (\d+) to (\d+)/) {
        my @move_crates;
        map {push @move_crates, pop @{$stacks[$2 - 1]}} (1 .. $1);
        map {push @{$stacks[$3 - 1]} , $move_crates[((scalar @move_crates) - 1) - $_]} (0 .. (scalar @move_crates) - 1);
    }
}

map {print pop @{$stacks[$_]}} ( 0 .. ($stack_num -1));