use v5.10;
use strict;
use warnings;

my $x = 1;
my $cycle = 0;

while (<>) {
    chomp;
    if ($_ =~ /noop/) {
        $cycle = drawPixel($cycle, $x);        
    }
    if ($_ =~ /addx ([\d-]+)/) {
        $cycle = drawPixel($cycle, $x); 
        $cycle = drawPixel($cycle, $x); 
        $x += $1;
    }
}


sub drawPixel {
    my ($cycle, $x) = @_;
    $cycle++;

    my $pos = $cycle % 40;
    $pos = 40 if (!($cycle % 40));
    ($x <= $pos and ($x + 2) >= $pos) ? print '#' : print '.';

    print "\n" if ($pos == 40);
    return $cycle;
}