use v5.10;
use strict;
use warnings;

my $x = 1;
my $cycle = 0;
my $signal_strength = 0;

while (<>) {
    chomp;
    if ($_ =~ /noop/) {
        ($cycle, $signal_strength) = updateCycle($cycle, $signal_strength, $x);
       
    }
    if ($_ =~ /addx ([\d-]+)/) {
        ($cycle, $signal_strength) = updateCycle($cycle, $signal_strength, $x);
        ($cycle, $signal_strength) = updateCycle($cycle, $signal_strength, $x);
        $x += $1;

    }
}
say $signal_strength;

sub updateCycle {
    my ($cycle, $signal_strength, $x) = @_;

    $cycle++;
    $signal_strength += ($cycle * $x) if (!(($cycle + 20) % 40));

    return ($cycle, $signal_strength);
}