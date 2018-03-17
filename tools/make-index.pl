#!/usr/bin/perl

# This script builds the index page

use strict;
use English;

my %MONTHS = ('Jan' => 1, 'Feb' => 2, 'Mar' => 3, 'Apr' => 4, 'May' => 5, 'Jun' => 6,
              'Jul' => 7, 'Aug' => 8, 'Sep' => 9, 'Oct' => 10, 'Nov' => 11, 'Dec' => 12);

my %branches = ();

opendir (DIR, ".");
while (my $name = readdir(DIR)) {
    if (-d $name && -d "$name/head") {
        open (LOG, "git log $name/head |");
        while (<LOG>) {
            chop;
            if (/^Date:\s*(.*?)\s*$/) {
                my $date = $1;
                die unless $date =~ /... (...) (\d+) (\d+:\d+:\d+) (\d+) ([\+\-]\d\d)(\d\d)/;
                my $year = $4;
                my $month = $MONTHS{$1} || die "Not a month? $1\n";
                my $day = $2;
                my $time = $3;
                my $tz = "$5:$6";
                $date = sprintf ("%04d-%02d-%02dT%s%s", $year, $month, $day, $time, $tz);
                $branches{$name} = $date;
                last;
            }
        }
        close (LOG);
    }
}

print <<HEADER1;
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>XProc 3.0 Specifications</title>
<meta charset="utf-8" />
</head>
<body>
<h1>XProc 3.0 Specifications</h1>
<ul>
HEADER1

print "<li><a href='master/head'>master</a>, ", $branches{'master'}, "</li>\n";

foreach my $branch (sort { $branches{$b} cmp $branches{$a} } keys %branches) {
    next if $branch eq 'master';
    my $date = $branches{$branch};
    print "<li><a href='$branch/head'>$branch</a>, $date</li>\n";
}

print <<HEADER2;
</ul>
</body>
</html>
HEADER2
