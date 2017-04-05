#!/usr/bin/perl -- # -*- Perl -*-

my @lines = ();
while (<>) {
    chop;
    push (@lines, $_);
}

my $found = 0;
my $done = 0;
while (!$done) {
    $_ = shift @lines;
    $found = 1 if /^\s*$/;
    if ($found && !/^\s*$/) {
	$done = 1;
	unshift (@lines, $_);
    }
}

$found = 0;
$done = 0;
while (!$done) {
    $_ = pop @lines;
    $found = 1 if /^\s*$/;
    if ($found && !/^\s*$/) {
	$done = 1;
	push (@lines, $_);
    }
}

foreach my $line (@lines) {
    print "$line\n";
}
